import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Map resObj;
  const RestaurantCard({
    super.key,
    required this.resObj,
  });

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double padding = 10;
    double padding2 = 30;
    double fontSizeName = 18, fontSizeLocation = 12, fontSizeOther = 14;
    return Padding(
      padding: EdgeInsets.only(left: padding2, right: padding2),
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(57, 24, 73, 109),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  resObj["image"].toString(),
                  width: contextWidth - padding * 2,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(children: [
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
                ]),
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
