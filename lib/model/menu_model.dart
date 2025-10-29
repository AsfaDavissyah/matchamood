class MenuItem {
  final int id;
  final String name;
  final String category;
  final int price;
  final String currency;
  final String image;
  final String description;
  final bool isFavorite;

  MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.currency,
    required this.image,
    required this.description,
    required this.isFavorite,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: int.parse(json['price'].toString()),
      currency: json['currency'],
      image: json['image'],
      description: json['description'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
