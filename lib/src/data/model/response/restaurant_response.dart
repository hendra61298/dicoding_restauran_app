
import '../../../domains/entities/restaurant.dart';

class RestaurantResponse{
  bool? error;

  /// Error message if any.
  String? message;

  int? count;

  /// The requested data.
  Restaurant? data;

  RestaurantResponse({
    required this.error,
    this.data,
    this.message,
    this.count,
  });

  RestaurantResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    count = json['count'];
    if (json['restaurant'] != null) {
      data = Restaurant.fromJson(json['restaurant']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['restaurant'] = this.data!;
    }
    return data;
  }
}