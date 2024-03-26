class MenuItem {
  final String name;
  final String? imageUrl;
  final double price;
  final bool available;

  const MenuItem({
    required this.name,
    this.imageUrl,
    required this.price,
    required this.available,
  });
}
