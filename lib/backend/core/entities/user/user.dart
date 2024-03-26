import 'package:group_project/backend/core/entities/restaurant/restaurant.dart';
import 'package:group_project/backend/core/entities/user/credit_card.dart';
import 'package:group_project/backend/core/entities/reservation/reservation.dart';

class User {
  // guest properties
  String id;
  String name;
  String email;
  String phone;
  String? imageUrl;
  CreditCard credicard;
  List<Restaurant> wishlist;
  List<Reservation> reservation;

  // owner properties
  bool isOwner;
  Restaurant? ownerRestaurant;

  User({
    // guest properties
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
    required this.credicard,
    this.wishlist = const [],
    this.reservation = const [],

    // owner properties
    this.isOwner = false, // default value false if not provided
    this.ownerRestaurant,
  });
}
