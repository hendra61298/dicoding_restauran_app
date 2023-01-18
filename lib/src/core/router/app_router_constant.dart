enum AppRoute {
  restaurantListScreen,
  detailScreen,
}

extension AppRouteExtension on AppRoute{
  String get name {
    switch (this){
      case AppRoute.restaurantListScreen:
        return 'Restaurant List Screen';
      case AppRoute.detailScreen:
        return 'Detail Screen';
    }
  }

  String get path {
    switch (this) {
      case AppRoute.restaurantListScreen:
        return '/restaurant';
      case AppRoute.detailScreen:
        return '/detail';
    }
  }
}