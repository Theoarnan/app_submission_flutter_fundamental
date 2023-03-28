import 'dart:convert';
import 'dart:developer';

import 'package:app_submission_flutter_fundamental/src/common/router/argument_detail.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/navigation.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        log('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantModel restaurantModel) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "maumakanapp";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Where do you want to eat?</b>";
    var nameRestaurant = restaurantModel.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, nameRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantModel.toMap()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var restaurant = RestaurantModel.fromJson(json.decode(payload));
        Navigation.intentWithData(
          route,
          DetailArguments(
            dataRestaurant: restaurant,
            isFromFavorite: false,
          ),
        );
      },
    );
  }
}
