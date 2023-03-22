part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
  @override
  List<Object?> get props => [];
}

class GetAllDataRestaurant extends RestaurantEvent {}

class GetDetailDataRestaurant extends RestaurantEvent {
  final String id;
  const GetDetailDataRestaurant({required this.id});
  @override
  List<Object> get props => [id];
}

class SearchDataRestaurant extends RestaurantEvent {
  final String search;
  const SearchDataRestaurant({required this.search});
  @override
  List<Object> get props => [search];
}

class AddReviewRestaurant extends RestaurantEvent {
  final Map<String, dynamic> review;
  const AddReviewRestaurant({required this.review});
  @override
  List<Object> get props => [review];
}

class GetAllFavoritesRestaurant extends RestaurantEvent {}

class AddToFavoritesRestaurant extends RestaurantEvent {
  final RestaurantDetailModel data;
  const AddToFavoritesRestaurant({required this.data});
  @override
  List<Object> get props => [data];
}

class RemoveFromFavoritesRestaurant extends RestaurantEvent {
  final String id;
  const RemoveFromFavoritesRestaurant({required this.id});
  @override
  List<Object> get props => [id];
}
