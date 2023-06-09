part of 'restaurant_bloc.dart';

abstract class RestaurantState {
  const RestaurantState();
  List<Object?> get props => [];
}

class RestaurantInitialState extends RestaurantState {}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantLoadedState extends RestaurantState {
  final List<RestaurantModel>? data;
  RestaurantLoadedState({this.data});
  @override
  List<Object?> get props => [data];
}

class RestaurantDetailLoadedState extends RestaurantState {
  final RestaurantDetailModel data;
  final bool isFavorite;
  RestaurantDetailLoadedState({
    required this.data,
    required this.isFavorite,
  });
  @override
  List<Object?> get props => [data, isFavorite];
}

class RestaurantAddReviewsSuccessState extends RestaurantState {}

class NoInternetState extends RestaurantState {}

class RestaurantErrorState extends RestaurantState {
  final String error;
  RestaurantErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class AddToFavoritesRestaurantSuccess extends RestaurantState {}

class RemoveFromFavoritesRestaurantSuccess extends RestaurantState {}
