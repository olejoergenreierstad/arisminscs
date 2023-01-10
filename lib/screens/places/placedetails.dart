import 'dart:math';
import 'dart:ui';

import 'package:AirmineStudy/functions/functions.dart';
import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/screens/places/places.dart';
import 'package:AirmineStudy/testdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/weather.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as gp;

class PlaceDetailMain extends StatefulWidget {
  final Place place;
  final int totalAirquality;
  const PlaceDetailMain(
      {super.key, required this.place, required this.totalAirquality});

  @override
  State<PlaceDetailMain> createState() => _PlaceDetailMainState();
}

class _PlaceDetailMainState extends State<PlaceDetailMain> {
  WeatherFactory wf = WeatherFactory("44ddaf1f63412f021f54f93765c81a44");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: kIsWeb
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width,
            ),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 5, 68, 131),
                  Color.fromARGB(255, 0, 146, 214)
                ])),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !kIsWeb
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.transparent,
                                  child: const Center(
                                      child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                            : const SizedBox(
                                width: 30,
                              ),
                        GestureDetector(
                          onTap: () async {
                            final places = gp.FlutterGooglePlacesSdk(
                                'AIzaSyBETUMiohFIuDJrgXAZt14z3Sbw07WEOCg');
                            final predictions = await places
                                .findAutocompletePredictions('Tel Aviv');

                            print('Result: $predictions');
                          },
                          child: Text(
                            widget.place.customName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<Weather>>(
                        future: wf
                            .fiveDayForecastByCityName(widget.place.googleName),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator()));
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TimeLine(
                              weatherForecast: snapshot.data,
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  final List<Weather> weatherForecast;
  const TimeLine({super.key, required this.weatherForecast});

  @override
  Widget build(BuildContext context) {
    int currentday = DateTime.now().day;

    var newcolor = Random().nextInt(3);
    var oldcolor = Random().nextInt(3);
    Color endcolor;
    Color startcolor = Colors.green;

    if (oldcolor == 0) {
      endcolor = Colors.green;
    } else if (oldcolor == 1) {
      endcolor = Colors.amber;
    } else {
      endcolor = Colors.red;
    }
    if (newcolor == 0) {
      startcolor = Colors.green;
    } else if (newcolor == 1) {
      startcolor = Colors.amber;
    } else {
      startcolor = Colors.red;
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        cacheExtent: 100000,
        itemCount: weatherForecast.length,
        itemBuilder: (BuildContext context, int index) {
          newcolor = Random().nextInt(3);
          if (index > 0) {
            startcolor = endcolor;
          }
          if (newcolor == 0) {
            endcolor = Colors.green;
          } else if (newcolor == 1) {
            endcolor = Colors.amber;
          } else {
            endcolor = Colors.red;
          }
          Widget newDayText = const Text('I dag');

          if (currentday == weatherForecast[index].date!.day) {
            newDayText = SizedBox(
              height: 20,
              child: Text(
                getWeekDay(
                    weekDay: weatherForecast[index].date!.weekday,
                    context: context),
                style: const TextStyle(color: Colors.white),
              ),
            );
            currentday = currentday + 1;
          } else {
            newDayText = const SizedBox(
              height: 20,
            );
          }

          return SizedBox(
            height: 150,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  index == weatherForecast.length - 1 ? 10 : 0),
                              bottomRight: Radius.circular(
                                  index == weatherForecast.length - 1 ? 10 : 0),
                              topLeft: Radius.circular(index == 0 ? 10 : 0),
                              topRight: Radius.circular(index == 0 ? 10 : 0)),
                          gradient: LinearGradient(
                              colors: [startcolor, endcolor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 2,
                        width: 20,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newDayText,
                        Text(
                          getFormatedTime(
                              hour: weatherForecast[index].date!.hour,
                              minute: weatherForecast[index].date!.minute),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 55),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 30, top: 5, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              getWeatherIcon(
                                  weather: weatherForecast[index],
                                  color: Colors.white,
                                  size: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "${weatherForecast[index].temperature!.celsius!.ceil().toString()}°C",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.w200,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
