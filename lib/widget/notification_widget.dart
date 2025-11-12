
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationFromFirebase {
  final firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String fcmToken = "";

  @pragma('vm:entry-point')
  notificationInitialisation() async {
    _requestPermission();
    setNotifications();
    _registerForegroundMessageHandler();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: const DarwinInitializationSettings());
    flutterLocalNotificationsPlugin
        .initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      Map valueMap = jsonDecode(notificationResponse.payload.toString());

    }).then((value) => print('valueeeee $value'));
  }


  Future<NotificationSettings> _requestPermission() async {
    return await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false);
  }

  setNotifications() async {
    //  final token = firebaseMessaging.getToken().then((value) => print('Token: $value'));
    fcmToken = (await firebaseMessaging.getToken().then((value) {
      return value!;
    }));
  }

  @pragma('vm:entry-point')
  _registerForegroundMessageHandler() async {
    await Firebase.initializeApp();
    await setNotifications();
    FirebaseMessaging.onMessage.listen((remoteMessage) {
     // Map valueMap = jsonDecode(remoteMessage.notification!.body!);
      Map valueMap = (remoteMessage.data);
      _showNotificationWithDefaultSound(
          title: remoteMessage.notification?.title ?? "",
          body: remoteMessage.notification?.body ?? "",
          payload: jsonEncode(remoteMessage.data));
    });

  }


  Future _showNotificationWithDefaultSound(
      {required String title, required String body, required String payload}) async {
    if(Platform.isAndroid) {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const DarwinNotificationDetails(
            categoryIdentifier: 'plainCategory',
          ));
      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: payload.toString(),
      );
    }
  }
}
