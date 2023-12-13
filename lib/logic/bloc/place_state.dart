part of 'place_bloc.dart';

@immutable
sealed class PlaceState {}

final class PlaceInitial extends PlaceState {}

final class PlacesLoading extends PlaceState {}

final class PlacesLoaded extends PlaceState {
  final List<PlaceModel> places;

  PlacesLoaded({required this.places});
}

final class PlacesEmpty extends PlaceState {}


final class PlacesFetchingError extends PlaceState {
  final String message;

  PlacesFetchingError({required this.message});
}