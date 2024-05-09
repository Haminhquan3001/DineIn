import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';

import '../home/restaurant_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<dynamic> favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    fetchWishListRestaurants();
  }

  void fetchWishListRestaurants() async {
    // get favorite restaurant object from localstorage
    List<dynamic> fvRestaurants =
        jsonDecode(KwunLocalStorage.getString("favorites"));

    // get only the ids of favorites Restaurants
    List<String> favoriteRestaurantIds =
        fvRestaurants.map((restaurant) => restaurant['id'].toString()).toList();

    try {
      final favoriteRestaurantsFromDb = await Future.wait(
          favoriteRestaurantIds.map((id) => Supabase.instance.client
              .from("restaurants")
              .select(
                  "*, food_categories(*), reviews(*, users(*)), menu_items(*)")
              .eq("id", id)
              .single()));

      setState(() => favoriteRestaurants = favoriteRestaurantsFromDb);
    } on Exception catch (e) {
      if (mounted) {
        showKwunSnackBar(context: context, message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double padding = 15;
    final theme = Provider.of<ThemeProvider>(context);
    return SafeArea(
      // backgroundColor: theme.isDarkTheme ? const Color.fromARGB(255, 43, 45, 44) : Colors.grey.shade100,
      // bottomNavigationBar: const BottomNavBar(),
      child: Hero(
        tag: 'wishlist',
        child: Padding(
          padding: EdgeInsets.only(left: padding, right: padding, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "My Wishlist",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.isDarkTheme
                        ? const Color.fromARGB(255, 43, 45, 44)
                        : Colors.white,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: favoriteRestaurants.length,
                    itemBuilder: ((context, index) {
                      var resObj = favoriteRestaurants[index];
                      return RestaurantCard(
                        resObj: resObj,
                        isHomePage: false,
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
