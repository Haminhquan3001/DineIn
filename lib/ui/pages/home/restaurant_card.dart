import 'package:flutter/material.dart';
import 'restaurant_info.dart';
import 'package:provider/provider.dart';
import 'package:group_project/providers/reserve_form.provider.dart';

class RestaurantCard extends StatelessWidget {
  final Map resObj;
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
        context
            .read<ReserveFormProvider>()
            .updateCurrentRestaurant(resObj["name"]);
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
                    child: Image.asset(
                      resObj["image"].toString(),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 30,
                          height: 30,
                          child: Icon(
                              favorite
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border,
                              color: favorite ? Colors.red : Colors.black),
                        ),
                      ),
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
                        resObj["name"],
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
                      resObj["ratings"].toString(),
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
                      resObj["location"].toString(),
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
                    resObj["price"].toString(),
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
