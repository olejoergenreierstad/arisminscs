import 'package:AirmineStudy/models/placemodels.dart';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as gp;

Future<List<PlacePredictions>> getSearchResultsFromQuery(String query) async {
  List<PlacePredictions> searchresult = [];

  final places =
      gp.FlutterGooglePlacesSdk('AIzaSyBETUMiohFIuDJrgXAZt14z3Sbw07WEOCg');
  final predictions = await places.findAutocompletePredictions(
    query,
  );

  if (query.isNotEmpty) {
    searchresult.clear();

    if (predictions.predictions.isNotEmpty) {
      for (gp.AutocompletePrediction re in predictions.predictions) {
        PlacePredictions data2 = PlacePredictions(
          name: re.primaryText,
          address: re.secondaryText,
          placeId: re.placeId,
        );

        searchresult.add(data2);
      }

      return searchresult;
    } else {
      return searchresult;
    }
  } else {
    searchresult.clear();
    return searchresult;
  }
}
