class Reservation {
  String id;
  String restaurantId;
  String? userId;
  DateTime startDate;
  DateTime endDate;
  int? guests;
  bool isReserved;
  DateTime createdAt;
  
  Reservation({
    required this.id,
    required this.endDate,
    this.userId,
    required this.restaurantId,
    required this.startDate,
    required this.guests,
    this.isReserved = false,
    required this.createdAt,
  });
}
