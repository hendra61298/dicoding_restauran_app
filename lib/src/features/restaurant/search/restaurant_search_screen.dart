
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app/src/core/get_it/get_it.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_bloc.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/search/bloc/restaurant_search_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../constant/api_urls.dart';
import '../../../core/router/app_router_constant.dart';
import '../../../domains/entities/restaurant.dart';

class RestaurantSearchScreen extends StatelessWidget {
  const RestaurantSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              title:  Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 15),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width -150,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                      prefixIcon: Icon(Icons.search,color: Colors.white,),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      hintText: "Cari Restaurant",
                    ),
                    onChanged: (value){
                      context.read<RestaurantSearchScreenBloc>().add(RestaurantSearchScreenEventGetList(value));
                    },
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<RestaurantSearchScreenBloc,RestaurantSearchScreenState>(
            builder: (context,state){
              if(state is RestaurantSearchScreenStateInit){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search),
                      Text("Masukan menu atau nama resto")
                    ],
                  ),
                );
              }else if(state is RestaurantSearchScreenStateSuccess){
                return state.founded !=0 ? ListView.builder(
                    itemCount: state.founded,
                    itemBuilder: (context,index){
                      return _buildRestaurantCard(context, state.listRestaurant[index]);
                    }
                ):
               const Center(
                  child: Text("Tidak ditemukan resto yang anda mau"),
                );
              }else if(state is RestaurantSearchScreenStateError){
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
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
