import 'dart:isolate';
import 'dart:ui';

import 'package:app_submission_flutter_fundamental/main.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/notification_helper.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/services/remote_services.dart';
import 'package:flutter/foundation.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    RestaurantModel result = await RemoteServicesImpl().getRandomRestaurant();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    if (kDebugMode) {
      print('Updated data from the background isolate');
    }
  }
}
