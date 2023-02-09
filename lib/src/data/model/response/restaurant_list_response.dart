import '../../../domains/entities/restaurant.dart';

class RestaurantListResponse<T> {

  bool? error;

  /// Error message if any.
  String? message;

  int? count;

  int? founded;

  /// The requested data.
  List<Restaurant>? data;

  RestaurantListResponse({
    required this.error,
    this.data,
    this.message,
    this.count,
    this.founded,
  });

  RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    count = json['count'];
    founded = json['founded'];
    if (json['restaurants'] != null) {
      data = <Restaurant>[];
      json['restaurants'].forEach((v) {
        data!.add( Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['error'] = this.error;
    data['message'] = this.message;
    data['count'] = this.count;
    data['founded'] = this.founded;
    if (this.data != null) {
      data['restaurants'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
