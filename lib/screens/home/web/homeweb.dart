import 'package:AirmineStudy/screens/home/web/content_tab.dart';
import 'package:AirmineStudy/screens/home/web/content_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homecontroller.dart';
import 'content/homepage.dart';
import 'content/infoscreens.dart';
import 'custom_tap_bar.dart';

class HomeMainWeb extends StatefulWidget {
  const HomeMainWeb({key});

  @override
  State<HomeMainWeb> createState() => _HomeMainWebState();
}

class _HomeMainWebState extends State<HomeMainWeb>
    with SingleTickerProviderStateMixin {
  var homeWebController = Get.put(HomeWebController());
  // = createPages(titles: titles, subiItems: subiItems)
  List<dynamic> subMenItems;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  double screenHeight = 0;
  double screenWidth = 0;
  double topPadding;
  double bottomPadding;

  @override
  void initState() {
    homeWebController.setWebPages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;
    return Scaffold(
      endDrawer: drawer(),
      key: scaffoldKey,
      body: LayoutBuilder(builder: (context, constrains) {
        if (constrains.maxWidth > 1000) {
          if (scaffoldKey.currentState.isEndDrawerOpen) {
            scaffoldKey.currentState.closeEndDrawer();
          }
          return desktopView();
        } else {
          return mobileView();
        }
      }),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        Center(
            child: PageView.builder(
                controller: homeWebController.pageController,
                itemCount: homeWebController.pages.length,
                itemBuilder: (context, index) {
                  /* print(index);
                  return Container(
                    color: Colors.green,
                  );*/
                  return homeWebController.pages[index];
                })),
        HomePageTopMenu(
          jumpToPage: (jumpToPage) {},
          pageIndex: 0,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: Obx(
              () => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeWebController.pageController.jumpToPage(0);
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity:
                          homeWebController.setBackGroundColor.value ? 1 : 0,
                      child: Image.asset(
                        'assets/airMineLogo.png',
                        height: 50,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeWebController.pageController.jumpToPage(0);
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity:
                          homeWebController.setBackGroundColor.value ? 0 : 1,
                      child: Image.asset(
                        'assets/airMineLogo_white.png',
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    return SizedBox(
      width: screenWidth,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: screenWidth,
                constraints: BoxConstraints(maxHeight: screenHeight * 0.65),
                child: Image.asset(
                  "assets/family_on_field.jpg",
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/airMineLogo.png', height: 50),
                  IconButton(
                    onPressed: () => scaffoldKey.currentState.openEndDrawer(),
                    icon: const Icon(Icons.menu_rounded),
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    //  return Container();
    return Drawer();
/*return Drawer(
        child: ListView(
            children: contenviews
                .map((e) => SizedBox(
                      child: ListTile(
                        title: Text(e.tab.title),
                        onTap: () {},
                      ),
                    ))
                .toList()));*/
  }
}

class HomePageTopMenu extends StatefulWidget {
  final int pageIndex;
  final Function(int jumpToPage) jumpToPage;
  const HomePageTopMenu(
      {key, @required this.pageIndex, @required this.jumpToPage});

  @override
  State<HomePageTopMenu> createState() => _HomePageTopMenuState();
}

class _HomePageTopMenuState extends State<HomePageTopMenu> {
  var homeWebcontroller = Get.put(HomeWebController());
  List<RxBool> hover;

  @override
  void initState() {
    /*  for (int i = 0; i < 20; i++) {
      hover.add(false.obs);
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AnimatedContainer(
            height: 100,
            duration: const Duration(milliseconds: 250),
            color: homeWebcontroller.setBackGroundColor.value
                ? Colors.white
                : Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              right: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: homeWebcontroller.menuItems.map((e) {
                    return GestureDetector(
                      onTap: () {
                        homeWebcontroller.pageController.jumpToPage(e['id']);
                      },
                      child: Container(
                        child: e['widget'],
                      ),
                    );
                  }).toList(),
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: HomeTopPageMenuItem(
                        hover: hover[0].value,
                        pageIndex: 4,
                        title: 'Logg inn',
                        fillColor: Colors.blue,
                        jumpToPage: (jumpToPage) {},
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTopPageMenuItem extends StatefulWidget {
  final int pageIndex;
  final String title;
  final bool hover;
  final bool isSubitem;
  final Color fillColor;
  final Color textColor;
  Color specialFillColor;

  HomeTopPageMenuItem(
      {key,
      @required this.pageIndex,
      @required this.title,
      @required this.hover,
      this.isSubitem = false,
      this.textColor = Colors.black,
      this.specialFillColor = Colors.transparent,
      this.fillColor = Colors.transparent});

  @override
  State<HomeTopPageMenuItem> createState() => _HomeTopPageMenuItemState();
}

class _HomeTopPageMenuItemState extends State<HomeTopPageMenuItem> {
  RxBool animateColor;
  Color fillColor;
  Color textColor;

  var homeWebcontroller = Get.put(HomeWebController());

  @override
  void initState() {
    animateColor = false.obs;
    fillColor = widget.fillColor;
    textColor = Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.hover) {
        fillColor =
            widget.isSubitem ? Colors.black.withOpacity(0.05) : Colors.white24;
      } else {
        fillColor = Colors.transparent;
      }

      if (homeWebcontroller.setBackGroundColor.value) {
        textColor = Colors.black;
        fillColor = widget.hover ? Colors.black12 : Colors.transparent;
      } else {
        textColor = Colors.white;
      }

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: widget.specialFillColor = Colors.transparent == true
                ? widget.specialFillColor
                : fillColor,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              color: widget.isSubitem ? Colors.black : textColor,
            ),
          ),
        ),
      );
    });
  }
}
