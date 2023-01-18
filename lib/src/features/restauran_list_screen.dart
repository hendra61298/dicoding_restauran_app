
import 'package:dicoding_restaurant_app/src/core/router/app_router_constant.dart';
import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
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
            ),
          ),
          body: FutureBuilder<String>(
            future:
            DefaultAssetBundle.of(context).loadString('assets/json_data/restaurant.json'),
            builder: (context, snapshot){
              final List<Restaurant> restaurant = parseRestaurant(snapshot.data);
                return ListView.builder(
                  itemCount: restaurant.length ,
                  itemBuilder: (context, index) {
                  return _buildRestaurantCard(context, restaurant[index]);
                },
              );
            },
          ),
        ));
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant){
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).pushNamed(
          AppRoute.detailScreen.name,
          extra: restaurant
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
                      child: Image.network(
                          restaurant.pictureId!,
                          fit: BoxFit.fill,
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
