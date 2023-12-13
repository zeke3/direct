import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK URL';
  static String get apiKey => dotenv.env['API_KEY'] ?? 'MY_FALLBACK API KEY';
}
