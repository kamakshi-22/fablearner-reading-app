// import 'package:fablearner_app/exports/business_exports.dart';
// import 'package:fablearner_app/exports/common_exports.dart';
// import 'package:fablearner_app/exports/presentation_exports.dart';


// class NotificationController extends GetxController {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   RxList<RemoteMessage> notifications = RxList<RemoteMessage>([]);

//   @override
//   void onInit() {
//     super.onInit();
//     _firebaseMessaging.requestPermission();
//     _firebaseMessaging.getToken().then((token) => print(token));
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       notifications.add(message);
//     });
//     // NotificationServices().requestNotificationPermission();
//     // NotificationServices().firebaseInit(context);
//     // NotificationServices().setupInteractMessage(context);
//     // NotificationServices().getDeviceToken().then((value) {
//     //   if (kDebugMode) {
//     //     print('device token: $value');
//     //   }
//     // });
//   }
// }
