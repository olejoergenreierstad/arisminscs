import 'package:AirmineStudy/screens/home/homecontroller.dart';
import 'package:AirmineStudy/screens/home/web/content/homepage.dart';
import 'package:AirmineStudy/screens/home/web/homeweb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'content_tab.dart';

class MenuItems {
  final String title;
  final Color specialColor;
  final Widget content;
  final List<MenuItems> subItems;

  MenuItems({
    @required this.content,
    @required this.title,
    @required this.subItems,
    this.specialColor = Colors.transparent,
  });
}

List<dynamic> createPages({@required List<MenuItems> titles}) {
  // Add menu and pages
  int counter = 1;
  var homeWbController = Get.put(HomeWebController());
  List<dynamic> result = [];

  List<RxBool> hover = [false.obs];
  homeWbController.pages = [const WebLandingPage()];

  for (MenuItems menuitem in titles) {
    RxBool hover1 = false.obs;
    List<dynamic> resultSubItems = [];

    if (menuitem.subItems.isNotEmpty) {
      for (MenuItems submenuitem in menuitem.subItems) {
        RxBool hover2 = false.obs;
        resultSubItems.add({
          'id': counter,
          'hover': hover2,
          'widget': Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MouseRegion(
                onEnter: (event) {
                  hover2.value = true;
                },
                onExit: (event) {
                  hover2.value = false;
                },
                child: HomeTopPageMenuItem(
                  specialFillColor: submenuitem.specialColor,
                  isSubitem: true,
                  textColor: Colors.black,
                  hover: hover2.value,
                  pageIndex: counter,
                  title: submenuitem.title,
                ),
              ),
            ),
          )
        });
        homeWbController.pages.add(submenuitem.content);
        counter++;
      }
    }

    result.add({
      'id': counter,
      'hover': hover1,
      'widget': MouseRegion(
        onEnter: (event) {
          hover1.value = true;
        },
        onExit: (event) {
          hover1.value = false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Obx(
                  () => HomeTopPageMenuItem(
                    specialFillColor: menuitem.specialColor,
                    fillColor: Colors.blue,
                    hover: hover1.value,
                    pageIndex: counter,
                    title: menuitem.title,
                  ),
                ),
                Obx(
                  () => AnimatedOpacity(
                    curve: Curves.easeInOut,
                    opacity: hover1.value && resultSubItems.isNotEmpty ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: resultSubItems.map((r) {
                                return GestureDetector(
                                  onTap: () {
                                    homeWbController.pageController
                                        .jumpToPage(r['id']);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: r['widget'],
                                  ),
                                );
                              }).toList(),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    });
    homeWbController.pages.add(menuitem.content);
    counter++;
    hover.add(false.obs);
  }

  return result;
}
