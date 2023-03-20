import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurant_state.dart';

class RestaurantBlocCubit extends Cubit<RestaurantState> {
  RestaurantBlocCubit() : super(RestaurantInitialState());

  final ApiServicesImpl apiServicesImpl = ApiServicesImpl();

  void getAllDataRestaurant() async {
    emit(RestaurantLoadingState());
    try {
      final data = await apiServicesImpl.getRestaurantData();
      emit(RestaurantLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void getDetailDataRestaurant(String id) async {
    emit(RestaurantLoadingState());
    try {
      final data = await apiServicesImpl.getRestaurantDetail(id);
      emit(RestaurantDetailLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void searchDataRestaurant(String search) async {
    emit(RestaurantLoadingState());
    try {
      final data = await apiServicesImpl.searchRestaurant(search);
      emit(RestaurantLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void addReviewRestaurant(Map<String, dynamic> reviews) async {
    emit(RestaurantLoadingState());
    try {
      await apiServicesImpl.addReviewsRestaurant(reviews);
      emit(RestaurantAddReviewsSuccessState());
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }
}
