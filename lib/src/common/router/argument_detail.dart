import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';

class DetailArguments {
  final RestaurantModel dataRestaurant;
  final bool isFromFavorite;

  DetailArguments({
    required this.dataRestaurant,
    required this.isFromFavorite,
  });
}
