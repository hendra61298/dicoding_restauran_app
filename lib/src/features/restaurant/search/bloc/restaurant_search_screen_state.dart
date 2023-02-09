

import 'package:equatable/equatable.dart';

import '../../../../domains/entities/restaurant.dart';

abstract class RestaurantSearchScreenState extends Equatable {
  const RestaurantSearchScreenState();

  @override
  List<Object> get props => [];
}

class RestaurantSearchScreenStateInit extends RestaurantSearchScreenState{}

class RestaurantSearchScreenStateLoading extends RestaurantSearchScreenState{}


class RestaurantSearchScreenStateSuccess extends RestaurantSearchScreenState{
  final List<Restaurant> listRestaurant;
  final int founded;

  @override
  List<Object> get props => [listRestaurant, founded];

  const RestaurantSearchScreenStateSuccess(this.listRestaurant,this.founded);
}

class RestaurantSearchScreenStateError extends RestaurantSearchScreenState{
  final Object error;

  @override
  List<Object> get props => [error];

  const RestaurantSearchScreenStateError(this.error);
}
