part of 'restaurant_bloc_cubit.dart';

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
  RestaurantDetailLoadedState({required this.data});
  @override
  List<Object?> get props => [data];
}

class RestaurantAddReviewsSuccessState extends RestaurantState {}

class RestaurantErrorState extends RestaurantState {
  final String error;
  RestaurantErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
