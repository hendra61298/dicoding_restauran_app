import 'package:equatable/equatable.dart';

abstract class RestaurantListEvent extends Equatable{
  const RestaurantListEvent();

  @override
  List<Object> get props => [];
}

class RestaurantListEventGetList extends RestaurantListEvent{}