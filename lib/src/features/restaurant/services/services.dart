import 'dart:convert';

import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/restaurant_model.dart';
import 'package:flutter/services.dart';

abstract class Services {
  Future<List<RestaurantModel>> getRestaurantData();
  Future<List<RestaurantModel>?> searchRestaurantData(String search);
}

class ServicesImpl implements Services {
  @override
  Future<List<RestaurantModel>> getRestaurantData() async {
    Map<String, dynamic> decodeResponse = await getDataJson();
    if (decodeResponse.isEmpty) {
      return [];
    }
    return (decodeResponse['restaurants'] as List)
        .map((e) => RestaurantModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<RestaurantModel>?> searchRestaurantData(String? search) {
    final dataRestaurant = getRestaurantData();
    if (search!.isEmpty) return dataRestaurant;
    return dataRestaurant.then((value) => value.where((element) {
          var name = element.name;
          var city = element.city;
          return name.toLowerCase().contains(search.toLowerCase()) ||
              city.toLowerCase().contains(search.toLowerCase());
        }).toList());
  }

  getDataJson() async {
    final String response =
        await rootBundle.loadString(ConstantName.dirAssetJson);
    var decodeResponse = json.decode(response);
    return decodeResponse;
  }
}
