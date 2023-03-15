class FoodDrinkModel {
  final String name;

  FoodDrinkModel({required this.name});

  factory FoodDrinkModel.fromJson(Map<String, dynamic> foodDrink) =>
      FoodDrinkModel(
        name: foodDrink['name'],
      );
}
