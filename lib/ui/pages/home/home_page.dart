import 'package:flutter/material.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List _foundRestanrants = [];
  List _restaurantsFiltered = [];

  @override
  initState() {
    super.initState();
    fetchRestaurants();
  }

  Future fetchRestaurants() async {
    try {
      final response = await Supabase.instance.client
          .from('restaurants')
          .select('*, food_categories(*), reviews(*, users(*))');

      setState(() => _foundRestanrants = response);
      setState(() => _restaurantsFiltered = response);
    } on Exception catch (e) {
      if (mounted) {
        showKwunSnackBar(context: context, message: e.toString());
      }
    }
  }

  void _runFilter(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = _foundRestanrants;
    } else {
      results = _foundRestanrants
          .where((res) => res["restaurant_name"]
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _restaurantsFiltered = results;
    });
  }

  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    double padding = 10;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
        ),
        // bottomNavigationBar: const BottomNavBar(),
        body: Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "Explore Restaurants",
                  style: myCustomStyle,
                ),
              ),

              // Search Bar
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search for a restaurant',
                    suffixIcon: Icon(Icons.search)),
              ),

              const SizedBox(
                height: 5,
              ),

              // Restaurant List
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _restaurantsFiltered.length,
                    itemBuilder: ((context, index) {
                      var resObj = _restaurantsFiltered[index];
                      return RestaurantCard(
                        resObj: resObj,
                        favorite: false,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
