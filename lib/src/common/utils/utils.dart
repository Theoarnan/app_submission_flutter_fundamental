import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

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
    } else {
      initial = text;
    }
    return initial;
  }

  Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;
  }

  static DateTime format() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "00:46:30";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
