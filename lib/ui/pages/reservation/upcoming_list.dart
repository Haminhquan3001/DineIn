import 'package:flutter/material.dart';
import 'reservation_class.dart';

class UpcomingList extends StatelessWidget {
  final List<Reservation> reservations = [
    Reservation(
        "Parallel 37", "Ikeja, Lagos", "Sunday, 23rd June", "8:15pm", 4),
    Reservation(
        "Yin and Yummy", "Ikeja, Lagos", "Friday, 18th March", "8:30pm", 3),
  ];

  //Might need to sort the list based on the date

  UpcomingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reservation.name,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700)),
                  Text(reservation.location),
                  Text('${reservation.numGuests} guests'),
                  Text('${reservation.date} - ${reservation.time}'),
                  Row(
                    children: [
                      const Expanded(child: Text("")),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.red, width: 2),
                            ),
                            child: const Text(
                              'Cancel Booking',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

