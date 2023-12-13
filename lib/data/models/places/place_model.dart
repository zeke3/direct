// {
//     "name": "places/ChIJuxe94qVRXBgRkyl_6SJY81Y",
//     "id": "ChIJuxe94qVRXBgRkyl_6SJY81Y",
//     "formattedAddress": "Dar es Salaam, Tanzania",
//     "location": {
//         "latitude": -6.7007632,
//         "longitude": 39.2070937
//     },
//     "displayName": {
//         "text": "Africana Bus Stop",
//         "languageCode": "en"
//     }
// },

import 'package:direct/data/models/places/display_name.dart';
import 'package:direct/data/models/places/location.dart';

class PlaceModel {
  final String name;
  final String id;
  final String formattedAddress;
  final DisplayNameModel displayName;
  final LocationModel location;

  PlaceModel(
      {required this.name,
      required this.id,
      required this.formattedAddress,
      required this.displayName,
      required this.location});

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
        name: json['name'],
        id: json['id'],
        formattedAddress: json['formattedAddress'],
        displayName: json['displayName'],
        location: json['location']);
  }
}
