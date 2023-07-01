import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class NotificationManager {
  final _navigationService = locator<NavigationService>();
  final _sharedPrefService = locator<SharedPreferencesService>();
  final _snackBarService = locator<SnackbarService>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@drawable/todo_app');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body, String payload) async {
    print("Show Notification: $title $body");
    await flutterLocalNotificationsPlugin
        .show(new Random().nextInt(1000), title, body, getPlatformChannelSpecifics(), payload: payload);

  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  getPlatformChannelSpecifics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'RedBasil', 'RedBasil App',
        channelDescription: 'The RedBasil Restaurant App',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'restaurantApp');
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print('Notification received $id, $title,$payload');
    return Future.value(1);
  }

}
