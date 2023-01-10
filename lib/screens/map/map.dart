import 'package:flutter/material.dart';
//import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

class MapMain extends StatefulWidget {
  const MapMain({super.key});

  @override
  State<MapMain> createState() => _MapMainState();
}

class _MapMainState extends State<MapMain> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



/*
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(60.13381445492129, 11.206724837630489),
    zoom: 14.4746,
  );
  static const LatLng _heatmapLocation =
      LatLng(60.13381445492129, 11.206724837630489);

  List<WeightedLatLng> locationPoints = [];

  final Set<Heatmap> _heatmaps = {};
  Set<Marker>? markers;

  Marker? marker;

  @override
  void initState() {
    /* addCustomIcon();
    marker = Marker(
        icon: markerIcon,
        markerId: MarkerId('marker'),
        position: _heatmapLocation,
        infoWindow: InfoWindow(title: 'InfoWindow'));

    markers = <Marker>{marker!};*/
    super.initState();
  }

  Future<void> addCustomIcon() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Badge.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  //60.13381445492129, 11.206724837630489

  double getrandom({bool lat = true}) {
    var rng = Random();
    if (lat == true) {
      double result = 37.43296265331129 + (rng.nextDouble() / 50);

      return result;
    } else {
      double result = -122.08832357078792 - (rng.nextDouble() / 50);

      return //-122.085749655962;
          result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,

        heatmaps: _heatmaps,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        },
        //  markers: markers,
        onTap: (argument) {
          LatLng newpoint = LatLng(argument.latitude, argument.longitude);
          _createPoints(newpoint);
          var tmp = Random();
          locationPoints.add(_createWeightedLatLng(
              argument.latitude, argument.longitude, tmp.nextInt(3)));

          if (_heatmaps.isEmpty) {
            _addHeatmap();
          }
          setState(() {});
        },
        onLongPress: (argument) {},
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _addHeatmap,
        label: const Text('Add Heatmap'),
        icon: const Icon(Icons.add_box),
      ),*/
    );
  }

  void _addHeatmap() async {
    // addCustomIcon();

    /* BitmapDescriptor temp = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/Badge.png");

    marker = Marker(
        icon: temp,
        markerId: MarkerId('marker2'),
        position: _heatmapLocation,
        infoWindow: InfoWindow(title: 'InfoWindow'));

    // markers = <Marker>{marker!};
    markers!.add(marker!);

    setState(() {});*/

    setState(() {
      _heatmaps.add(Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: locationPoints,
          radius: 50,
          opacity: 0.5,
          visible: true,
          gradient: HeatmapGradient(
              colors: const <Color>[Colors.green, Colors.yellow, Colors.red],
              startPoints: const <double>[0.1, 0.4, 0.999])));
    });
  }

  //heatmap generation helper functions
  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here

    /* for (var i = 0; i < 100; i++) {
      var randomWeight = Random();
      points.add(_createWeightedLatLng(
          getrandom(), getrandom(lat: false), randomWeight.nextInt(2)));
    }

    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    points.add(_createWeightedLatLng(
        location.latitude - 0.0015, location.longitude, 2));*/
    /* points.add(_createWeightedLatLng(
        location.latitude - 0.0013, location.longitude - 0.0018, 3));*/

    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }
}
*/