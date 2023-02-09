

import 'package:bloc/bloc.dart';
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_list_response.dart';
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/datasource/restaurant_data_source.dart';
import '../../../../domains/entities/restaurant.dart';

@injectable
class RestaurantSearchScreenBloc extends Bloc<RestaurantSearchScreenEvent, RestaurantSearchScreenState>{
  final RestaurantDataSource restaurantRepository;
  RestaurantSearchScreenBloc(this.restaurantRepository) : super(RestaurantSearchScreenStateInit()){
    on<RestaurantSearchScreenEventGetList>(_getList);
  }

  _getList(
      RestaurantSearchScreenEventGetList event,
      Emitter<RestaurantSearchScreenState> emit,
      ) async{
    emit(RestaurantSearchScreenStateLoading());
    try{
      if(event.query.isEmpty){
        emit(RestaurantSearchScreenStateInit());
        return;
      }
      RestaurantListResponse<List<Restaurant>> response = await restaurantRepository.getListRestaurantSearch(event.query);
      List<Restaurant> listRestaurant = response.data?? [];
      emit(RestaurantSearchScreenStateSuccess(listRestaurant, response.founded ?? 0));
    }catch (e){
      emit(RestaurantSearchScreenStateError(e));
    }
  }
}