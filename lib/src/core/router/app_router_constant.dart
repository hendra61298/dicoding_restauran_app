enum AppRoute {
  restaurantListScreen,
  detailScreen,
  searchScreen
}

extension AppRouteExtension on AppRoute{
  String get name {
    switch (this){
      case AppRoute.restaurantListScreen:
        return 'Restaurant List Screen';
      case AppRoute.detailScreen:
        return 'Detail Screen';
      case AppRoute.searchScreen:
        return 'Search Screen';
    }
  }

  String get path {
    switch (this) {
      case AppRoute.restaurantListScreen:
        return '/restaurant';
      case AppRoute.detailScreen:
        return '/detail';
      case AppRoute.searchScreen:
        return '/search';
    }
  }
}