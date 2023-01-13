import 'dart:html' as ht;
import 'dart:math';

import 'dart:ui' as ui;

import 'package:AirmineStudy/functions/functions.dart';
import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/testdata.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps_visualization.dart';
//import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps/google_maps.dart' as gm;

dynamic getMapMain() {
  return const MapMainWeb();
}

final citymap = {
  'chicago': {
    'center': gm.LatLng(41.878113, -87.629798),
    'population': 2842518
  },
  'newyork': {
    'center': gm.LatLng(40.714352, -74.005973),
    'population': 8143197
  },
  'losangeles': {
    'center': gm.LatLng(34.052234, -118.243684),
    'population': 3844829
  },
  'vancouver': {'center': gm.LatLng(49.25, -123.1), 'population': 603502}
};

HeatmapLayer heatmap;

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    var myLatlng = gm.LatLng(37.774546, -122.433523);
    myLatlng = gm.LatLng(60.13550720381226, 11.201679146612745); //Jessheim

    final mapOptions = gm.MapOptions()
      ..mapTypeId = gm.MapTypeId.SATELLITE
      ..streetViewControl = false
      ..zoom = 14
      ..center = myLatlng;

    final elem = ht.DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = gm.GMap(elem, mapOptions);

    citymap.forEach((String name, Map city) {
      final populationOptions = gm.CircleOptions()
        ..strokeColor = '#FF0000'
        ..strokeOpacity = 0.8
        ..strokeWeight = 2
        ..fillColor = '#FF0000'
        ..fillOpacity = 0.35
        ..map = map
        ..center = city['center'] as gm.LatLng
        ..radius = sqrt(city['population'] as int) * 100;
      gm.Circle(populationOptions);
    });

    heatmap = HeatmapLayer(HeatmapLayerOptions()
      ..radius = 25
      ..maxIntensity = 10
      ..data = pointsJessheim
      ..map = map);

    map.onDblclick.listen((event) {});

    map.onZoomChanged.listen((event) {
      print(map.zoom);
    });

    map.onClick.listen((mapsMouseEvent) {
      print(mapsMouseEvent.latLng);

      /*  heatmap.set(
          'gradient', heatmap.get('gradient') != null ? null : gradient);
      heatmap = HeatmapLayer(HeatmapLayerOptions()
        ..radius = 25
        ..maxIntensity = 5
        ..data = points
        ..map = map);*/
      //  points.add(mapsMouseEvent.latLng!);
    });

    gm.Circle(gm.CircleOptions()
      ..center = myLatlng
      ..strokePosition = gm.StrokePosition.CENTER
      ..strokeColor = "#2271cce7"
      ..strokeWeight = 5
      ..strokeOpacity = 1
      ..fillColor = "#2271cce7"
      ..map = map
      ..radius = 10);

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}

class MapMainWeb extends StatefulWidget {
  const MapMainWeb({key});

  @override
  State<MapMainWeb> createState() => _MapMainWebState();
}

class _MapMainWebState extends State<MapMainWeb> {
  @override
  void initState() {
    // TODO: implement initState
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getMap(),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 20),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(
                            getPollenIcon(pollentype: PollenType.gras),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                            border: Border.all(width: 3, color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(
                              getPollenIcon(pollentype: PollenType.birch),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
