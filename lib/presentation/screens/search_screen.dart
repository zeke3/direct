import 'dart:convert';

import 'package:direct/data/models/places/place_prediction_model.dart';
import 'package:direct/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPlace extends StatefulWidget {
  const SearchPlace({super.key});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  List<PlacePredictionModel> predictions = [];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Material(
      child: SafeArea(
        child: Container(
          
          height: deviceHeight,
          child: Column(
            children: [
              // Other widgets can go here
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    // onTap: () async {
                    //   // Prediction p = await PlacesAutocomplete.show(
                    //   //     context: context,
                    //   //     apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
                    //   //     mode: Mode.overlay, // Mode.overlay for full-screen
                    //   //     language: "en",
                    //   //     components: [Component(Component.country, "us")]);
          
                    //   // if (p != null) {
                    //   //   // Handle the selected location (p)
                    //   //   print(p.description);
                    //   // }
                    // },
                    onChanged: (String value) async {
                      var places = await placeAutoComplete(value);
                      setState(() {
                            predictions =  places;
                        
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search for a place',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              ),
              // ListView.builder as part of the Column
              predictions.isNotEmpty ? 
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length, // Replace with your actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(predictions[index].mainText),
                      subtitle: Text(predictions[index].secondaryText),
                    );
                  },
                ),
              ) :
              const Center(child:Text(""))
                        
              // Other widgets can go here
            ],
          ),
        ),
      ),
    );
  }

  Future<List<PlacePredictionModel>> placeAutoComplete(String place) async {
    var apiKey = Environment.apiKey;
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=${apiKey}&components=country:tz");

    var response = await http.get(url);

    if (response.statusCode == 200) {

      var json = jsonDecode(response.body);
      var predictions = json['predictions'];
      List<PlacePredictionModel> places = [];
      for (var place in predictions) {
        var location = PlacePredictionModel.fromJson(place);
        places.add(location);
      }

      // List of place predictions
      return places;
    }
    else {
      return <PlacePredictionModel> [];
    }
  }
}

// class SearchBarField extends StatefulWidget {
//   @override
//   State<SearchBarField> createState() => _SearchBarFieldState();
// }

// class _SearchBarFieldState extends State<SearchBarField> {
//   String placeQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: TextField(
//           // onTap: () async {
//           //   // Prediction p = await PlacesAutocomplete.show(
//           //   //     context: context,
//           //   //     apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
//           //   //     mode: Mode.overlay, // Mode.overlay for full-screen
//           //   //     language: "en",
//           //   //     components: [Component(Component.country, "us")]);

//           //   // if (p != null) {
//           //   //   // Handle the selected location (p)
//           //   //   print(p.description);
//           //   // }
//           // },
//           onChanged: (String value) async {
//             await placeAutoComplete(value);
//           },
//           decoration: const InputDecoration(
//             hintText: 'Search for a place',
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.all(8.0),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> placeAutoComplete(String place) async {
//     var apiKey = Environment.apiKey;
//     var url = Uri.parse(
//         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=${apiKey}&components=country:tz");

//     var response = await http.get(url);

//     print(response.body);
//   }
// }
