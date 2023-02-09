

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_restaurant_app/src/core/get_it/get_it.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_bloc.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_event.dart';
import 'package:dicoding_restaurant_app/src/features/restaurant/detail/bloc/detail_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constant/api_urls.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);


  Widget cardMenu(Drinks? drink , Foods? food){
    String text = "";
      if(drink != null){
        text = drink.name!;
      }else if(food != null){
        text = food.name!;
      }
      return SizedBox(
        width: 200,
        child: Card(
          elevation: 8,
          child: Stack(
            children: <Widget>[
               const  Image(
                   image: AssetImage('assets/images/menus.png'),
                   fit: BoxFit.fill,
               ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
              ]
          ),
        ),
      );
  }

  List<Widget> addListDrinkWidget(Restaurant restaurant){
    List<Widget> listDrinkCard = [];
    restaurant.menus?.drinks?.forEach((drink) {
      listDrinkCard.add(cardMenu(drink,null));
    });
    return listDrinkCard;
  }

  List<Widget> addListFoodWidget(Restaurant restaurant){
    List<Widget> listFoodCard = [];
    restaurant.menus?.foods?.forEach((food) {
      listFoodCard.add(cardMenu(null,food));
    });
    return listFoodCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body:BlocProvider<DetailScreenBloc>(
        create: (context) => getIt<DetailScreenBloc>()..add(DetailScreenEventGetRestaurant(id)),
        child: BlocBuilder<DetailScreenBloc, DetailScreenState>(
          builder: (context, state) {
            if(state is DetailScreenStateSuccess){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child:CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: ApiUrls.pictureUrl+ (state.restaurant.pictureId ?? ""),
                      ),
                    ),
                    ListTile(
                      title: Text(state.restaurant.name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      subtitle: Text.rich(TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                size: 15,
                              ),
                            ),
                            TextSpan(
                                text: state.restaurant.city ?? "",
                                style: const TextStyle(
                                    fontSize: 13
                                )
                            )
                          ]
                      )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                              initialRating: state.restaurant.rating!,
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
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text("Deskripsi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(state.restaurant.description?? "",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: const Text("Minuman",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: ListView(
                            scrollDirection: Axis.horizontal,
                            children:  addListDrinkWidget(state.restaurant),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: const Text("Makanan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: ListView(
                            scrollDirection: Axis.horizontal,
                            children:  addListFoodWidget(state.restaurant),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            else if(state is DetailScreenStateError){
              return Center(
                child: Text(state.error.toString()),
              );
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
