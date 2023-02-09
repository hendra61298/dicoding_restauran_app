import 'package:equatable/equatable.dart';

import '../../../../domains/entities/restaurant.dart';

abstract class RestaurantListState extends Equatable {
  const RestaurantListState();

  @override
  List<Object> get props => [];
}

class RestaurantListStateInit extends RestaurantListState{}

class RestaurantListStateLoading extends RestaurantListState{}


class RestaurantListStateSuccess extends RestaurantListState{
  final List<Restaurant> listRestaurant;
  final int count;

  @override
  List<Object> get props => [listRestaurant, count];

  const RestaurantListStateSuccess(this.listRestaurant,this.count);
}

class RestaurantListStateError extends RestaurantListState{
  final Object error;

  @override
  List<Object> get props => [error];

  const RestaurantListStateError(this.error);
}
