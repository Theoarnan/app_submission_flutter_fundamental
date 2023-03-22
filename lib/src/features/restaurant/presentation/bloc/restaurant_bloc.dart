import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/services/local_services.dart';
import 'package:app_submission_flutter_fundamental/src/services/remote_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RemoteServicesImpl remoteServicesImpl = RemoteServicesImpl();
  final LocalServices localServices = LocalServices();
  RestaurantBloc() : super(RestaurantInitialState()) {
    on<GetAllDataRestaurant>((event, emit) => _getAllRestaurant(event, emit));
    on<GetDetailDataRestaurant>(
        (event, emit) => _getDetailRestaurant(event, emit));
    on<SearchDataRestaurant>(
        (event, emit) => _searchDataRestaurant(event, emit));
    on<AddReviewRestaurant>((event, emit) => _addReviewRestaurant(event, emit));
    on<GetAllFavoritesRestaurant>(
        (event, emit) => _getAllFavoriteRestaurant(event, emit));
    on<AddToFavoritesRestaurant>(
        (event, emit) => _addToFavoriteRestaurant(event, emit));
    on<RemoveFromFavoritesRestaurant>(
        (event, emit) => _removeFavoriteRestaurant(event, emit));
  }

  void _getAllRestaurant(
    GetAllDataRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    if (await Utils.isConnected() == false) return emit(NoInternetState());
    try {
      final data = await remoteServicesImpl.getRestaurantData();
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
      final data = await remoteServicesImpl.getRestaurantDetail(event.id);
      final isFavorite = await localServices.checkIsFavoriteRestaurant(
        event.id,
      );
      emit(RestaurantDetailLoadedState(data: data, isFavorite: isFavorite));
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
      final data = await remoteServicesImpl.searchRestaurant(event.search);
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
      await remoteServicesImpl.addReviewsRestaurant(event.review);
      emit(RestaurantAddReviewsSuccessState());
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _getAllFavoriteRestaurant(
    GetAllFavoritesRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    try {
      final data = await localServices.getAllFavoriteRestaurant();
      emit(RestaurantLoadedState(data: data));
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _addToFavoriteRestaurant(
    AddToFavoritesRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    try {
      await localServices.insertFavoriteRestaurant(event.data.toDomain());
      emit(AddToFavoritesRestaurantSuccess());
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }

  void _removeFavoriteRestaurant(
    RemoveFromFavoritesRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoadingState());
    try {
      await localServices.deleteFavoriteRestaurant(event.id);
      emit(RemoveFromFavoritesRestaurantSuccess());
    } catch (e) {
      emit(RestaurantErrorState(error: e.toString()));
    }
  }
}
