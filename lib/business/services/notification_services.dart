import 'dart:math';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted permission: ${settings.authorizationStatus}');
    } else {
      print('User denied permission: ${settings.authorizationStatus}');
    }
  }

  Future<void> initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/app_icon');
    var iosInitialize = const DarwinInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void firebaseInit() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    //analytics.logAppOpen();
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message title: ${message.notification!.title.toString()}');
        print('Message body: ${message.notification!.body.toString()}');
      }
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'Hight Importance Notifications',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: "@drawable/app_icon",
      color: const Color.fromRGBO(211, 50, 95, 1),
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    if (kDebugMode) {
      print('Title: ${message.notification!.title}');
      print('Body: ${message.notification!.body}');
    }

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefreshed() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('Token Refreshed');
    });
  }
}
