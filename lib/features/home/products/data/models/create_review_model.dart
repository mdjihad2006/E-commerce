class CreateReviewModel {
  final String product;
  final int rating;
  final String comment;

  CreateReviewModel({
    required this.product,
    required this.rating,
    required this.comment,

  });

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'rating': rating.toString(), // send as string if API expects string
      'comment': comment,
    };
  }
}
