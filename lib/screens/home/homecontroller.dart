import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:AirmineStudy/screens/Profile/profile.dart';
import 'package:AirmineStudy/screens/places/places.dart';

import '../map/map.dart';

class HomeController extends GetxController {
  late TabController tabController;
  late PageController pageController = PageController(initialPage: 0);
  RxBool showSearch = false.obs;

  late List<Widget> homepages;

  late RxList<Widget> placeList; // = [Container()].obs,
  RxList<Place> testplaces = [
    Place(airquality: [
      Airquality(pollenType: PollenType.air, density: 1, date: DateTime.now())
    ])
  ].obs;

  List<Widget> searchResultWidgets = [
    SearchBoxWidget(
      placePredictions: PlacePredictions(
        address: '',
        placeId: '',
        name: '',
      ),
    )
  ].obs;

  void addHomePages() {
    homepages = const [PlacesMain(), MapMain(), Profile()];
  }
}
