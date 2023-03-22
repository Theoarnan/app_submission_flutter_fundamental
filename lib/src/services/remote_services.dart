import 'dart:convert';
import 'dart:io';

import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_detail_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteServices {
  Future<List<CustomerReviewModel>> addReviewsRestaurant(
    Map<String, dynamic>? reviews,
  );
  Future<List<RestaurantModel>> getRestaurantData();
  Future<RestaurantDetailModel> getRestaurantDetail(String id);
  Future<List<RestaurantModel>> searchRestaurant(String? search);
}

class RemoteServicesImpl implements RemoteServices {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  // Endpoint
  static const String _getListRestaurant = '$_baseUrl/list';
  static const String _getDetailRestaurant = '$_baseUrl/detail/';
  static const String _searchRestaurant = '$_baseUrl/search?q=';
  static const String _addReviewRestaurant = '$_baseUrl/review';

  @override
  Future<List<CustomerReviewModel>> addReviewsRestaurant(
      Map<String, dynamic>? reviews) async {
    final response =
        await http.post(Uri.parse(_addReviewRestaurant), body: reviews);
    if (response.statusCode == HttpStatus.created) {
      final decodeResponse = json.decode(response.body);
      return (decodeResponse['customerReviews'] as List)
          .map((e) => CustomerReviewModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to add reviews restaurant');
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantData() async {
    final response = await http.get(Uri.parse(_getListRestaurant));
    if (response.statusCode == HttpStatus.ok) {
      final decodeResponse = json.decode(response.body);
      return (decodeResponse['restaurants'] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  @override
  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    final url = Uri.encodeFull('$_getDetailRestaurant$id');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final decodeResponse = json.decode(response.body);
      return RestaurantDetailModel.fromJson(decodeResponse['restaurant']);
    } else {
      throw Exception('Failed to load detail restaurant data');
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String? search) async {
    if (search!.isEmpty) return getRestaurantData();
    final response = await http.get(Uri.parse(_searchRestaurant + (search)));
    if (response.statusCode == HttpStatus.ok) {
      if (search.isEmpty) return [];
      final decodeResponse = json.decode(response.body);
      return (decodeResponse['restaurants'] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load search restaurant data');
    }
  }
}
