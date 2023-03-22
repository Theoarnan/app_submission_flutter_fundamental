import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {
  static String generateInitialText(String text) {
    String initial = '';
    String initialDash = '--';
    if (text.length > 2) {
      if (text[text.length - 1] == ' ') {
        initialDash = text.substring(0, text.length - 2);
      } else {
        initialDash = text;
      }
      initial = '';
      initialDash.split(' ').map((String text) {
        if (initial.length != 5) {
          if (text.length < 2) {
            initial += text;
          } else {
            initial += text.substring(0, 1).toUpperCase();
          }
        }
      }).toList();
    }
    return initial;
  }

  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;
  }
}
