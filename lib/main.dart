// 8 July 2024

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Providers/LanguageProvider/language_provider.dart';
import 'package:taxi/Providers/app_provider.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Screens/Splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/push_notification_service.dart';
import 'package:taxi/Utils/route.dart';
import 'package:taxi/firebase_options.dart';

GlobalKey<NavigatorState>? navigatorKey;
SharedPreferences? sharedPrefs;
var languageSelected = 'en';
@pragma("vm:entry-point")
Future<void> backgroundHandler(RemoteMessage message) async {
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;

  androidNotificationChannel() => const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true);

  final AndroidNotificationChannel channel = androidNotificationChannel();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification?.title,
    notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,
          icon: androidSettings.defaultIcon,
          importance: Importance.high,
          styleInformation: const BigTextStyleInformation('')),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  notificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  sharedPrefs = await SharedPreferences.getInstance();
  navigatorKey = GlobalKey<NavigatorState>();
  runApp(
      MultiProvider(providers: AppProvider.appProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, value, child) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        title: 'Taxi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          cardTheme: const CardTheme(
            surfaceTintColor: Colors.white,
            color: AppColors.white,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('is'), // Spanish
        ],
        locale: value.locale,
        home: const SplashScreen(),
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              languageSelected = supportedLocales.first.languageCode;
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      );
    });
  }
}
