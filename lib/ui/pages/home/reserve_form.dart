import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ReserveForm extends StatelessWidget {
  const ReserveForm({super.key});
  @override
  Widget build(BuildContext context) {
    const myCustomStyle = TextStyle(
      color: Color.fromARGB(254, 0, 0, 0),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              children: [
                BackButton(),
                Text(
                  "Reserve a Table",
                  style: myCustomStyle,
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20.0),
            //   child: Text(
            //     "Select Date & Time",
            //     style: myCustomStyle2,
            //   ),
            // ),

            const CustomTableCalendar(),
            const Expanded(
              child: TimeGrid(),
            ),
            const ReserveButton(),
            Container(
              margin: const EdgeInsets.all(8),
              child: const SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({super.key});

  @override
  _CustomTableCalendar createState() => _CustomTableCalendar();
}

class _CustomTableCalendar extends State<CustomTableCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2025, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          // Style the calendar
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 65, 55).withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Display the selected date (optional)
        if (_selectedDay != null)
          Text(
            'Selected Date: ${_selectedDay!.toIso8601String()}',
            style: const TextStyle(fontSize: 10.0),
          ),
      ],
    );
  }
}

class TimeGrid extends StatelessWidget {
  const TimeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List times = [
      "10:00 AM",
      "11:00 AM",
      "12:00 PM",
      "01:00 PM",
      "02:00 PM",
      "03:00 PM",
      "04:00 PM",
      "05:00 PM",
      "06:00 PM",
    ];
    return Scaffold(
        body: GridView.builder(
      itemCount: times.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TimeCard(time: times[index]),
        );
      },
    ));
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({super.key, required this.time});
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class ReserveButton extends StatelessWidget {
  const ReserveButton({super.key});
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
                builder: (context) => const ReserveForm(),
              ),
            );
          },
          child: const Text(
            "Confirm",
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
