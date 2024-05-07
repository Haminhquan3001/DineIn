import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/toggle_icon_button.dart';
import 'restaurant_info.dart';
import 'package:provider/provider.dart';
import 'package:group_project/providers/reserve_form.provider.dart';

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
    double fontSizeName = 18, fontSizeLocation = 12, fontSizeOther = 14;
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
              color: const Color.fromARGB(57, 24, 73, 109),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      resObj["image_url"].toString(),
                      height: 100,
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
                            initialValue: favorite,
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
                        style: TextStyle(
                          color: const Color.fromARGB(254, 0, 0, 0),
                          fontSize: fontSizeName,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      resObj["rating"].toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(254, 0, 0, 0),
                        fontSize: fontSizeOther,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      resObj["address"].toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(254, 0, 0, 0),
                        fontSize: fontSizeLocation,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.attach_money,
                    color: Colors.black,
                    size: 18,
                  ),
                  Text(
                    resObj["min_price"].toString(),
                    style: TextStyle(
                      color: const Color.fromARGB(254, 0, 0, 0),
                      fontSize: fontSizeOther,
                      fontWeight: FontWeight.w700,
                    ),
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
