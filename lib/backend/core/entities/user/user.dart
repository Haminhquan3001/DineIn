import 'package:group_project/backend/core/entities/restaurant/restaurant.dart';
import 'package:group_project/backend/core/entities/user/credit_card.dart';
import 'package:group_project/backend/core/entities/reservation/reservation.dart';

class User {
  // guest properties
  String id;
  String name;
  String email;

  String? phone;
  String? avatarUrl;
  CreditCard? credicard;
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
    this.phone,
    this.avatarUrl,
    this.credicard,
    this.wishlist = const [],
    this.reservation = const [],

    // owner properties
    this.isOwner = false, // default value false if not provided
    this.ownerRestaurant,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    CreditCard? credicard,
    List<Restaurant>? wishlist,
    List<Reservation>? reservation,
    bool? isOwner,
    Restaurant? ownerRestaurant,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      credicard: credicard ?? this.credicard,
      wishlist: wishlist ?? List.from(this.wishlist),
      reservation: reservation ?? List.from(this.reservation),
      isOwner: isOwner ?? this.isOwner,
      ownerRestaurant: ownerRestaurant ?? this.ownerRestaurant,
    );
  }
}
