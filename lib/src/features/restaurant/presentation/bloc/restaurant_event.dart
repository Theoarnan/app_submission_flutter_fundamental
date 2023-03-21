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
