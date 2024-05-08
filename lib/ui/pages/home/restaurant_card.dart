import 'dart:convert';
import 'package:flutter/material.dart';
import 'restaurant_info.dart';
import 'package:provider/provider.dart';

import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/toggle_icon_button.dart';
import 'package:group_project/ui/utils/format_address.dart';

class RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> resObj;
  final bool favorite;
  const RestaurantCard({
    super.key,
    required this.resObj,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double padding = 10;
    final theme = Provider.of<ThemeProvider>(context);
    // check if this restaurant is favorite
    List<dynamic> favoriteRestaurants =
        jsonDecode(KwunLocalStorage.getString("favorites"));
    bool isFavorite = favoriteRestaurants.any(
        (element) => element["restaurant_name"] == resObj["restaurant_name"]);

    return TextButton(
      onPressed: () {
        // save ther restaurant object to the provider
        context.read<ReserveFormProvider>().updateRestaurantObject(resObj);

        context
            .read<ReserveFormProvider>()
            .updateCurrentRestaurant(resObj["restaurant_name"]);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantInfo(
              resObj: resObj,
            ),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
              color: theme.isDarkTheme
                  ? const Color.fromARGB(255, 170, 144, 204)
                  : const Color.fromARGB(57, 24, 73, 109),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(149, 157, 165, 0.2),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ]),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      resObj["image_url"].toString(),
                      height: 110,
                      width: contextWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(""),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ToggleHeartIconButton(
                            initialValue: isFavorite,
                            onChanged: (bool isToggled) {
                              // get from data from localstorage
                              String favoriteRestaurantsString =
                                  KwunLocalStorage.getString("favorites");

                              List<dynamic> favoriteRestaurants =
                                  jsonDecode(favoriteRestaurantsString);

                              // either save to favorites
                              if (isToggled) {
                                favoriteRestaurants.add(resObj);
                              }

                              // or remove from favorites
                              else {
                                // remove by name
                                favoriteRestaurants.removeWhere(
                                    (curr) => curr["id"] == resObj["id"]);
                              }

                              // save new data
                              KwunLocalStorage.setString(
                                  "favorites", jsonEncode(favoriteRestaurants));
                            },
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        resObj["restaurant_name"],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 215, 207, 7),
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      resObj["rating"].toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      formatAddressToStateAndCity(["address"].toString()),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.attach_money,
                    color: theme.isDarkTheme ? Colors.white70 : Colors.black,
                    size: 18,
                  ),
                  Text(
                    "${resObj["min_price"].toString()} - ${resObj["max_price"].toString()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          )),
    );
  }
}
