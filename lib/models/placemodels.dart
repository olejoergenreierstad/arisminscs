import 'package:flutter/material.dart';

enum PollenType {
  none,
  alder,
  hazel,
  salix,
  birch,
  gras,
  mugworth,
  pitchambrosia,
  pine,
  air
}

class Place {
  String googleName;
  String customName;
  String adress;
  bool isFavorite;
  bool isHome;
  int order;
  List<Airquality> airquality;

  Place({
    this.googleName = "",
    this.customName = "",
    this.adress = "",
    this.isFavorite = false,
    this.isHome = false,
    this.order = -1,
    @required this.airquality,
  });
}

class Airquality {
  PollenType pollenType;
  DateTime date;
  double density;
  Airquality(
      {@required this.pollenType, @required this.density, @required this.date});
}

class PlacePredictions {
  final String placeId;
  final String name;
  final String address;
  final double lat;
  final double lng;

  PlacePredictions({
    @required this.placeId,
    @required this.name,
    @required this.address,
    this.lat = 0,
    this.lng = 0,
  });
  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng
    };
  }
}
