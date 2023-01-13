import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:get/get.dart';
import '../../../widgets/commonwidgets.dart';
import '../homecontroller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../homecontroller.dart';

class HomePageMainMobile extends StatefulWidget {
  const HomePageMainMobile({key});

  @override
  State<HomePageMainMobile> createState() => _HomePageMainMobileState();
}

class _HomePageMainMobileState extends State<HomePageMainMobile>
    with SingleTickerProviderStateMixin {
  var homecontroller = Get.put(HomeController());

  @override
  void initState() {
//init();
    super.initState();

    homecontroller.addHomePages();
    initControllers();

    print('initstat');
  }

  @override
  void dispose() {
    homecontroller.tabController.dispose();
    super.dispose();
  }

  void initControllers() {
    homecontroller.pageController = PageController();
    homecontroller.tabController = TabController(
        initialIndex: 0, length: homecontroller.homepages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: kIsWeb
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/airMineLogo.png',
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                homecontroller.searchResultWidgets.clear();
                                homecontroller.showSearch.value =
                                    homecontroller.showSearch.value;
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.transparent,
                                  child:
                                      const Center(child: Icon(Icons.search))),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: homecontroller.pageController,
                            itemBuilder: ((context, index) {
                              return homecontroller.homepages[index];
                            })),
                      ),
                      const MainMenu(),
                    ],
                  ),
                  Obx(
                    () => Visibility(
                      visible: homecontroller.showSearch.value,
                      child: GestureDetector(
                        onTap: () {
                          homecontroller.showSearch.value = false;
                        },
                        child: Container(
                          color: Colors.black38,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 60,
                              top: 15,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StdInputbox(
                                    hint: AppLocalizations.of(context)
                                        .placeSearch,
                                    onType: (p0) {},
                                    isDest: (p0) {},
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 400),
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: homecontroller
                                              .searchResultWidgets.length,
                                          itemBuilder: (context, index) {
                                            return homecontroller
                                                .searchResultWidgets[index];
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var homecontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          onTap: (value) {
            homecontroller.pageController.animateToPage(value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          controller: homecontroller.tabController,
          indicatorColor: Colors.grey,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicator: UnderlineTabIndicator(
            insets: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.home,
              ),
              iconMargin: EdgeInsets.all(1),
            ),
            Tab(
              icon: Icon(
                Icons.location_on_outlined,
              ),
              iconMargin: EdgeInsets.all(1),
            ),
            Tab(
              icon: Icon(
                Icons.person,
              ),
              iconMargin: EdgeInsets.all(1),
            ),
          ]),
    );
  }
}
