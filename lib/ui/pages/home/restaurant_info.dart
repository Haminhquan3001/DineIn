import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:group_project/ui/pages/home/home_page.dart';
import 'package:group_project/ui/utils/format_address.dart';
import 'package:group_project/ui/utils/format_rating.dart';
import 'package:provider/provider.dart';
import 'overview_reviews.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:group_project/ui/widgets/toggle_icon_button.dart';
import 'package:group_project/providers/theme.provider.dart';

class RestaurantInfo extends StatelessWidget {
  final Map resObj;

  const RestaurantInfo({
    super.key,
    required this.resObj,
  });

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double padding = 18;
    double paddingHeight = 12;
    double padding2 = 20;
    final theme = Provider.of<ThemeProvider>(context);

    double imageHeight = 200;

    // check if this restaurant is favorite
    List<dynamic> favoriteRestaurants =
        context.watch<ReserveFormProvider>().favoriteRestaurants;

    bool isFavorite = favoriteRestaurants.any(
        (element) => element["restaurant_name"] == resObj["restaurant_name"]);

    return Hero(
      tag: 'homepage',
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //image background title
              SizedBox(
                width: contextWidth,
                height: imageHeight,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        resObj["image_url"].toString(),
                        width: contextWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.bottomCenter,
                      height: imageHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withAlpha(0),
                            Colors.black12,
                            const Color.fromARGB(235, 0, 0, 0),
                          ],
                        ),
                      ),
                      child: const Text(""),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.only(left: 5),
                            child: BackButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                color: theme.isDarkTheme
                                    ? Theme.of(context).primaryColor
                                    : Colors.black),
                          ),
                        ),
                        const Expanded(
                          child: Text(""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 40,
                            height: 40,
                            child: ToggleHeartIconButton(
                              initialValue: isFavorite,
                              onChanged: (bool isToggled) {
                                List<dynamic> favoriteRestaurants =
                                    Provider.of<ReserveFormProvider>(context,
                                            listen: false)
                                        .favoriteRestaurants;

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

                                context
                                    .read<ReserveFormProvider>()
                                    .updateFavoriteRestaurants(
                                        favoriteRestaurants);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.only(left: padding2, right: padding2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Restaurant name
                    Text(
                      resObj["restaurant_name"],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    //Short location
                    Row(
                      children: [
                        Text(
                          formatAddressToStateAndCity(resObj["address"]),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(child: Text("")),
                        Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade400,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            formatRating(resObj["rating"].toString()),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(${resObj["reviews_count"]} Reviews)",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ]),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "${resObj["food_categories"]["category_name"].toString().replaceRange(0, 1, resObj["food_categories"]["category_name"].toString().substring(0, 1).toUpperCase())} Restaurant",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        //Opening Hours
                        if (resObj["working_start"] != null)
                          Row(
                            children: [
                              Icon(
                                Icons.query_builder,
                                color: theme.isDarkTheme
                                    ? const Color.fromARGB(255, 170, 144, 204)
                                    : const Color.fromARGB(255, 242, 87, 87),
                              ),
                              SizedBox(width: padding),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opening Hours",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${resObj["working_start"]} - ${resObj["working_end"]}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              )
                            ],
                          ),

                        SizedBox(
                          height: paddingHeight,
                        ),
                        //Detailed locations
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: theme.isDarkTheme
                                  ? const Color.fromARGB(255, 170, 144, 204)
                                  : const Color.fromARGB(255, 242, 87, 87),
                            ),
                            SizedBox(width: padding),
                            Expanded(
                              child: Text(
                                resObj["address"],
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: paddingHeight,
                        ),

                        //Phone number
                        if (resObj["phone"] != null)
                          Row(
                            children: [
                              Icon(
                                Icons.local_phone_outlined,
                                color: theme.isDarkTheme
                                    ? const Color.fromARGB(255, 170, 144, 204)
                                    : const Color.fromARGB(255, 242, 87, 87),
                              ),
                              SizedBox(width: padding),
                              Text(
                                resObj["phone"] ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: paddingHeight,
                        ),

                        //Email
                        if (resObj["email"] != null)
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: theme.isDarkTheme
                                    ? const Color.fromARGB(255, 170, 144, 204)
                                    : const Color.fromARGB(255, 242, 87, 87),
                              ),
                              SizedBox(width: padding),
                              Text(
                                resObj["email"],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 280,
                      width: contextWidth,
                      child: OverviewAndReviews(
                        resObj: resObj,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
