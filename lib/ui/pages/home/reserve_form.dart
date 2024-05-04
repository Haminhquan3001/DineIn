import 'package:flutter/material.dart';
import 'package:group_project/providers/reserve_form.provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
            const CustomTableCalendar(),
            const Expanded(
              child: TimeGrid(),
            ),
            const ReserveButton(),
            Container(
              margin: const EdgeInsets.all(2),
              child: const SizedBox(
                height: 10,
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
    _selectedDay = context.watch<ReserveFormProvider>().selectedDate;
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
            context.read<ReserveFormProvider>().updateSelectedDate(selectedDay);
            setState(() {
              //update selected state here
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
      ],
    );
  }
}

class TimeGrid extends StatelessWidget {
  const TimeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    String openingTime = "9:00 AM";
    String closingTime = "9:00 PM";

    List<String> times = generateTimeSlots(openingTime, closingTime);
    return Scaffold(
        body: GridView.builder(
      itemCount: times.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0),
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
    final String selectedTime =
        context.watch<ReserveFormProvider>().selectedTime;
    final bool selected = selectedTime.compareTo(time) == 0;
    return TextButton(
      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
      onPressed: () {
        context.read<ReserveFormProvider>().updateSelectedTime(time);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.orange : Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: selected ? Colors.orange : Colors.black,
            ),
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
    final selectedTime = context.watch<ReserveFormProvider>().selectedTime;
    final selectedDate = context.watch<ReserveFormProvider>().selectedDate;

    bool checkSelectedTimeAndDate() {
      if (selectedTime.isEmpty || selectedDate == null) {
        return false;
      } else {
        return true;
      }
    }

    return TextButton(
      onPressed: () {
        if (checkSelectedTimeAndDate()) {
          showDialog(
            context: context,
            builder: (context) => const ConfirmDialog(),
          );
        } else {
          const snackBar = SnackBar(
            content: Center(
              child: Text(
                "Please select both date & time",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.black54,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 152, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
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

List<String> generateTimeSlots(String openingTime, String closingTime) {
  List<String> timeSlots = [];

  List openTokens = openingTime.split(":");
  int openTime = int.parse(openTokens[0]);
  String openP = openTokens[1].split(" ")[1];
  String currTime = "";

  while (currTime.compareTo(closingTime) != 0) {
    currTime = "$openTime:00 $openP";
    timeSlots.add(currTime);
    openTime += 1;
    if (openTime == 12) {
      openP = "PM";
    }
    if (openTime > 12) {
      openTime -= 12;
    }
  }

  return timeSlots;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final String selectedTime = context
        .watch<ReserveFormProvider>()
        .selectedTime
        .replaceAll("AM", "a.m.")
        .replaceAll("PM", "p.m.");
    final DateTime? selectedDate =
        context.watch<ReserveFormProvider>().selectedDate;

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 198, 192, 152),
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30),
                child: Text(
                  "Your reservation will be at\n$selectedTime on ${DateFormat.yMMMMd().format(selectedDate!)}.",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Expanded(child: Text("")),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 14, left: 14),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color.fromARGB(255, 192, 26, 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Expanded(child: Text("")),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 14, left: 14),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Color.fromARGB(255, 28, 84, 16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                      onPressed: () {
                        const snackBar = SnackBar(
                          content: Center(
                            child: Text(
                              "Thank you! Your reservation is confirmed.",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop(); //TODO
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
