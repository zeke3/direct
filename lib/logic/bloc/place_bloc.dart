import 'package:bloc/bloc.dart';
import 'package:direct/data/models/places/place_model.dart';
import 'package:direct/data/repositories/place_repository.dart';
import 'package:meta/meta.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceRepository placeRepository;
  PlaceBloc({required this.placeRepository}) : super(PlaceInitial()) {
    on<FetchingPlaces>(fetchPlaces);
  }

  Future<void> fetchPlaces(
      FetchingPlaces event, Emitter<PlaceState> emit) async {
    emit(PlacesLoading());
    try {
      var places = await placeRepository.fetchPlaces(placeQuery: event.place);
      if (places.isNotEmpty) {
        emit(PlacesLoaded(places: places));
      } else {
        emit(PlacesEmpty());
      }
    } catch (e) {
      emit(PlacesFetchingError(message: 'error: $e'));
    }
  }
}
