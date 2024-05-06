import 'package:flutter/material.dart';
import 'previous_list.dart';
import 'upcoming_list.dart';

class ReservationPage extends StatelessWidget {
  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  const ReservationPage({super.key});
  @override
  Widget build(BuildContext context) {
    double padding = 10;

    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding, top: 15),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // toolbarHeight: 20,
          title: Text(
            "My Reservations",
            style: myCustomStyle,
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Previous"),
              ]),
            ),
            body: TabBarView(children: [
              UpcomingList(),
              PreviousList(),
            ]),
          ),
        ),
      ),
    );
  }
}
