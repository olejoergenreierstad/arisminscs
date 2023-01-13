import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

class MapMainPhone extends StatefulWidget {
  const MapMainPhone({key});

  @override
  State<MapMainPhone> createState() => _MapMainPhoneState();
}

class _MapMainPhoneState extends State<MapMainPhone> {
  @override
  Completer<GoogleMapController> _controller = Completer();
  final Set<Heatmap> _heatmaps = {};
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final LatLng _heatmapLocation =
      const LatLng(37.42845842075219, -122.08664014935495);

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                print('ontap');
                _addHeatmap();
              },
              child: Container(
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                print('ontap');
                setState(() {});
              },
              child: Container(
                height: 20,
                width: 20,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Expanded(
          child: GoogleMap(
            onTap: ((argument) {
              print(argument.latitude.toString() +
                  "," +
                  argument.longitude.toString());
            }),
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            heatmaps: _heatmaps,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ],
    );
  }

  void _addHeatmap() {
    setState(() {
      _heatmaps.add(Heatmap(
          heatmapId: HeatmapId(DateTime.now().toIso8601String()),
          points: _createPoints(_heatmapLocation),
          radius: Platform.isIOS ? 100 : 30,
          opacity: Platform.isIOS ? 1 : 0.7,
          visible: true,
          gradient: HeatmapGradient(
              colors: [Colors.green, Colors.red],
              startPoints: Platform.isIOS ? [0.5, 0.8] : [0.2, 0.8])));
    });
  }
  //heatmap generation helper functions

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }

  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));

    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(
        _createWeightedLatLng(location.latitude - 1, location.longitude, 1));
    return points;
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

dynamic getMapMain() {
  return const MapMainPhone();
}
