import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:provider/provider.dart';
import '../home/restaurant_card.dart';

class WishlistPage extends StatelessWidget {
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
      "image": "assets/restaurants/res2.avif",
      "name": "Sushi Symphony",
      "ratings": 4.4,
      "location": "Richmond, VA",
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
  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    double padding = 10;

    return Scaffold(
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
                "My Wishlist",
                style: myCustomStyle,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: res_info.length,
                  itemBuilder: ((context, index) {
                    var resObj = res_info[index];
                    return RestaurantCard(
                      resObj: resObj,
                      favorite: true,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
