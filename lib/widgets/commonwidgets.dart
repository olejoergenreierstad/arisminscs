import 'dart:async';
import 'dart:math';

import 'package:AirmineStudy/functions/functions.dart';
import 'package:AirmineStudy/models/placemodels.dart';
import 'package:AirmineStudy/screens/home/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/placefunctions.dart';

class SearchBoxWidget extends StatelessWidget {
  final PlacePredictions placePredictions;
  const SearchBoxWidget({Key? key, required this.placePredictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homecontroller = Get.put(HomeController());

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: GestureDetector(
        onTap: () async {
          var temp = Random();
          homecontroller.testplaces.insert(
            0,
            Place(
                googleName: placePredictions.name,
                customName: placePredictions.name,
                adress: placePredictions.address,
                airquality: [
                  Airquality(
                      pollenType: PollenType.air,
                      density: temp.nextInt(10) * 1.0,
                      date: DateTime.now()),
                  Airquality(
                      pollenType: PollenType.birch,
                      density: temp.nextInt(10) * 1.0,
                      date: DateTime.now()),
                  Airquality(
                      pollenType: PollenType.gras,
                      density: temp.nextInt(10) * 1.0,
                      date: DateTime.now()),
                ]),
          );
          homecontroller.showSearch.value = false;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placePredictions.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(placePredictions.address),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StdInputbox extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String) onType;
  final Function(bool) isDest;
  final Widget suffixicon;
  final bool isDestination;
  final bool isPlaceSearch;
  const StdInputbox(
      {Key? key,
      required this.onType,
      required this.isDest,
      this.hint = "",
      this.title = "",
      this.isPlaceSearch = false,
      this.isDestination = false,
      this.suffixicon = const SizedBox()})
      : super(key: key);

  @override
  State<StdInputbox> createState() => _StdInputboxState();
}

class _StdInputboxState extends State<StdInputbox> {
  Timer? searchOnStoppedTyping;
  var homecontroller = Get.put(HomeController());

  _onChangeHandler(value) {
    // Set isLoading = true in parent
    // Make sure that requests are not made
    // until 1 second after the typing stops
    if (searchOnStoppedTyping != null) {
      homecontroller.searchResultWidgets.clear();
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(() => searchOnStoppedTyping =
            Timer(const Duration(milliseconds: 200), () async {
          List<PlacePredictions> temp = await getSearchResultsFromQuery(value);

          for (PlacePredictions place in temp) {
            homecontroller.searchResultWidgets.add(SearchBoxWidget(
              placePredictions: PlacePredictions(
                address: place.address,
                placeId: place.placeId,
                name: place.name,
              ),
            ));
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (val) {
              _onChangeHandler(val);
            },
            autofocus: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: widget.suffixicon,
              suffix: const SizedBox(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(width: 2)),
              hintText: widget.hint,
            ),
          ),
        ],
      ),
    );
  }
}
