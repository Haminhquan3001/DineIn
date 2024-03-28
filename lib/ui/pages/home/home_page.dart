import 'package:flutter/material.dart';
import 'restaurant_card.dart';

class HomePage extends StatelessWidget {
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
      "image": "assets/restaurants/res3.webp",
      "name": "Sizzling Steakhouse",
      "ratings": 4.9,
      "location": "Baltimore, MD",
      "price": "20-31",
    },
    {
      "image": "assets/restaurants/res4.jpeg",
      "name": "Simply Vegan",
      "ratings": 4.8,
      "location": "Annapolis, MD",
      "price": "32-45",
    },
    {
      "image": "assets/restaurants/res5.jpg",
      "name": "The Noodle Bar",
      "ratings": 4.3,
      "location": "Alexandria, VA",
      "price": "50-52",
    },
    {
      "image": "assets/restaurants/res1.jpeg",
      "name": "Oyster Bay Seafood",
      "ratings": 4.6,
      "location": "Virginia Beach, VA",
      "price": "25-37",
    },
    {
      "image": "assets/restaurants/res2.avif",
      "name": "Sushi Symphony",
      "ratings": 4.4,
      "location": "Richmond, VA",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res3.webp",
      "name": "Mountain Grill",
      "ratings": 4.1,
      "location": "Charlottesville, VA",
      "price": "20-40",
    },
    {
      "image": "assets/restaurants/res4.jpeg",
      "name": "Taste of Asia",
      "ratings": 4.8,
      "location": "Frederick, MD",
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
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double padding = 30;

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
                "Explore Restaurants",
                style: myCustomStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(235, 189, 209, 210),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: 280,
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Search for a restaurant",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Text(""),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(235, 189, 209, 210),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.filter_alt,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Color(0xffF5F5F5)),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: res_info.length,
                  itemBuilder: ((context, index) {
                    var resObj = res_info[index];
                    return RestaurantCard(
                      resObj: resObj,
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
