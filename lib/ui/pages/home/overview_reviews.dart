import 'package:flutter/material.dart';
import 'package:group_project/backend/core/entities/restaurant/restaurant.dart';
import 'reserve_form.dart';

class OverviewAndReviews extends StatelessWidget {
  final Map resObj;
  const OverviewAndReviews({
    super.key,
    required this.resObj,
  });

  @override
  build(BuildContext context) {
    List<Map<String, dynamic>> reviews = [
      {
        "user_pic": "assets/restaurants/res1.jpeg",
        "user_full_name": "Jane Smith",
        "ratings": 5.0,
        "time": "2024-03-18| 03:30pm", // Replace with actual review time
        "review":
            "Highly recommend this place! The atmosphere was wonderful and the food was top-notch."
      },
      {
        "user_pic": "assets/users/user2.jpeg",
        "user_full_name": "Alice Williams",
        "ratings": 4.0,
        "time": "2024-03-18| 12:00pm", // Replace with actual review time
        "review": "The food was good, but the service was a bit slow."
      },
      {
        "user_pic": "assets/users/user3.jpeg",
        "user_full_name": "David Miller",
        "ratings": 4.8,
        "time": "2024-03-17| 6:30pm", // Replace with actual review time
        "review":
            "This place is a hidden gem! The food was fresh and flavorful."
      },
      {
        "user_pic": "assets/users/user4.jpeg",
        "user_full_name": "Emily Garcia",
        "ratings": 3.5,
        "time": "2024-03-17| 11:00am", // Replace with actual review time
        "review": "The food was decent, but the portions were a bit small."
      },
      {
        "user_pic": "assets/users/user5.jpeg",
        "user_full_name": "Michael Brown",
        "ratings": 5.0,
        "time": "2024-03-16| 08:00pm", // Replace with actual review time
        "review":
            "Absolutely loved it! The food was amazing and the staff was very attentive."
      },
      {
        "user_pic": "assets/users/user1.jpeg",
        "user_full_name": "John Doe",
        "ratings": 4.5,
        "time": "2024-03-19| 10:00am", // Replace with actual review time
        "review":
            "Great experience! The food was delicious and the service was friendly."
      },
      {
        "user_pic": "assets/users/user2.jpeg",
        "user_full_name": "Sarah Hernandez",
        "ratings": 4.2,
        "time": "2024-03-16| 02:00pm", // Replace with actual review time
        "review":
            "Great place for a casual dinner. The food was good and the prices were reasonable."
      },
      {
        "user_pic": "assets/users/user3.jpeg",
        "user_full_name": "Matthew Johnson",
        "ratings": 3.8,
        "time": "2024-03-15| 07:00pm", // Replace with actual review time
        "review": "The food was okay, but the wait time was a bit long."
      },
      {
        "user_pic": "assets/users/user4.jpeg",
        "user_full_name": "Jennifer Davis",
        "ratings": 4.7,
        "time": "2024-03-15| 12:30pm", // Replace with actual review time
        "review":
            "Delicious food and great service! We will definitely be back."
      },
      {
        "user_pic": "assets/users/user5.jpeg",
        "user_full_name": "William Jones",
        "ratings": 4.1,
        "time": "2024-03-14| 05:00pm", // Replace with actual review time
        "review": "The food was good, but the atmosphere was a bit noisy."
      },
    ];
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

    String overview =
        "Craving a taste of Italy? Little Italy Trattoria in College Park, MD serves authentic Italian cuisine in a warm and welcoming ambiance. Their menu features classic dishes made with fresh ingredients, making it a crowd favorite with a 4.7 star rating.";
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
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
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(overview)),
                ),
                const Expanded(child: Text("")), //Reserve button
                ReserveButton(
                ),
              ],
            ),
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
                ReserveButton(
                ),
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
  const ReviewCard({
    super.key,
    required this.reviewObj,
  });

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
                child: Image.asset(
                  reviewObj["user_pic"],
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
                    reviewObj["user_full_name"],
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
                      reviewObj["ratings"].toString(),
                      style: myCustomStyle,
                    ),
                  ]),
                ],
              )
            ],
          ),
          Text(
            reviewObj["time"].toString(),
          ),
          Text(
            reviewObj["review"].toString(),
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
            style: myCustomStyle,
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
  const ReserveButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 152, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReserveForm(),
              ),
            );
          },
          child: const Text(
            "Reserve a Table",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
