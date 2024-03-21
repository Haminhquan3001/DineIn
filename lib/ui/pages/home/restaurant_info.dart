import 'package:flutter/material.dart';
import 'overview_reviews.dart';

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
    double fontSizeName = 20;

    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

    double imageHeight = 220;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
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
                    child: Image.asset(
                      resObj["image"].toString(),
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
                          child: const BackButton(),
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
                          child: const Icon(Icons.favorite_border),
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
                    resObj["name"],
                    style: TextStyle(
                      color: const Color.fromARGB(254, 0, 0, 0),
                      fontSize: fontSizeName,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  //Short location
                  Text(
                    resObj["location"].toString(),
                    style: myCustomStyle,
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  //ratings + total reviews
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      resObj["ratings"].toString(),
                      style: myCustomStyle,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "(52 reviews)",
                      style: myCustomStyle,
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Dine-in | Takeaway | Delivery",
                    style: myCustomStyle,
                  ),

                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //Opening Hours
                      Row(
                        children: [
                          const Icon(Icons.query_builder),
                          SizedBox(width: padding),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Opening Hours",
                                style: myCustomStyle,
                              ),
                              Text(
                                "10am-11pm",
                                style: myCustomStyle,
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
                          const Icon(Icons.location_on_outlined),
                          SizedBox(width: padding),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "19231 Knox Road, College Park, MD",
                                style: myCustomStyle,
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
                      Row(
                        children: [
                          const Icon(Icons.local_phone_outlined),
                          SizedBox(width: padding),
                          Text(
                            "0902119229",
                            style: myCustomStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: paddingHeight,
                      ),
                      //Email
                      Row(
                        children: [
                          const Icon(Icons.email_outlined),
                          SizedBox(width: padding),
                          Text(
                            "bejose@cooking.gmail.com",
                            style: myCustomStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    width: contextWidth,
                    child: const OverviewAndReviews(),
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
