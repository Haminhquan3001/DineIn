import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'overview_reviews.dart';

import 'package:group_project/config/constants.dart';
import 'package:group_project/providers/theme.provider.dart';

class RestaurantInfo extends StatelessWidget {
  final Map resObj;
  const RestaurantInfo({
    super.key,
    required this.resObj,
  });

  @override
  Widget build(BuildContext context) {
    log.d(resObj);

    double contextWidth = MediaQuery.of(context).size.width;
    double padding = 18;
    double paddingHeight = 12;
    double padding2 = 20;
    double fontSizeName = 20;
    final theme = Provider.of<ThemeProvider>(context);

    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

    double imageHeight = 200;
    return Scaffold(
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
                          child: BackButton(color: theme.isDarkTheme ? Theme.of(context).primaryColor : Colors.black),
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
                          child: Icon(Icons.favorite_border, color: theme.isDarkTheme ? Theme.of(context).primaryColor : Colors.black),
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
                    // style: TextStyle(
                    //   color: const Color.fromARGB(254, 0, 0, 0),
                    //   fontSize: fontSizeName,
                    //   fontWeight: FontWeight.w800,
                    // ),
                  ),

                  //Short location
                  Row(
                    children: [
                      Text(
                        resObj["address"]
                            .toString()
                            .split(',')
                            .sublist(1)
                            .join(', '),
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
                          resObj["rating"].toString(),
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
                    resObj["food_categories"]["category_name"]
                        .toString()
                        .replaceRange(
                            0,
                            1,
                            resObj["food_categories"]["category_name"]
                                .toString()
                                .substring(0, 1)
                                .toUpperCase()),
                    style: Theme.of(context).textTheme.bodyLarge,
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
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "${resObj["working_start"]} - ${resObj["working_end"]}",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resObj["address"],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              // Text("View on map"),
                            ],
                          )
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
    );
  }
}
