import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';

class Menus {
  final List<FoodDrinkCategoriesModel> foods;
  final List<FoodDrinkCategoriesModel> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: (menus['foods'] as List)
            .map((i) => FoodDrinkCategoriesModel.fromJson(i))
            .toList(),
        drinks: (menus['drinks'] as List)
            .map((i) => FoodDrinkCategoriesModel.fromJson(i))
            .toList(),
      );
}
