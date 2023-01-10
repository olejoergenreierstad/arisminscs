import 'package:AirmineStudy/models/placemodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';

Future<TextSearchResponse> getPlace({required String pos}) async {
  var googlePlace = GooglePlace(dotenv.env['google_api_key']!);

  var result = await googlePlace.search.getTextSearch(pos);

  return result!;
}

Future<List<PlacePredictions>> getSearchResultsFromQuery(String query) async {
  List<PlacePredictions> searchresult = [];

  if (query.isNotEmpty) {
    var googlePlace = GooglePlace(dotenv.env['google_api_key']!);

    var result = await googlePlace.autocomplete.get(
      query,
      language: "no",
      region: "no",
      // strictbounds: true,
      radius: 10000,
    );

    searchresult.clear();

    if (result!.predictions!.isNotEmpty) {
      for (AutocompletePrediction re in result.predictions!) {
        DetailsResponse? place = await googlePlace.details.get(re.placeId!);
        PlacePredictions data2 = PlacePredictions(
          name: re.structuredFormatting!.mainText ?? "Name",
          address: re.structuredFormatting!.secondaryText ?? "Adress",
          placeId: re.placeId!,
          lat: place!.result!.geometry!.location!.lat ?? 0.0,
          lng: place.result!.geometry!.location!.lng ?? 0.0,
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
