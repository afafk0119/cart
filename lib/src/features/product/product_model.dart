import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> productData) {
    if (productData.isEmpty) {
      // Handle the case where the map is empty, if necessary.
      return ProductModel(
          id: 0,
          title: '',
          price: 0.0,
          description: '',
          category: '',
          image: '',
          rating: RatingModel(rate: 0.0, count: 0));
    }

    return ProductModel(
      id: productData['id'] ?? 0,
      title: productData['title'] ?? '',
      price: productData['price']?.toDouble() ?? 0.0,
      description: productData['description'] ?? '',
      category: productData['category'] ?? '',
      image: productData['image'] ?? '',
      rating: RatingModel.fromJson(
          productData['rating'] ?? {'rate': 0.0, 'count': 0}),
    );
  }
}

@HiveType(typeId: 1)
class RatingModel {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate']?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }
}
