class PlacePredictionModel {
  final String description;
  final String mainText;
  final String secondaryText;
  final String placeId;

  PlacePredictionModel(
      {required this.description,
      required this.mainText,
      required this.secondaryText,
      required this.placeId});

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) {
    return PlacePredictionModel(
      description: json['description'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'],
      placeId: json['place_id'],
    );
  }
}
