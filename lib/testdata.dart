import 'package:AirmineStudy/models/placemodels.dart';

import 'models/usermodels.dart';

User getUser() {
  return User(
      name: 'Ole J Reierstad',
      allergicTypes: [PollenType.birch, PollenType.gras]);
}

List<Place> getTestPlaces() {
  List<Place> result = [
    Place(
        googleName: "Jessheim",
        customName: "Hjemme",
        adress: "Linneavegen",
        airquality: [
          Airquality(
              pollenType: PollenType.air, density: 5, date: DateTime.now()),
          Airquality(
              pollenType: PollenType.birch, density: 2, date: DateTime.now()),
          Airquality(
              pollenType: PollenType.gras, density: 10, date: DateTime.now()),
        ]),
    Place(airquality: [
      Airquality(pollenType: PollenType.air, density: 1, date: DateTime.now()),
      Airquality(
          pollenType: PollenType.birch, density: 3, date: DateTime.now()),
      Airquality(pollenType: PollenType.gras, density: 4, date: DateTime.now()),
    ], customName: 'Hytta', adress: "Gålå", googleName: 'Gålå')
  ];
  return result;
}

List<Airquality> getTestAirQuality(PollenType pollenType) {
  List<Airquality> result = [
    Airquality(pollenType: pollenType, density: 1, date: DateTime.now()),
    Airquality(
        pollenType: pollenType,
        density: 10,
        date: DateTime.now().add(const Duration(hours: 24)))
  ];
  return result;
}
