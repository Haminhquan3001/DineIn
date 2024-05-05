import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List res_info = [
    {
      "image": "assets/restaurants/res1.jpeg",
      "name": "Little Italy Trattoria",
      "ratings": 4.7,
      "location": "College Park, MD",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res2.avif",
      "name": "Spicy Curry House",
      "ratings": 4.5,
      "location": "Washington D.C.",
      "price": "30-35",
    },
    {
      "image": "assets/restaurants/res3.webp",
      "name": "Sizzling Steakhouse",
      "ratings": 4.9,
      "location": "Baltimore, MD",
      "price": "20-31",
    },
    {
      "image": "assets/restaurants/res4.jpeg",
      "name": "Simply Vegan",
      "ratings": 4.8,
      "location": "Annapolis, MD",
      "price": "32-45",
    },
    {
      "image": "assets/restaurants/res5.jpg",
      "name": "The Noodle Bar",
      "ratings": 4.3,
      "location": "Alexandria, VA",
      "price": "50-52",
    },
    {
      "image": "assets/restaurants/res1.jpeg",
      "name": "Oyster Bay Seafood",
      "ratings": 4.6,
      "location": "Virginia Beach, VA",
      "price": "25-37",
    },
    {
      "image": "assets/restaurants/res2.avif",
      "name": "Sushi Symphony",
      "ratings": 4.4,
      "location": "Richmond, VA",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res3.webp",
      "name": "Mountain Grill",
      "ratings": 4.1,
      "location": "Charlottesville, VA",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res4.jpeg",
      "name": "Taste of Asia",
      "ratings": 4.8,
      "location": "Frederick, MD",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res5.jpg",
      "name": "Crepe Cafe",
      "ratings": 4.2,
      "location": "Arlington, VA",
      "price": "20-40",
    },
  ];

  List _foundRestanrants = [];

  @override
  initState() {
    _foundRestanrants = res_info;
    super.initState();
  }

  void _runFilter(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = res_info;
    } else {
      results = res_info
          .where((res) =>
              res["name"].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundRestanrants = results;
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
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search for a restaurant',
                    suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _foundRestanrants.length,
                    itemBuilder: ((context, index) {
                      var resObj = _foundRestanrants[index];
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



                  // Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     height: 40,
                  //     width: 40,
                  //     child: const Icon(
                  //       Icons.filter_alt,
                  //     )),
