import 'package:fablearner_app/exports/presentation_exports.dart';

class NotificationServices{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission: ${settings.authorizationStatus}');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted permission: ${settings.authorizationStatus}');
    }else{ 
      print('User denied permission: ${settings.authorizationStatus}');
    }
  }
}
