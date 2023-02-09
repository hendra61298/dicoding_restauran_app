import 'dart:convert';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  String? address;
  double? rating;
  Menus? menus;
  List<Categories>? categories;

  Restaurant(
      {this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.address,
        this.rating,
        this.menus,
        this.categories
      });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    address = json['address'];
    rating = double.parse(json['rating'].toString());
    menus = json['menus'] != null ?  Menus.fromJson(json['menus']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add( Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['address'] = address;
    data['rating'] = rating;
    if (menus != null) {
      data['menus'] = menus!.toJson();
    }
    if (menus != null) {
      data['categories'] =categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menus {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add( Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add( Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (foods != null) {
      data['foods'] =foods!.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] =drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Foods {
  String? name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Drinks {
  String? name;

  Drinks({this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final Map<String,dynamic> parsed = jsonDecode(json);
  final List dataParsed = parsed['restaurants'];

  return dataParsed.map((json) => Restaurant.fromJson(json)).toList();
}
