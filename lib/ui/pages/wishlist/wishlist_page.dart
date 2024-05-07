import 'dart:convert';
import 'package:flutter/material.dart';

import '../home/restaurant_card.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';

class WishlistPage extends StatelessWidget {
  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    // get favorite restaurant object from localstorage
    List<dynamic> favoriteRestaurants =
        jsonDecode(KwunLocalStorage.getString("favorites"));

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
                  itemCount: favoriteRestaurants.length,
                  itemBuilder: ((context, index) {
                    var resObj = favoriteRestaurants[index];
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
