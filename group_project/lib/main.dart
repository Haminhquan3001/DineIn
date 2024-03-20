import 'package:flutter/material.dart';
import 'home_page_widgets/restaurant_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dine In',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List res_info = [
    {
      "image": "assets/img/restaurants/res1.jpeg",
      "name": "Little Italy Trattoria",
      "ratings": 4.7,
      "location": "Prince George's County, MD",
      "price": "20-40",
    },
    {
      "image": "assets/img/restaurants/res2.avif",
      "name": "Spicy Curry House",
      "ratings": 4.5,
      "location": "Washington D.C.",
      "price": "30-35",
    },
    {
      "image": "assets/img/restaurants/res3.webp",
      "name": "Sizzling Steakhouse",
      "ratings": 4.9,
      "location": "Baltimore, MD",
      "price": "20-31",
    },
    {
      "image": "assets/img/restaurants/res4.jpeg",
      "name": "Simply Vegan",
      "ratings": 4.8,
      "location": "Annapolis, MD",
      "price": "32-45",
    },
    {
      "image": "assets/img/restaurants/res5.jpg",
      "name": "The Noodle Bar",
      "ratings": 4.3,
      "location": "Alexandria, VA",
      "price": "50-52",
    },
    {
      "image": "assets/img/restaurants/res1.jpeg",
      "name": "Oyster Bay Seafood",
      "ratings": 4.6,
      "location": "Virginia Beach, VA",
      "price": "25-37",
    },
    {
      "image": "assets/img/restaurants/res2.avif",
      "name": "Sushi Symphony",
      "ratings": 4.4,
      "location": "Richmond, VA",
      "price": "20-40",
    },
    {
      "image": "assets/img/restaurants/res3.webp",
      "name": "Mountain Grill",
      "ratings": 4.1,
      "location": "Charlottesville, VA",
      "price": "20-40",
    },
    {
      "image": "assets/img/restaurants/res4.jpeg",
      "name": "Taste of Asia",
      "ratings": 4.8,
      "location": "Frederick, MD",
      "price": "20-40",
    },
    {
      "image": "assets/img/restaurants/res5.jpg",
      "name": "Crepe Cafe",
      "ratings": 4.2,
      "location": "Arlington, VA",
      "price": "20-40",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3F51B5),
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Color(0xffF5F5F5),
          fontSize: 25,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xffF5F5F5)),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 15),
          itemCount: res_info.length,
          itemBuilder: ((context, index) {
            var resObj = res_info[index] as Map? ?? {};
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: RestaurantCard(
                resObj: resObj,
              ),
            );
          }),
        ),
      ),
    );
  }
}
