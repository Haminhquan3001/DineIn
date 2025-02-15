import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:group_project/ui/utils/format_time_of_day.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';

class MenuItem {
  String id;
  String? name;
  String? description;
  double? price;
  File? image;

  MenuItem(
      {required this.id, this.name, this.description, this.price, this.image});
}

class RestaurantForm extends StatefulWidget {
  const RestaurantForm({super.key});

  @override
  State<RestaurantForm> createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addMenuItem(BuildContext context) async {
    String? name;
    String? description;
    double? price;
    File? image;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Menu Item'),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Food Name'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter the food name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    price = double.tryParse(value) ?? 0.0;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Food Description'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter the food description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        image = File(pickedFile.path);
                      });
                    }
                  },
                  child: const Text('Select Image'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name != null && price != null && image != null) {
                  setState(() {
                    _menuItems.add(MenuItem(
                      id: const Uuid().v4(),
                      name: name,
                      price: price,
                      description: description,
                      image: image,
                    ));
                  });

                  showKwunSnackBar(
                      context: context,
                      message: "Item added",
                      color: Colors.green);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  String _state = 'MD';

  final List<String> _states = [
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
  ];
  List<dynamic> _foodCategories = [];
  String? _selectedCategoryId;
  final List<MenuItem> _menuItems = [];

  XFile? _image;
  bool _imageSelected = false;
  String _location = "";
  TimeOfDay _openingTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _closingTime = const TimeOfDay(hour: 20, minute: 0);
  final _restaurantNameController = TextEditingController();
  final _lowPriceController = TextEditingController();
  final _highPriceController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _overviewController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getFoodCategories();
  }

  Future<void> _getFoodCategories() async {
    final response = await Supabase.instance.client
        .from('food_categories')
        .select('id, category_name');

    setState(() => _foodCategories = response);
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _imageSelected = true;
      });
    }
  }

  String uppercaseIdentity(String name) {
    return name.trim().split(' ').map((word) {
      if (word.isNotEmpty) {
        return "${word[0].toUpperCase()}${word.substring(1)}".trim();
      } else {
        return "";
      }
    }).join(' ');
  }

  String generateAddress() {
    String address = "";
    if (_streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _zipCodeController.text.isNotEmpty) {
      address =
          "${uppercaseIdentity(_streetController.text)}, ${uppercaseIdentity(_cityController.text)}, $_state ${_zipCodeController.text}";
    }

    return address;
  }

  /// returns an object with restaurant id and image url
  Future<Map<String, String>> _uploadRestaurantImageToBucket() async {
    final String userId = Supabase.instance.client.auth.currentUser!.id;
    final String restaurantId = const Uuid().v4();

    final bytes = await _image!.readAsBytes();
    final fileExt = _image!.path.split('.').last;
    final fileName = '$restaurantId.$fileExt';
    final filePath = '/$userId/restaurant/$fileName';
    const expiresInTenYears = 60 * 60 * 24 * 365 * 10;

    // upload image to supabase bucket
    await Supabase.instance.client.storage
        .from('restaurant_images')
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(contentType: _image!.mimeType),
        );
    // get url
    final imageUrlResponse = await Supabase.instance.client.storage
        .from('restaurant_images')
        .createSignedUrl(filePath, expiresInTenYears);

    return {
      "restaurant_id": restaurantId,
      "image_url": imageUrlResponse,
    };
  }

  Future<String> _uploadMenuItemImageToBucket(MenuItem menuItem) async {
    final String userId = Supabase.instance.client.auth.currentUser!.id;

    final bytes = await menuItem.image!.readAsBytes();
    final fileExt = menuItem.image!.path.split('.').last;
    final fileName = '${menuItem.id}.$fileExt';
    final filePath = '/$userId/menu_items/$fileName';

    // upload image to supabase bucket
    await Supabase.instance.client.storage
        .from('restaurant_images')
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(contentType: _image!.mimeType),
        );

    return filePath;
  }

  Future<Map<String, dynamic>> _getItemJsonToUpload(
      MenuItem item, String restaurantId) async {
    const expiresInTenYears = 60 * 60 * 24 * 365 * 10;
    final path = await _uploadMenuItemImageToBucket(item);
    final imageUrlResponse = await Supabase.instance.client.storage
        .from('restaurant_images')
        .createSignedUrl(path, expiresInTenYears);

    return {
      'id': item.id,
      'name': item.name,
      'description': item.description,
      'price': item.price,
      'available': true,
      'restaurant_id': restaurantId,
      // optional
      'image_url': imageUrlResponse,
    };
  }

  bool customValidator() {
    String message = "";
    bool valid = true;
    if (_restaurantNameController.text.isEmpty) {
      message = "Please enter your restaurant name";
      valid = false;
    } else if (_restaurantNameController.text.length > 50) {
      message = "Your restaurant name is too long";
      valid = false;
    } else if (_lowPriceController.text.isEmpty ||
        _highPriceController.text.isEmpty) {
      message = "Please enter the price range";
      valid = false;
    } else if (double.parse(_lowPriceController.text) >
        double.parse(_highPriceController.text)) {
      message = "Low price cannot be greater than high price";
      valid = false;
    } else if (_selectedCategoryId == null) {
      message = "Please select a category";
      valid = false;
    } else if (_openingTime.hour > _closingTime.hour) {
      message = "Invalid opening/closing hours";
      valid = false;
    } else if (_openingTime.hour == _closingTime.hour &&
        _openingTime.minute > _closingTime.minute) {
      message = "Invalid opening/closing hours";
      valid = false;
    } else if (generateAddress().isEmpty) {
      message = "Please enter your restaurant address";
      valid = false;
    } else if (_zipCodeController.text.length != 5) {
      message = "Please enter 5-digit zip code";
      valid = false;
    } else if (_phoneNumberController.text.isEmpty) {
      message = "Please enter your phone number";
      valid = false;
    } else if (_phoneNumberController.text.length < 10) {
      message = "Please enter a valid phone number";
      valid = false;
    } else if (_emailController.text.isEmpty) {
      message = "Please enter your email address";
      valid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController.text)) {
      message = "Please enter a valid email address";
      valid = false;
    } else if (_overviewController.text.isEmpty) {
      message = "Please write something about your restaurant";
      valid = false;
    } else if (_imageSelected == false) {
      message = "Please select an image for your restaurant";
      valid = false;
    }

    if (!valid) {
      showKwunSnackBar(context: context, message: message, color: Colors.red);
    }

    return valid;
  }

  void _submitForm() async {
    if (customValidator()) {
      // save restaurant image to bucket
      try {
        final Map<String, String> json = await _uploadRestaurantImageToBucket();

        // create a new restaurant to db
        final restaurant = await Supabase.instance.client
            .from('restaurants')
            .insert({
              // required
              'id': json['restaurant_id'],
              'restaurant_name':
                  uppercaseIdentity(_restaurantNameController.text),
              'rating': 2.5,
              'reviews_count': 0,
              'category_id': _selectedCategoryId,
              'address': generateAddress(),

              // optionals
              "owner_id": Supabase.instance.client.auth.currentUser!.id,
              'description': _overviewController.text,
              'location': {}, // in LatLng
              'image_url': json['image_url'],
              'phone': _phoneNumberController.text,
              'email': _emailController.text,
              'min_price': _lowPriceController.text,
              'max_price': _highPriceController.text,
              'working_start': formatTimeOfDay(_openingTime),
              'working_end': formatTimeOfDay(_closingTime),
            })
            .select()
            .single();

        // skip if no menu items
        if (_menuItems.isNotEmpty) {
          final List<Map<String, dynamic>> menuItemsToInsert =
              await Future.wait(
            _menuItems
                .map((item) async =>
                    _getItemJsonToUpload(item, restaurant['id']))
                .toList(),
          );

          // insert menu items to Supabase
          await Supabase.instance.client
              .from('menu_items')
              .insert(menuItemsToInsert);
        }
        if (!mounted) return;

        showKwunSnackBar(
            context: context,
            message: "Your new restaurant has been created 🎉",
            color: Colors.green);
        context.replace('/profile');
      } on Exception catch (e) {
        showKwunSnackBar(context: context, message: "An error occured: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double height = 60;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Restaurant Form',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: height,
                    child: TextFormField(
                      controller: _restaurantNameController,
                      // style: const TextStyle(fontSize: 17),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                        prefix: Text("Name: "),
                        labelText: 'Restaurant Name',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter the restaurant name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: height,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _lowPriceController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                              prefix: Text("Low Price: \$"),
                              labelText: 'Low Price',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: TextFormField(
                            controller: _highPriceController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                              prefix: Text("High Price: \$"),
                              labelText: 'High Price',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),

                  // checkboxes
                  Column(
                    children: _foodCategories
                        .map((category) => RadioListTile(
                              title: Text(category['category_name']!),
                              value: category['id'],
                              groupValue: _selectedCategoryId,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategoryId = value as String?;
                                });
                              },
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: height,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                  context: context, initialTime: _openingTime);
                              if (picked != null) {
                                setState(() {
                                  _openingTime = picked;
                                });
                              }
                            },
                            child: Text(_openingTime != null
                                ? 'Opening: ${_openingTime.format(context)}'
                                : 'Select Opening'),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                  context: context, initialTime: _closingTime);
                              if (picked != null) {
                                setState(() {
                                  _closingTime = picked;
                                });
                              }
                            },
                            child: Text(_closingTime != null
                                ? 'Closing: ${_closingTime.format(context)}'
                                : 'Select Closing'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Location: $_location",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Street'),
                    onChanged: (value) => setState(() {
                      _location = generateAddress();
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                    onChanged: (value) => setState(() {
                      _location = generateAddress();
                    }),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: 'State'),
                    value: _state,
                    onChanged: (value) {
                      setState(() {
                        _state = value!;
                      });
                      _location = generateAddress();
                    },
                    items:
                        _states.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _zipCodeController,
                    decoration: const InputDecoration(labelText: 'Zip Code'),
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    onChanged: (value) => setState(() {
                      _location = generateAddress();
                    }),
                    onSaved: (value) => setState(() {
                      _location = generateAddress();
                    }),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: height,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                        prefix: Text("Phone: "),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: height,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                        prefix: Text("Email: "),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _overviewController,
                    decoration: const InputDecoration(
                        labelText: 'Overview (max 250 characters)'),
                    maxLength: 250,
                    maxLines: 3,
                  ),
                  const Text("Restaurant Image:",
                      style: TextStyle(fontSize: 17)),
                  GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      height: 250,
                      color: Colors.grey[200],
                      child: _imageSelected
                          ? Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Menu Items:',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  if (_menuItems.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _menuItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            final menuItem = _menuItems[index];
                            return ListTile(
                              leading: menuItem.image != null
                                  ? Image.file(
                                      menuItem.image!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                              title: Text(menuItem.name!),
                              subtitle: Text("\$${menuItem.price!}"),
                              // subtitle: Text('\$${menuItem.price.toStringAsFixed(2)}'),
                            );
                          },
                        ),
                      ],
                    ),
                  ElevatedButton(
                      onPressed: () => _addMenuItem(context),
                      child: Text(
                        "Add a new item",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
