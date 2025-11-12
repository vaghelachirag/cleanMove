import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/routes/app_pages.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/services/api/api_service.dart';
import 'package:shaligram_transport_app/ui/common/language/language_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/language.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'defaultFirebaseConfig.dart';
import 'utils/dependency_inj.dart' as dep;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initFCM();
  await dep.init();
  runApp(const MyApp());
}

late final FirebaseMessaging _messaging;

// ignore: prefer_const_constructors
final AndroidNotificationChannel channel = AndroidNotificationChannel(
  'notification', // id
  'Update', // title
  importance: Importance.high,
);


Future _initFCM() async {
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options : DefaultFirebaseConfig.platformOptions);
  _messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _generateNotification(message);
  });

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

void _generateNotification(RemoteMessage message) async {
  Map<String, dynamic> _data = message.data;

  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    channel.id,
    channel.name,
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
  );

  final AndroidNotificationDetails androidPlatformChannelSpecificsBigPic =
  AndroidNotificationDetails(channel.id, channel.name, importance: Importance.high, priority: Priority.high, playSound: true,);
  final NotificationDetails platformChannelSpecificsBigPic = NotificationDetails(android: androidPlatformChannelSpecificsBigPic);
}

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  _generateNotification(message);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        builder: (controller) {
          return ScreenUtilInit(
            child: GetMaterialApp(
            title: 'Clean Move',
            debugShowCheckedModeBanner: false,
            translations: Language(),
            locale: controller.locale,
            fallbackLocale: AppConstant.englishUS,
            theme: ThemeData(
              primaryColor: ThemeColor.primaryColor,
              highlightColor: Colors.white54,
              focusColor: ThemeColor.primaryColor,
              splashColor: ThemeColor.primaryColor,
            ),
            initialRoute: Routes.splash,
            getPages: AppPages.getPages,
            onInit: () {
              ScreenUtil.init(context);
              Get.put(ApiService(getStorage: GetStorage("CleanMove")));
            }),
          );
        }
      );
  }
}