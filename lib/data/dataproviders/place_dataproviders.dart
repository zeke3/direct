import 'dart:convert';

import 'package:direct/data/models/places/display_name.dart';
import 'package:direct/data/models/places/location.dart';
import 'package:direct/data/models/places/place_model.dart';
import 'package:direct/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PlaceDataprovider {
  // Fetching list of places objects from Place API
  Future<List<PlaceModel>> fetchPlaces({String placeQuery = ''}) async {
    var url = Uri.parse("https://places.googleapis.com/v1/places:searchText");

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': Environment.apiKey, //Attaching GMS API key
          'X-Goog-FieldMask':
              'places.name,places.id,places.displayName,places.formattedAddress,places.location',
        },
        body: jsonEncode({"textQuery": placeQuery}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<PlaceModel> places = [];
      for (var json in jsonResponse) {
        // Converting json objects to dart objects(models)
        DisplayNameModel displayName =
            DisplayNameModel.fromJson(json['displayName']);
        LocationModel location = LocationModel.fromJson(json['location']);
        // Replacing json values with dart objects
        json['displayName'] = displayName;
        json['location'] = location;

        PlaceModel place = PlaceModel.fromJson(json);
        places.add(place);
      }

      if (kDebugMode) {
        print("PLACES: $places");
      }

      return places;
    }

    else {
      throw response.statusCode;
    }
  }
}
