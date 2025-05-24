class ProductModel {
  final String id;
  final String title;
  final int regularPrice;
  final int currentPrice;
  final double rating;
  final List<String> photos;
  final List<String> sizes;
  final List<String> colors;
  final int availableQuantity;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.regularPrice,
    required this.currentPrice,
    required this.rating,
    required this.photos,
    required this.sizes,
    required this.colors,
    required this.availableQuantity,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    // Handle possible nulls in the response
    List<dynamic> photoList = jsonData['photos'] ?? [];
    List<dynamic> sizeList = jsonData['sizes'] ?? [];
    List<dynamic> colorList = jsonData['colors'] ?? [];

    return ProductModel(
      id: jsonData['_id'] ?? '',
      title: jsonData['title'] ?? '',
      regularPrice: jsonData['regular_price'] ?? 0,  // Default to 0 if null
      currentPrice: jsonData['current_price'] ?? 0, // Default to 0 if null
      rating: (jsonData['rating'] != null) ? (jsonData['rating'] as num).toDouble() : 0.0, // Default to 0.0 if null
      photos: List<String>.from(photoList),
      sizes: List<String>.from(sizeList),
      colors: List<String>.from(colorList),
      availableQuantity: jsonData['quantity'] ?? 0,  // Default to 0 if null
      description: jsonData['description'] ?? '',  // Default to empty string if null
    );
  }
}
