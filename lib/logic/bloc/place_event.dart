part of 'place_bloc.dart';

@immutable
sealed class PlaceEvent {}

final class FetchingPlaces extends PlaceEvent {
  final String place;

  FetchingPlaces({required this.place});
}
