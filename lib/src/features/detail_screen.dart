

import 'package:dicoding_restaurant_app/src/domains/entities/restaurant.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreen({
    Key? key,
    required this.restaurant
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
                Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ]
          ),
        ),
      );
  }

  List<Widget> addListWidget(Restaurant restaurant){
    List<Widget> listCard = [];
    restaurant.menus?.drinks?.forEach((drink) {
        listCard.add(cardMenu(drink,null));
    });
    restaurant.menus?.foods?.forEach((food) {
        listCard.add(cardMenu(null,food));
    });
    return listCard;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  restaurant.pictureId!,
                  fit: BoxFit.fill,
                ),
              )
          ),
          Expanded(
            flex: 1,
            child:ListTile(
              title: Text(restaurant.name!,
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
              flex: 4,
              child: ListTile(
                title: const Text("Deskripsi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(restaurant.description!),
                ),
              )
          ),
          Expanded(
              flex: 3,
              child: ListTile(
                title: const Text("Menu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: ListView(
                  scrollDirection: Axis.horizontal,
                  children:  addListWidget(restaurant),
                ),
              )
          )
        ],
      ),
    );
  }
}
