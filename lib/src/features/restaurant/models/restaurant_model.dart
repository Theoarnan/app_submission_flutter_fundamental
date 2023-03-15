import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/menus_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;
  final Menus menus;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> restaurant) =>
      RestaurantModel(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toString(),
        menus: Menus.fromJson(restaurant['menus']),
      );
}
