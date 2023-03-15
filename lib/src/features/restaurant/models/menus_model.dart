import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/food_drink_model.dart';

class Menus {
  final List<FoodDrinkModel> foods;
  final List<FoodDrinkModel> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: (menus['foods'] as List)
            .map((i) => FoodDrinkModel.fromJson(i))
            .toList(),
        drinks: (menus['drinks'] as List)
            .map((i) => FoodDrinkModel.fromJson(i))
            .toList(),
      );
}
