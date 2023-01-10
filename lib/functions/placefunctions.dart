import 'package:AirmineStudy/models/placemodels.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as gp;

Future<TextSearchResponse> getPlace({required String pos}) async {
  var googlePlace = GooglePlace("AIzaSyBETUMiohFIuDJrgXAZt14z3Sbw07WEOCg");

  var result = await googlePlace.search.getTextSearch(pos);

  return result!;
}

Future<List<PlacePredictions>> getSearchResultsFromQuery(String query) async {
  List<PlacePredictions> searchresult = [];

  final places =
      gp.FlutterGooglePlacesSdk('AIzaSyBETUMiohFIuDJrgXAZt14z3Sbw07WEOCg');
  final predictions = await places.findAutocompletePredictions(
    query,
  );

  if (query.isNotEmpty) {
    searchresult.clear();

    if (predictions.predictions!.isNotEmpty) {
      for (gp.AutocompletePrediction re in predictions.predictions) {
        //  DetailsResponse? place = await googlePlace.details.get(re.placeId!);
        PlacePredictions data2 = PlacePredictions(
          name: re.primaryText,
          address: re.secondaryText,
          placeId: re.placeId,
          /* lat: place!.result!.geometry!.location!.lat ?? 0.0,
          lng: place.result!.geometry!.location!.lng ?? 0.0,*/
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
