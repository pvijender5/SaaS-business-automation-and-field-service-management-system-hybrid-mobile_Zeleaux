import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zeleaux_app/controllers/login_controller.dart';
import 'package:zeleaux_app/controllers/overview_controller.dart';

import '../../../firebase_options.dart';
import '../../../utils/preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    await Firebase.initializeApp(
      name: 'zeleaux',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // Initialize Firebase Messaging
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    // iOS and Android initialization settings
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // Initialize FlutterLocalNotificationsPlugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    // Get the token
    var deviceToken = await _firebaseMessaging.getToken();
    print("Firebase Messaging Token: $deviceToken");
    SharedPreferencesUtils().saveStringPreferences(
        SharedPreferencesUtils.DEVICE_TOKEN, deviceToken ?? "");
    // Handle notifications in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print("Firebase Messaging received: ${message.toString()}");
      _showNotification(message);
        OverviewController.instance.onInitController();

    });

    // Handle notification click when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Firebase Messaging opened app: ${message.notification}");
    });

  }

  // Show notification
  Future<void> _showNotification(RemoteMessage message) async {
    String title = message.data['title'] ?? message.notification?.title ?? "No Title";
    String body = message.data['body'] ?? message.notification?.body ?? "No Body";

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'zeleaux',
      'Zeleaux',
      channelDescription: 'Zeleaux',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      platformChannelSpecifics,
      payload: message.data['route'], // Pass the route as payload
    );
  }

  // Handle notification click (when app is in the foreground or background)
  Future<void> _onSelectNotification(NotificationResponse response) async {
    String? route = response.payload; // Get the route from payload
    // if (route != null) {
    //   _navigateToPage(route); // Navigate to the page based on the payload
    // }
  }

}


