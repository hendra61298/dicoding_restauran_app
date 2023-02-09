

import 'package:bloc/bloc.dart';
import 'package:dicoding_restaurant_app/src/data/datasource/restaurant_data_source.dart';
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_list_response.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestaurantListBloc extends Bloc<RestaurantListEvent, RestaurantListState>{
  final RestaurantDataSource restaurantRepository;
  RestaurantListBloc(this.restaurantRepository) : super(RestaurantListStateInit()){
    on<RestaurantListEventGetList>(_getList);
  }

  _getList(
      RestaurantListEventGetList event,
      Emitter<RestaurantListState> emit,
      ) async{
    emit(RestaurantListStateLoading());
    try{
      RestaurantListResponse<List<Restaurant>> response = await restaurantRepository.getListRestaurant();
      List<Restaurant> listRestaurant = response.data?? [];
      emit(RestaurantListStateSuccess(listRestaurant, response.count ?? 0));
    }catch (e){
      emit(RestaurantListStateError(e));
    }
  }
}