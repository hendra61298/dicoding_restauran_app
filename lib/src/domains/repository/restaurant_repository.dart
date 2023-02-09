
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_list_response.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';

import '../../data/model/response/restaurant_response.dart';

abstract class RestaurantRepository {

  Future<RestaurantListResponse<List<Restaurant>>> getListRestaurant();

  Future<RestaurantResponse> getRestaurant(String id);

  Future<RestaurantListResponse<List<Restaurant>>> getListRestaurantSearch(String query);

}