import 'package:flutter/material.dart';
import 'reserve_form.dart';

import 'package:group_project/ui/utils/format_date.dart';

class OverviewAndReviews extends StatefulWidget {
  final Map resObj;
  const OverviewAndReviews({
    super.key,
    required this.resObj,
  });

  @override
  State<OverviewAndReviews> createState() => _OverviewAndReviewsState();
}

class _OverviewAndReviewsState extends State<OverviewAndReviews> {
  @override
  build(BuildContext context) {
    List<dynamic> reviews = widget.resObj["reviews"];

    List<dynamic> menuItems = widget.resObj["menu_items"];

    String overview = widget.resObj["description"] ?? "";
    // String overview =  "asd";
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
                ReserveButton(resObj: widget.resObj),
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
                ReserveButton(resObj: widget.resObj),
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
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodObj["image_url"],
              width: widthImage,
              height: heightImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            foodObj["name"].toString(),
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
  final Map resObj;
  const ReserveButton({
    super.key,
    required this.resObj,
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
                builder: (context) => ReserveForm(resObj: resObj),
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
