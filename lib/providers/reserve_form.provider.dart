import 'package:flutter/material.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'dart:convert';

class ReserveFormProvider with ChangeNotifier {
  String _selectedTime = "";
  String _currentRestaurant = "";
  DateTime? _selectedDate;
  int _guests = 1;
  Map<String, dynamic> _restaurant = {};

  // getters
  String get selectedTime => _selectedTime;
  String get currentRestaurant => _currentRestaurant;
  DateTime? get selectedDate => _selectedDate;
  int get guest => _guests;
  Map<String, dynamic> get getRestaurantObj => _restaurant;

  // setters
  void updateSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void updateCurrentRestaurant(String name) {
    _currentRestaurant = name;
    notifyListeners();
  }

  void updateSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  void updateGuest(int guest) {
    _guests = guest;
    notifyListeners();
  }

  void updateRestaurantObject(Map<String, dynamic> newRestaurant) {
    _restaurant = newRestaurant;
  }

  List<dynamic> _favoriteRestaurants =
      jsonDecode(KwunLocalStorage.getString("favorites"));
  List<dynamic> get favoriteRestaurants => _favoriteRestaurants;

  void updateFavoriteRestaurants(List<dynamic> favRes) {
    _favoriteRestaurants = favRes;
    KwunLocalStorage.setString("favorites", jsonEncode(favRes));
    notifyListeners();
  }
}
