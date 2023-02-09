
import 'package:dicoding_restaurant_app/src/constant/api_urls.dart';
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_list_response.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/domains/repository/restaurant_repository.dart';
import 'package:injectable/injectable.dart';

import '../../core/service/dio_client.dart';
import '../model/response/restaurant_response.dart';

@injectable
class RestaurantDataSource extends RestaurantRepository{
  final DioClientImpl dioClient;

  RestaurantDataSource(this.dioClient);

  @override
  Future<RestaurantListResponse<List<Restaurant>>> getListRestaurant() async {
    try{

      final result = await dioClient.get(
        ApiUrls.getListRestaurant,
      );

      RestaurantListResponse<List<Restaurant>> restaurantResponse = RestaurantListResponse.fromJson(result);
      return restaurantResponse;
    }catch (e){
        throw e.toString();
    }
  }

  @override
  Future<RestaurantResponse> getRestaurant(String id)async {
    try{

      final result = await dioClient.get(
        ApiUrls.getRestaurant+id,
      );
      RestaurantResponse restaurantResponse = RestaurantResponse.fromJson(result);

      return restaurantResponse;
    }catch (e){
      throw e.toString();
    }

  }

  @override
  Future<RestaurantListResponse<List<Restaurant>>> getListRestaurantSearch(String query) async {
    try {
      final result = await dioClient.get(
        ApiUrls.getListRestaurantSearch,
        queryParameters: {"q" :query}
      );

      RestaurantListResponse<List<Restaurant>> restaurantResponse = RestaurantListResponse.fromJson(result);
      return restaurantResponse;
    } catch (e) {
      throw e.toString();
    }
  }

}