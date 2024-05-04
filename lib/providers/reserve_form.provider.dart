import 'package:flutter/material.dart';

class ReserveFormProvider with ChangeNotifier {
  String _selectedTime = "";
  String get selectedTime => _selectedTime;

  void updateSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
