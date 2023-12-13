import 'package:direct/data/dataproviders/place_dataproviders.dart';
import 'package:direct/data/models/places/place_model.dart';

class PlaceRepository {
  PlaceDataprovider placeDataprovider = PlaceDataprovider();

  Future<List<PlaceModel>> fetchPlaces({String placeQuery = ''}) async {
    return placeDataprovider.fetchPlaces(placeQuery: placeQuery);
  }
}
