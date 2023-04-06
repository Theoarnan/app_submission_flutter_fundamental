import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/menus_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final jsonRestaurant = {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "pictureId": "25",
    "city": "Medan",
    "rating": 4.2
  };

  final jsonRestaurant2 = {
    "id": "s1knt6za9kkfw1e867",
    "name": "Kafe Kita",
    "description":
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    "pictureId": "25",
    "city": "Gorontalo",
    "rating": 4
  };

  final List<Map<String, dynamic>> listRestaurant = [
    jsonRestaurant,
    jsonRestaurant2,
  ];

  final jsonDetailRestaurant = {
    "id": "ateyf7m737ekfw1e867",
    "name": "Kafe Cemara",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Ternate",
    "address": "Jln. Belimbing Timur no 27",
    "pictureId": "27",
    "categories": [
      {"name": "Spanyol"}
    ],
    "menus": {
      "foods": [
        {"name": "Ikan teri dan roti"},
        {"name": "Sosis squash dan mint"},
        {"name": "Toastie salmon"},
        {"name": "Paket rosemary"},
        {"name": "Matzo farfel"},
        {"name": "Salad lengkeng"},
        {"name": "Bebek crepes"},
        {"name": "Tumis leek"},
        {"name": "Napolitana"},
        {"name": "Sup Kohlrabi"},
        {"name": "roket penne"},
        {"name": "Salad yuzu"},
        {"name": "Kari terong"}
      ],
      "drinks": [
        {"name": "Sirup"},
        {"name": "Kopi espresso"},
        {"name": "Jus apel"},
        {"name": "Coklat panas"},
        {"name": "Jus alpukat"},
        {"name": "Jus mangga"},
        {"name": "Es krim"},
        {"name": "Air"},
        {"name": "Es kopi"},
        {"name": "Minuman soda"}
      ]
    },
    "rating": 3.6,
    "customerReviews": [
      {"name": "Ahmad", "review": "Mantap Jos!", "date": "13 November 2019"}
    ]
  };

  group('Test Data - Parse From Json', () {
    test('Test Parse - List Data Restaurant Success', () {
      /// Sample result
      final sampleResult = RestaurantModel(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
        pictureId: '25',
        city: 'Medan',
        rating: '4.2',
      );

      /// act
      var result =
          (listRestaurant).map((e) => RestaurantModel.fromJson(e)).toList();

      /// assert
      expect(result, isA<List<RestaurantModel>>());
      expect(result.length, 2);
      expect(result.first.toMap(), sampleResult.toMap());
    });

    test('Test Parse - Data Detail Restaurant Success', () {
      /// act
      var result = RestaurantDetailModel.fromJson(jsonDetailRestaurant);

      /// assert
      expect(result, isA<RestaurantDetailModel>());
      expect(result.id, 'ateyf7m737ekfw1e867');
      expect(result.name, 'Kafe Cemara');

      expect(result.categories, isA<List<FoodDrinkCategoriesModel>>());
      expect(result.categories.length, 1);
      expect(result.categories.first.name, 'Spanyol');

      expect(result.menus, isA<Menus>());
      expect(result.menus.foods, isA<List<FoodDrinkCategoriesModel>>());
      expect(result.menus.drinks, isA<List<FoodDrinkCategoriesModel>>());
      expect(result.menus.foods.length, 13);
      expect(result.menus.drinks.length, 10);
      expect(result.menus.foods.first.name, 'Ikan teri dan roti');
      expect(result.menus.drinks.first.name, 'Sirup');

      expect(result.customerReviews, isA<List<CustomerReviewModel>>());
      expect(result.customerReviews.length, 1);
      expect(result.customerReviews.first.name, 'Ahmad');
      expect(result.customerReviews.first.review, 'Mantap Jos!');
    });
  });
}
