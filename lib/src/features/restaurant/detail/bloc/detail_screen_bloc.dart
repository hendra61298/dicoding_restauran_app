

import 'package:bloc/bloc.dart';
import 'package:dicoding_restaurant_app/src/data/model/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/datasource/restaurant_data_source.dart';

@injectable
class DetailScreenBloc extends Bloc<DetailScreenEvent,DetailScreenState>{
  final RestaurantDataSource restaurantRepository;
  DetailScreenBloc(this.restaurantRepository): super(DetailScreenStateInit()){
   on<DetailScreenEventGetRestaurant>(_onGetRestaurant);
  }

  _onGetRestaurant(
      DetailScreenEventGetRestaurant event,
      Emitter<DetailScreenState> emit
      )async {
    emit(DetailScreenStateLoading());
    try{
      RestaurantResponse response = await restaurantRepository.getRestaurant(event.id);

      Restaurant restaurant = response.data!;
      emit(DetailScreenStateSuccess(restaurant));
    }catch (e){
      emit(DetailScreenStateError(e));
    }
  }
}