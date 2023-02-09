

import 'package:equatable/equatable.dart';

abstract class RestaurantSearchScreenEvent extends Equatable{
  const RestaurantSearchScreenEvent();

  @override
  List<Object> get props => [];
}

class RestaurantSearchScreenEventGetList extends RestaurantSearchScreenEvent{
  final String query;

  @override
  List<Object> get props => [query];

  const RestaurantSearchScreenEventGetList(this.query);

}
