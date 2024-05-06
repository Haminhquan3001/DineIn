import 'package:flutter/material.dart';

class ReserveFormProvider with ChangeNotifier {
  String _selectedTime = "";
  String get selectedTime => _selectedTime;

  void updateSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  String _currentRestaurant = "";
  String get currentRestaurant => _currentRestaurant;

  void updateCurrentRestaurant(String name) {
    _currentRestaurant = name;
    notifyListeners();
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  int _guests = 1;
  int get guest => _guests;

  void updateGuest(int guest) {
    _guests = guest;
    notifyListeners();
  }
}
