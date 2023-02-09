import 'package:dicoding_restaurant_app/src/core/get_it/get_it.dart';
import 'package:dicoding_restaurant_app/src/core/router/app_router_constant.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/detail_screen.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_bloc.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/restauran_list_screen.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_bloc.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/restaurant_search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  GoRouter router() =>
      GoRouter(
          initialLocation: AppRoute.restaurantListScreen.path,
          routes: <RouteBase>[
            GoRoute(
              name: AppRoute.restaurantListScreen.name,
              path: AppRoute.restaurantListScreen.path,
              builder: (context, state) {
                return const RestaurantListScreen();
              },
            ),
            GoRoute(
                name: AppRoute.detailScreen.name,
                path: AppRoute.detailScreen.path,
                builder: (context, state) =>
                    DetailScreen(
                      id: state.extra as String,)
            ),
            GoRoute(
                name: AppRoute.searchScreen.name,
                path: AppRoute.searchScreen.path,
                builder: (context, state) =>
                    BlocProvider<RestaurantSearchScreenBloc>(
                      create: (context) => getIt<RestaurantSearchScreenBloc>(),
                      child: const RestaurantSearchScreen(),
                    )
            )
          ]);
}