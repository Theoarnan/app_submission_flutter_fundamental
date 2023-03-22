import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/menus_model.dart';

class RestaurantDetailModel {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<FoodDrinkCategoriesModel> categories;
  final Menus menus;
  final String rating;
  final List<CustomerReviewModel> customerReviews;

  RestaurantDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: (json['categories'] as List)
            .map((i) => FoodDrinkCategoriesModel.fromJson(i))
            .toList(),
        menus: Menus.fromJson(json['menus']),
        rating: json['rating'].toString(),
        customerReviews: (json['customerReviews'] as List)
            .map((i) => CustomerReviewModel.fromJson(i))
            .toList(),
      );
}
