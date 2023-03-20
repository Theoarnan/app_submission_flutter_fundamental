class FoodDrinkCategoriesModel {
  final String name;

  FoodDrinkCategoriesModel({
    required this.name,
  });

  factory FoodDrinkCategoriesModel.fromJson(Map<String, dynamic> json) =>
      FoodDrinkCategoriesModel(
        name: json['name'],
      );
}
