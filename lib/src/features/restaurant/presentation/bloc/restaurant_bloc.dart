import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final ApiServicesImpl apiServicesImpl = ApiServicesImpl();
  RestaurantBloc() : super(RestaurantInitialState()) {
    on<GetAllDataRestaurant>((event, emit) => _getAllRestaurant(event, emit));
    on<GetDetailDataRestaurant>(
        (event, emit) => _getDetailRestaurant(event, emit));
    on<SearchDataRestaurant>(
        (event, emit) => _searchDataRestaurant(event, emit));
    on<AddReviewRestaurant>((event, emit) => _addReviewRestaurant(event, emit));
  }

  void _getAllRestaurant(
    GetAllDataRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    if (await Utils.isConnected() == false) return emit(NoInternetState());
    try {
      final data = await apiServicesImpl.getRestaurantData();
      emit(RestaurantLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _getDetailRestaurant(
    GetDetailDataRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    if (await Utils.isConnected() == false) return emit(NoInternetState());
    try {
      final data = await apiServicesImpl.getRestaurantDetail(event.id);
      emit(RestaurantDetailLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _searchDataRestaurant(
    SearchDataRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    if (await Utils.isConnected() == false) return emit(NoInternetState());
    try {
      final data = await apiServicesImpl.searchRestaurant(event.search);
      emit(RestaurantLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _addReviewRestaurant(
    AddReviewRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    if (await Utils.isConnected() == false) return emit(NoInternetState());
    try {
      await apiServicesImpl.addReviewsRestaurant(event.review);
      emit(RestaurantAddReviewsSuccessState());
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }
}
