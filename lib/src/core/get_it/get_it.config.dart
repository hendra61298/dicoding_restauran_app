// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dicoding_restaurant_app/src/core/service/dio_client.dart'
    as _i3;
import 'package:dicoding_restaurant_app/src/data/datasource/restaurant_data_source.dart'
    as _i4;
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_bloc.dart'
    as _i7;
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_bloc.dart'
    as _i5;
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_bloc.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.DioClientImpl>(() => _i3.DioClientImpl());
    gh.factory<_i4.RestaurantDataSource>(
        () => _i4.RestaurantDataSource(gh<_i3.DioClientImpl>()));
    gh.factory<_i5.RestaurantListBloc>(
        () => _i5.RestaurantListBloc(gh<_i4.RestaurantDataSource>()));
    gh.factory<_i6.RestaurantSearchScreenBloc>(
        () => _i6.RestaurantSearchScreenBloc(gh<_i4.RestaurantDataSource>()));
    gh.factory<_i7.DetailScreenBloc>(
        () => _i7.DetailScreenBloc(gh<_i4.RestaurantDataSource>()));
    return this;
  }
}
