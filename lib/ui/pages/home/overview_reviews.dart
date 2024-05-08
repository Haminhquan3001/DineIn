import 'package:flutter/material.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:group_project/ui/utils/format_date.dart';
import 'package:provider/provider.dart';
import 'reserve_form.dart';

class OverviewAndReviews extends StatelessWidget {
  final Map resObj;
  const OverviewAndReviews({
    super.key,
    required this.resObj,
  });

  @override
  build(BuildContext context) {
    List<dynamic> reviews = resObj["reviews"];

    // TODO replace this
    List<Map<String, dynamic>> menuItems = [
      {
        "food_image": "assets/dishes/food1.jpeg",
        "food_name": "Classic Cheese Pizza",
        "price": 10.99
      },
      {
        "food_image": "assets/dishes/food2.jpeg",
        "food_name": "All-American Cheeseburger",
        "price": 12.50
      },
      {
        "food_image": "assets/dishes/food3.webp",
        "food_name": "Penne Alfredo",
        "price": 14.25
      },
      {
        "food_image": "assets/dishes/food5.jpg",
        "food_name": "Chopped Salad with Grilled Chicken",
        "price": 13.99
      },
      {
        "food_image": "assets/dishes/food6.jpeg",
        "food_name": "Buffalo Wings",
        "price": 9.99
      },
      {
        "food_image": "assets/dishes/food7.jpeg",
        "food_name": "Fish and Chips",
        "price": 16.50
      },
      {
        "food_image": "assets/dishes/food8.jpeg",
        "food_name": "Ribeye Steak",
        "price": 24.95
      },
      {
        "food_image": "assets/dishes/food9.jpeg",
        "food_name": "California Roll",
        "price": 8.75
      },
      {
        "food_image": "assets/dishes/food10.webp",
        "food_name": "Pad Thai",
        "price": 15.25
      },
    ];

    String overview = resObj["description"] ?? "";
    // String overview =  "asd";
    final theme = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Overview',
              ),
              Tab(
                text: 'Reviews',
              ),
              Tab(
                text: 'Menu',
              ),
            ],
            labelColor: theme.isDarkTheme
                ? const Color.fromARGB(255, 170, 144, 204)
                : const Color.fromARGB(255, 242, 87, 87),
            unselectedLabelColor:
                theme.isDarkTheme ? Colors.white : Colors.black,
            indicatorColor: theme.isDarkTheme
                ? const Color.fromARGB(255, 170, 144, 204)
                : const Color.fromARGB(255, 242, 87, 87),
          ),
        ),
        body: TabBarView(
          children: [
            // Overview
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        overview,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                const Expanded(child: Text("")), //Reserve button
                ReserveButton(resObj: resObj),
              ],
            ),

            //Reviews
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: ((context, index) {
                var reviewObj = reviews[index];
                return ReviewCard(
                  reviewObj: reviewObj,
                );
              }),
            ),

            // TODO Menu: replace with actual data
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F5F5),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menuItems.length,
                      itemBuilder: ((context, index) {
                        var foodObj = menuItems[index];
                        return FoodCard(
                          foodObj: foodObj,
                        );
                      }),
                    ),
                  ),
                ),
                ReserveButton(resObj: resObj),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Map reviewObj;
  final Map user;

  ReviewCard({
    super.key,
    required this.reviewObj,
  }) : user = reviewObj["users"];

  @override
  Widget build(BuildContext context) {
    double padding = 10;

    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  user["avatar_url"] ??
                      "https://static.vecteezy.com/system/resources/thumbnails/020/911/740/small_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: padding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user["full_name"],
                    style: myCustomStyle,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      reviewObj["rating"].toString(),
                      style: myCustomStyle,
                    ),
                  ]),
                ],
              )
            ],
          ),
          Text(formatDate(reviewObj["created_at"])),
          Text(
            reviewObj["content"].toString(),
          )
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Map foodObj;
  const FoodCard({
    super.key,
    required this.foodObj,
  });

  @override
  Widget build(BuildContext context) {
    double widthImage = 200;
    double heightImage = 110;
    var myCustomStyle = const TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    
    return Container(
      color: const Color.fromARGB(57, 24, 73, 109),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              foodObj["food_image"],
              width: widthImage,
              height: heightImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            foodObj["food_name"].toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "\$${foodObj["price"]}",
          ),
        ],
      ),
    );
  }
}

class ReserveButton extends StatelessWidget {
  final Map resObj;
  const ReserveButton({
    super.key,
    required this.resObj,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.isDarkTheme
            ? const Color.fromARGB(255, 170, 144, 204)
            : const Color.fromARGB(255, 242, 87, 87),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReserveForm(resObj: resObj),
              ),
            );
          },
          child: Text(
            "Reserve a Table",
            style: Theme.of(context).textTheme.bodyLarge,
            // style: TextStyle(
            //   color: Colors.white,
            //   fontWeight: FontWeight.w700,
            //   fontSize: 16,
            // ),
          ),
        ),
      ),
    );
  }
}
