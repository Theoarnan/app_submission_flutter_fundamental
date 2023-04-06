import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/menus_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/services/local_services.dart';
import 'package:app_submission_flutter_fundamental/src/services/remote_services.dart';
import 'package:sqflite/sqflite.dart';

final sampleResult = [
  RestaurantModel(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
    pictureId: '25',
    city: 'Medan',
    rating: '4.2',
  ),
];

const sampleIdRestaurant = 'rqdv5juczeskfw1e867';
final categories = [
  FoodDrinkCategoriesModel(name: 'Italia'),
  FoodDrinkCategoriesModel(name: 'Modern')
];
final foods = [
  FoodDrinkCategoriesModel(name: 'Paket rosemary'),
  FoodDrinkCategoriesModel(name: 'Toastie salmon')
];
final drinks = [
  FoodDrinkCategoriesModel(name: 'Es krim'),
  FoodDrinkCategoriesModel(name: 'Sirup')
];
final menus = Menus(foods: foods, drinks: drinks);
final customerReviews = [
  CustomerReviewModel(
    name: 'Ahmad',
    review: 'Mantap Jos!',
    date: '13 November 2019',
  )
];
final sampleResponse = RestaurantDetailModel(
  id: sampleIdRestaurant,
  name: 'Melting Pot',
  description:
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
  city: 'Medan',
  address: 'Jln. Pandeglang no 19',
  pictureId: '14',
  categories: categories,
  menus: menus,
  rating: '4.2',
  customerReviews: customerReviews,
);

class MockRemoteServicesImplManualy implements RemoteServicesImpl {
  @override
  Future<List<CustomerReviewModel>> addReviewsRestaurant(
      Map<String, dynamic>? reviews) {
    throw UnimplementedError();
  }

  @override
  Future<RestaurantModel> getRandomRestaurant() async {
    return sampleResult.first;
  }

  @override
  Future<List<RestaurantModel>> getRestaurantData() async {
    return sampleResult;
  }

  @override
  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    return sampleResponse;
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String? search) async {
    return sampleResult;
  }
}

class MockLocalServicesManualy implements LocalServices {
  @override
  Future<bool> checkIsFavoriteRestaurant(String idRestaurant) async {
    return true;
  }

  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<void> deleteFavoriteRestaurant(String idRestaurant) {
    throw UnimplementedError();
  }

  @override
  Future<List<RestaurantModel>> getAllFavoriteRestaurant() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertFavoriteRestaurant(RestaurantModel restaurant) {
    throw UnimplementedError();
  }
}

class MockUtilsManualy implements Utils {
  @override
  Future<bool> isConnected() async {
    return true;
  }
}
