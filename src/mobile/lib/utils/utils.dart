import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static const primaryFontColor = Color(0xFF313131);
  static const primaryColor = Color(0xFFBB0C24);
  // background of all screens
  static const primaryBackground = Color(0xFFF8F8F8);

  static const secondaryButtonColor = Color(0xFF3B3B3B);
  static const white = Color(0xFFFFFFFF);
  // for smaller fonts
  static const secondaryFontColor = Color(0xFFC3C3C3);
  static const secondaryGreen = Color(0xFF25D366);
  static const secondaryPeach = Color(0xFFFA6E6E);

  static String? backendUrl = dotenv.env['BACKEND_URL'];

  static const headerValue = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
}
