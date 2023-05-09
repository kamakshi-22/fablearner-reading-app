import 'package:fablearner_app/business/localStorage/local_storage.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class NotificationServices {
  /* -------------------------------------------------------------------------- */
  /*                                  initialize                                */
  /* -------------------------------------------------------------------------- */
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /* -------------------------------------------------------------------------- */
  /*                       request notification permission                      */
  /* -------------------------------------------------------------------------- */
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (kDebugMode) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission: ${settings.authorizationStatus}');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted permission: ${settings.authorizationStatus}');
      } else {
        print('User denied permission: ${settings.authorizationStatus}');
      }
    }
  }

/* -------------------------------------------------------------------------- */
/*                          initialize notifications                          */
/* -------------------------------------------------------------------------- */
  Future<void> initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/app_icon');
    var iosInitialize = const DarwinInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((payload) {
      handleMessages(context, message);
    }));
  }

  /* -------------------------------------------------------------------------- */
  /*                             show notifications                             */
  /* -------------------------------------------------------------------------- */
  void firebaseInit(BuildContext context) {
    //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    //analytics.logAppOpen();
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print(
            'NOTIFICATIONS: Message title: ${message.notification!.title.toString()}');
        print(
            'NOTIFICATIONS: Message body: ${message.notification!.body.toString()}');
      }
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  //Function to show notification when app is in foreground
  Future<void> showNotification(RemoteMessage message) async {
    // Save notification to local storage
    LocalStorage().saveNotification(message);

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: "@drawable/app_icon",
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

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

  /* -------------------------------------------------------------------------- */
  /*                              token refreshed                              */
  /* -------------------------------------------------------------------------- */
  void isTokenRefreshed() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('Token Refreshed');
      }
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                            setup interact message                          */
  /* -------------------------------------------------------------------------- */
  Future<void> setupInteractMessage(BuildContext context) async {
    //when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessages(Get.context!, initialMessage);
    }

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessages(context, event);
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                              handle messages                              */
  /* -------------------------------------------------------------------------- */
  void handleMessages(BuildContext context, RemoteMessage message) {
    if (kDebugMode) {
      print('Message data: ${message.data['meeting'].toString()}');
    }
    // Save notification to local storage
    LocalStorage().saveNotification(message);
    if (message.data['meeting'] == 'true') {
      Get.to(
        () => const MeetingsScreen(),
        transition: Transition.rightToLeft,
      );
    }
  }
}
