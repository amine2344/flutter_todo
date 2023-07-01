import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/notification_manager.dart';
import 'package:todo_app/services/shared_preferences_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _sharedPrefService = locator<SharedPreferencesService>();
  final _notificationManager = locator<NotificationManager>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final _signOutTopic = "BUYER_APP_SIGN_OUT";
  final _pushRCTopic = "BUYER_APP_PUSH_REMOTE_CONFIG";

  Future<void> initialise() async {
    print("PushNotificationService initialise");
    if (Platform.isIOS) {
      NotificationSettings notificationSettings = await _fcm.requestPermission(sound: true, badge: true, alert: true);
      debugPrint(
          "Settings registered: ${notificationSettings.authorizationStatus}");
    }
    await _notificationManager.initNotifications();

    String? token = await _fcm.getToken();
    _onFCMTokenRefresh(token);

    _fcm.onTokenRefresh.listen((token) {
      _onFCMTokenRefresh(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage data: ${message.data}");
      _handleNotification(message);
    });

    RemoteMessage? onLaunchMessage = await _fcm.getInitialMessage();
    if (onLaunchMessage != null) {
      debugPrint("onLaunchMessage data: ${onLaunchMessage.data}"); // direct launch when app is killed
      Future.delayed(Duration(seconds: 1), () {
        _isTopicNotification(onLaunchMessage)
            ? _handleTopicNotifications(onLaunchMessage)
            : _handleTopicNotifications(onLaunchMessage);
      });
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('onMessageOpenedApp data: ${message.data}');
      _isTopicNotification(message)
          ? _handleTopicNotifications(message)
          : _handleTopicNotifications(message);
    });
  }

  _onFCMTokenRefresh(String? token) async {
    debugPrint("Token $token");
    if (token == null || _sharedPrefService.token == token) return;
    _sharedPrefService.token = token;
    _subscribeToDefaultTopics();
  }

  _subscribeToDefaultTopics() {
    _fcm.subscribeToTopic(_signOutTopic);
    _fcm.subscribeToTopic(_pushRCTopic);
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    debugPrint("BackgroundMessageHandler $message");
    // Or do other work.
    return Future.value(0);
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    debugPrint("Handle Notification $message");
    RemoteNotification? notification = message.notification;
    if (notification == null) return;

    message.data.forEach((key, value) {
      debugPrint("handle key: $key, value: $value");
    });

    if (_isTopicNotification(message)) {
      await _handleTopicNotifications(message);
    }

    var title = notification.title ?? "";
    var body = notification.body ?? "";
    var payload = json.encode(message.data);
    var imageUrl = "";

    if (Platform.isIOS && notification.apple != null) {
      imageUrl = notification.apple!.imageUrl ?? "";
    } else if (notification.android != null) {
      imageUrl = notification.android!.imageUrl ?? "";
    }

    if (message.data.containsKey("image")) {
      imageUrl = message.data["image"];
    }

    debugPrint("Notification data $title, $body");

    _notificationManager.showNotification(title, body, payload);
  }

  bool _isTopicNotification(RemoteMessage message) {
    return ((message.from != null && message.from!.contains("topics")) || (message.data.containsKey("topics")));
  }

  Future _handleTopicNotifications(RemoteMessage message) async {
    String topic = message.from != null ? message.from!.substring(8) : message.data['topics'];
    if (topic == _signOutTopic) {
      await _authService.logout();
      await _navigationService.clearStackAndShow(Routes.loginView);
    }

  }
}
