import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'reservation_class.dart';

class PreviousList extends StatelessWidget {
  final List<Reservation> reservations = [
    Reservation(
        "Parallel 37", "Ikeja, Lagos", "Sunday, 23rd June", "8:15pm", 4),
    Reservation(
        "Yin and Yummy", "Ikeja, Lagos", "Friday, 18th March", "8:30pm", 4),
    Reservation(
        "Parallel 37", "Ikeja, Lagos", "Sunday, 23rd June", "8:15pm", 4),
    Reservation(
        "Yin and Yummy", "Ikeja, Lagos", "Friday, 18th March", "8:30pm", 4),
    Reservation(
        "Parallel 37", "Ikeja, Lagos", "Sunday, 23rd June", "8:15pm", 4),
    Reservation(
        "Yin and Yummy", "Ikeja, Lagos", "Friday, 18th March", "8:30pm", 4),
  ];

  PreviousList({super.key});

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
                  Text('${reservation.date} - ${reservation.time}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: Text("")),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReviewPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.orange, width: 2),
                          ),
                          child: const Text(
                            'Rate Us',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
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

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});
  @override
  State<StatefulWidget> createState() => _ReviewPage();
}

class _ReviewPage extends State<ReviewPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? _review;
  double _rating = 3;
  final fieldText = TextEditingController();

  final myCustomStyle = const TextStyle(
    color: Color.fromARGB(254, 0, 0, 0),
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    double padding = 10;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Rate Us", style: myCustomStyle),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Your feedback is important to us.\nHelp us serve you better!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 32.0),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                  },
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 206, 206),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 15, right: 15, top: 5),
                    child: Form(
                      key: _key,
                      child: TextFormField(
                        maxLines: 5,
                        maxLength: 150,
                        controller: fieldText,
                        decoration: const InputDecoration(
                          hintText: 'Write a review',
                          border: InputBorder.none,
                        ),
                        autocorrect: false,
                        obscureText: false,
                        autofocus: false,
                        validator: (value) {
                          if (null == value || value.isEmpty) {
                            return 'No review provided';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _review = newValue;
                        },
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final state = _key.currentState;
                    if (state!.validate()) {
                      setState(() {
                        state.save();
                      });
                    }
                    fieldText.clear();
                    //TODO
                    print(_rating);
                    print(_review);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 216, 50, 38),
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
