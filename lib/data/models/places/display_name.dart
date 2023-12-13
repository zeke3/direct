import 'package:equatable/equatable.dart';

class DisplayNameModel extends Equatable {
  final String text;
  final String languageCode;

  const DisplayNameModel({required this.text, required this.languageCode});

  @override
  // TODO: implement props
  List<Object?> get props => [text, languageCode];

  factory DisplayNameModel.fromJson(Map<String, dynamic> json) {
    return DisplayNameModel(
        text: json['text'], languageCode: json['languageCode']);
  }
}
