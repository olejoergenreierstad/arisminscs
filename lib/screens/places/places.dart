import 'dart:math';

import 'package:AirmineStudy/screens/home/homecontroller.dart';
import 'package:AirmineStudy/screens/places/placedetails.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AirmineStudy/functions/functions.dart';
import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/models/usermodels.dart';
import 'package:AirmineStudy/testdata.dart';

import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PlacesMain extends StatefulWidget {
  const PlacesMain({super.key});

  @override
  State<PlacesMain> createState() => _PlacesMainState();
}

class _PlacesMainState extends State<PlacesMain> {
  var homecontroller = Get.put(HomeController());

  @override
  void initState() {
    homecontroller.testplaces = getTestPlaces().obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Place> testplaces = getTestPlaces();
    return Obx(
      () => ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
            itemCount: homecontroller.testplaces.length,
            itemBuilder: (context, index) {
              return PlaceMainTile(
                index: index,
                place: homecontroller.testplaces[index],
              );
            }),
      ),
    );
  }
}

class PlaceMainTile extends StatefulWidget {
  final Place place;
  final int index;
  const PlaceMainTile({super.key, required this.place, required this.index});

  @override
  State<PlaceMainTile> createState() => _PlaceMainTileState();
}

class _PlaceMainTileState extends State<PlaceMainTile> {
  late User user;
  late List<int> testDataPollenIntensity;

  @override
  void initState() {
    testDataPollenIntensity = [];
    user = getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.place.customName,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      widget.place.adress,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.share,
                  size: 20,
                  color:
                      Random().nextInt(2) == 1 ? Colors.black38 : Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var temp = Random();
                      testDataPollenIntensity.clear();
                      testDataPollenIntensity.add(temp.nextInt(10));

                      return PollenReportTile(
                        testPollenData: testDataPollenIntensity,
                        place: widget.place,
                        index: index,
                        pollenType: user.allergicTypes!,
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PollenReportTile extends StatelessWidget {
  final List<PollenType> pollenType;
  final List<int> testPollenData;
  final int index;
  final Place place;
  const PollenReportTile(
      {super.key,
      required this.pollenType,
      required this.index,
      required this.testPollenData,
      required this.place});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int totalAirquality;
    totalAirquality = getTotalAirquality(testPollenData);
    Widget weatherWidget;
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceDetailMain(
                          place: place,
                          totalAirquality: totalAirquality,
                        )));
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            width: width / 2,
            decoration: BoxDecoration(
              gradient: getGradient(
                intensity: totalAirquality,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 0.5)
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                children: [
                  FutureBuilder<Widget>(
                      future: getWeather(
                          color: Colors.white,
                          place: place.googleName,
                          index: index,
                          context: context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 20,
                          );
                        } else {
                          return SizedBox(height: 20, child: snapshot.data!);
                        }
                      }),
                  Flexible(
                    flex: 3,
                    child: Center(
                      child: CircularStepProgressIndicator(
                        totalSteps: 20,
                        currentStep: totalAirquality * 2,
                        stepSize: 3,
                        selectedColor: Colors.black54,
                        unselectedColor: Colors.white,
                        padding: 0.2,
                        width: 100,
                        height: 100,
                        selectedStepSize: 3,
                        roundedCap: (_, __) => true,
                        child: Center(
                            child: Text(
                          getAirQualityDescription(
                              context: context, intensity: totalAirquality),
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: getUser().allergicTypes!.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 2) {
                                return const PollenWidget(
                                    pollenType: PollenType.air);
                              } else {
                                return PollenWidget(
                                    pollenType:
                                        getUser().allergicTypes![index]);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class PollenWidget extends StatelessWidget {
  final PollenType pollenType;
  final Color color;

  const PollenWidget(
      {super.key, required this.pollenType, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    var strength = Random();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    getPollenIcon(pollentype: pollenType),
                    color: color,
                  ),
                  Text(
                    strength.nextInt(10).toString(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
