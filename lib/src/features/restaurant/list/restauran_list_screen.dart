
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app/src/constant/api_urls.dart';
import 'package:dicoding_restaurant_app/src/core/router/app_router_constant.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_bloc.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/list/bloc/restaurant_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../core/get_it/get_it.dart';
import '../../../domains/repository/restaurant_repository.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ListTile(
                  title: Text("Restoran untuk kamu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Text('Kami pilihkan restoran terbaik...',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () => GoRouter.of(context).pushNamed(AppRoute.searchScreen.name),
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          body: BlocProvider(
            create: (context) => getIt<RestaurantListBloc>()..add(RestaurantListEventGetList()),
            child: BlocBuilder<RestaurantListBloc,RestaurantListState>(
              builder: (context,state){
                if(state is RestaurantListStateSuccess){
                 return ListView.builder(
                   itemCount: state.count,
                   itemBuilder: (context,index){
                     return _buildRestaurantCard(context, state.listRestaurant[index]);
                   }
                 );
                }else if (state is RestaurantListStateError){
                  return Center(
                    child: Text(state.error.toString()),
                  );
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
            )
        ));
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant){
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).pushNamed(
          AppRoute.detailScreen.name,
          extra: restaurant.id
        );
      },
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Card(
            elevation: 5,
            color: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10,top: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: ApiUrls.pictureUrl+restaurant.pictureId!,
                        ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(restaurant.name!),
                            subtitle:Text.rich(TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(
                                    Icons.location_on,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(
                                    text: restaurant.city,
                                  style: const TextStyle(
                                    fontSize: 13
                                  )
                                )
                              ]
                            )),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0,left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RatingBar.builder(
                                      initialRating: restaurant.rating!,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 25,
                                      ignoreGestures: true,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      onRatingUpdate: (double value) {  null;},
                                      itemBuilder: (BuildContext context, _) =>  const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
