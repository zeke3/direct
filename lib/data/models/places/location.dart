import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final double latitude;
  final double longitude;

  const LocationModel({required this.latitude, required this.longitude});

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude];

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        latitude: json['latitude'], longitude: json['longitude']);
  }
}
