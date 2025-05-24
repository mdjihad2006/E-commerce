import 'package:bazario/data/modals/user_modal.dart';
import 'package:bazario/features/common/data/product_model.dart';

class GetReviewModel {
  final String id;
  final ProductModel productModel;
  final UserModel userModel;

  final String comment;
  final DateTime createdAt;

  GetReviewModel({
    required this.id,
    required this.productModel,
    required this.userModel,

    required this.comment,
    required this.createdAt,

  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) {
    return GetReviewModel(
      id: json['_id'],
      productModel: ProductModel.fromJson(json['product']),
      userModel: UserModel.fromJson(json['user']),
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
