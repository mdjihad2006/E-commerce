class WishlistItem {
  final String id;
  final String title;
  final double price;
  final String image;

  WishlistItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['_id'],
      title: json['title'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'],
    );
  }
}
