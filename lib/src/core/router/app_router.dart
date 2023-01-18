
import 'package:dicoding_restaurant_app/src/core/router/app_router_constant.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/detail_screen.dart';
import 'package:dicoding_restaurant_app/src/features/restauran_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  GoRouter router() => GoRouter(
    initialLocation: AppRoute.restaurantListScreen.path,
      routes: <RouteBase>[
        GoRoute(
          name: AppRoute.restaurantListScreen.name ,
          path: AppRoute.restaurantListScreen.path,
          builder: (context,state) => const RestaurantListScreen()
        ),
        GoRoute(
            name: AppRoute.detailScreen.name,
            path: AppRoute.detailScreen.path,
            builder: (context,state) =>  DetailScreen(
              restaurant: state.extra as Restaurant)
        )
      ]);
}