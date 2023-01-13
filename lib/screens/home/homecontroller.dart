import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/screens/home/web/content/infoscreens.dart';
import 'package:AirmineStudy/screens/home/web/content_view.dart';

import 'package:AirmineStudy/widgets/commonwidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:AirmineStudy/screens/Profile/profile.dart';
import 'package:AirmineStudy/screens/places/places.dart';

import 'package:AirmineStudy/screens/map/mapphone.dart'
    if (dart.library.html) 'package:AirmineStudy/screens/map/mapweb.dart'
    as maps;

class HomeWebController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxBool setBackGroundColor = false.obs;

  late List<MenuItems> subitems1;
  late List<MenuItems> mainItems;
  late List<dynamic> menuItems;
  late List<Widget> pages;

  void setWebPages() {
    // Main menu items
    subitems1 = [
      MenuItems(content: InfoScreens(), title: 'Infoskjermer', subItems: []),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.brown,
          ),
          title: 'Netwidgets',
          subItems: []),
      /*'Våre løsninger',
      'Pollenvarsel',
      'Nyttig lesning',
      'Om oss'*/
    ];
    List<MenuItems> subitems2 = [
      MenuItems(content: InfoScreens(), title: 'Infoskjermer', subItems: []),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.brown,
          ),
          title: 'Netwidgets',
          subItems: []),
      /*'Våre løsninger',
      'Pollenvarsel',
      'Nyttig lesning',
      'Om oss'*/
    ];

    mainItems = [
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.yellow,
          ),
          title: 'Våre løsninger',
          subItems: subitems1),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
          ),
          title: 'Pollenvarsel',
          subItems: subitems2),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
          ),
          title: 'Nyttig lesning',
          subItems: []),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
          ),
          title: 'Om oss',
          subItems: subitems2),
      MenuItems(
          content: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey,
            child: Center(child: Text('LoginPage (Todo)')),
          ),
          specialColor: Colors.blue,
          title: 'Logg inn',
          subItems: []),
      /*'Våre løsninger',
      'Pollenvarsel',
      'Nyttig lesning',
      'Om oss'*/
    ];

    // Add pages and menu;
    menuItems = createPages(
      titles: mainItems,
    );
  }

  // Create the pages;

}

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
    homepages = [const PlacesMain(), maps.getMapMain(), const Profile()];
  }
}
