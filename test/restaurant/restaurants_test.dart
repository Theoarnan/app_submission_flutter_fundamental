import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/menus_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/services/local_services.dart';
import 'package:app_submission_flutter_fundamental/src/services/remote_services.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurants_test.mocks.dart';
import 'restaurants_test_manualy_mock.dart';

@GenerateMocks([RemoteServicesImpl, LocalServices])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRemoteServicesImpl mockRemoteServicesImpl;
  late MockRemoteServicesImplManualy mockRemoteServicesImplManualy;
  late MockLocalServicesManualy mockLocalServicesManualy;
  late MockUtilsManualy utils;
  late RestaurantBloc restaurantBloc;

  setUp(() {
    mockRemoteServicesImpl = MockRemoteServicesImpl();
    EquatableConfig.stringify = true;
    mockRemoteServicesImplManualy = MockRemoteServicesImplManualy();
    mockLocalServicesManualy = MockLocalServicesManualy();
    utils = MockUtilsManualy();
    restaurantBloc = RestaurantBloc(
      utils: utils,
      remoteServicesImpl: mockRemoteServicesImplManualy,
      localServices: mockLocalServicesManualy,
    );
  });

  group('Test Unit - List Restaurant', () {
    test('Test get on success', () async {
      /// arrange
      when(mockRemoteServicesImpl.getRestaurantData())
          .thenAnswer((_) => Future.value(sampleResult));

      /// act
      final result = await mockRemoteServicesImpl.getRestaurantData();

      /// assert
      verify(mockRemoteServicesImpl.getRestaurantData()).called(1);
      expect(result, equals(sampleResult));
      expect(result.length, 1);
      expect(result.first.name, 'Melting Pot');
    });

    blocTest(
      'Succes proses on Bloc - Event GetAllDataRestaurant',
      tearDown: () => restaurantBloc.close(),
      build: () => restaurantBloc,
      act: (bloc) => bloc.add(GetAllDataRestaurant()),
      expect: () => [
        isA<RestaurantLoadingState>(),
        isA<RestaurantLoadedState>(),
      ],
    );
  });
  group('Test - Detail Restaurant', () {
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
    test('Test get on success', () async {
      /// arrange
      when(mockRemoteServicesImpl.getRestaurantDetail(sampleIdRestaurant))
          .thenAnswer((_) => Future.value(sampleResponse));

      /// act
      final result = await mockRemoteServicesImpl.getRestaurantDetail(
        sampleIdRestaurant,
      );

      /// assert
      verify(mockRemoteServicesImpl.getRestaurantDetail(sampleIdRestaurant))
          .called(1);
      expect(result, isA<RestaurantDetailModel>());
      expect(result, equals(sampleResponse));
      expect(result.categories, equals(categories));
      expect(result.menus, isA<Menus>());
      expect(result.customerReviews, customerReviews);
      expect(result.id, sampleIdRestaurant);
      expect(result.name, 'Melting Pot');
    });

    blocTest(
      'Succes proses on Bloc - Event GetDetailDataRestaurant',
      tearDown: () => restaurantBloc.close(),
      build: () => restaurantBloc,
      act: (bloc) => bloc.add(
        const GetDetailDataRestaurant(id: ''),
      ),
      expect: () => [
        isA<RestaurantLoadingState>(),
        isA<RestaurantDetailLoadedState>(),
      ],
    );
  });
}
