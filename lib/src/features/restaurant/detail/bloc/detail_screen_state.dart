
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:equatable/equatable.dart';

abstract class DetailScreenState extends Equatable{
  const DetailScreenState();

  @override
  List<Object> get props => [];
}

class DetailScreenStateInit extends DetailScreenState{}

class DetailScreenStateLoading extends DetailScreenState{}

class DetailScreenStateSuccess extends DetailScreenState{
  final Restaurant restaurant;

  @override
  List<Object> get props => [restaurant];

  const DetailScreenStateSuccess(this.restaurant);
}

class DetailScreenStateError extends DetailScreenState{
  final Object error;

  @override
  List<Object> get props => [error];

  const DetailScreenStateError(this.error);
}

