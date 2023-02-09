

import 'package:equatable/equatable.dart';

 abstract class DetailScreenEvent extends Equatable{
   const DetailScreenEvent();

  @override
  List<Object?> get props => [];
}

class DetailScreenEventGetRestaurant extends DetailScreenEvent{
   final String id;

   @override
   List<Object?> get props => [id];
   const DetailScreenEventGetRestaurant(this.id);
}