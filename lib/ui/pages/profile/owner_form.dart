import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RestaurantForm extends StatefulWidget {
  const RestaurantForm({super.key});

  @override
  State<RestaurantForm> createState() => _RestaurantFormState();
}

class MenuItem {
  String? name;
  double? price;
  File? image;

  MenuItem({this.name, this.price, this.image});
}

class _RestaurantFormState extends State<RestaurantForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<MenuItem> _menuItems = [];

  Future<void> _addMenuItem(BuildContext context) async {
    String? name;
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    price = double.tryParse(value)!;
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
                    _menuItems
                        .add(MenuItem(name: name, price: price, image: image));
                  });
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

  String _restaurantName = '';
  int _lowPrice = 0;
  int _highPrice = 0;
  final List<String> _options = ['Dine-in', 'Takeaway', 'Delivery'];
  TimeOfDay _openingTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _closingTime = const TimeOfDay(hour: 20, minute: 0);
  String _location = '';
  String _phoneNumber = '';
  String _email = '';
  String _overview = '';
  File? _image;
  bool _imageSelected = false;

  final _restaurantNameController = TextEditingController();
  final _lowPriceController = TextEditingController();
  final _highPriceController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _overviewController = TextEditingController();

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageSelected = true;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Process or submit the form data
      print('Restaurant Name: ${_restaurantNameController.text}');
      print(
          'Prices: ${_lowPriceController.text} to ${_highPriceController.text}');
      print('Options: $_options');
      print('Opening Hours: $_openingTime to $_closingTime');
      print('Location: ${_locationController.text}');
      print('Phone Number: ${_phoneNumberController.text}');
      print('Email: ${_emailController.text}');
      print('Overview: ${_overviewController.text}');
      for (var menuItem in _menuItems) {
        print(
            ' - Name: ${menuItem.name}, Price: ${menuItem.price}, Image path: ${menuItem.image?.path}');
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Form'),
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
                    onSaved: (value) {
                      _restaurantName = value!;
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter the low price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _lowPrice = int.parse(value!);
                          },
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter the high price';
                            } else if (int.parse(value!) <= _lowPrice) {
                              return 'Invalid high price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _highPrice = int.parse(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('Dine-in'),
                    value: _options.contains('Dine-in'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _options.add('Dine-in');
                        } else {
                          _options.remove('Dine-in');
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('Takeaway'),
                    value: _options.contains('Takeaway'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _options.add('Takeaway');
                        } else {
                          _options.remove('Takeaway');
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('Delivery'),
                    value: _options.contains('Delivery'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _options.add('Delivery');
                        } else {
                          _options.remove('Delivery');
                        }
                      });
                    },
                  ),
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
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 10, minute: 0));
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
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 20, minute: 0));
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
                SizedBox(
                  height: height,
                  child: TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                      prefix: Text("Location: "),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
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
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter the phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumber = value!;
                    },
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
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _overviewController,
                  decoration: const InputDecoration(
                      labelText: 'Overview (max 250 characters)'),
                  maxLength: 250,
                  maxLines: 3,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter an overview';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _overview = value!;
                  },
                ),
                const Text("Restaurant Image:", style: TextStyle(fontSize: 17)),
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: _imageSelected
                        ? Image.file(
                            _image!,
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
                    child: const Text("Add a new item")),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
