import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hiremeinindiaapp/User/userUpload.dart';
import 'package:hiremeinindiaapp/User/userRegistration.dart';

import 'package:hiremeinindiaapp/functions/firestoreservice.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/homepage.dart';
import 'package:hiremeinindiaapp/loginpage.dart';

import 'package:hiremeinindiaapp/User/userPayment.dart';
import 'package:hiremeinindiaapp/sample.dart';
import 'package:provider/provider.dart';
import 'classes/language_constants.dart';

const String channelId = 'cash_notification_channel';
const String channelName = 'Cash Notifications';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBKUuhUeiA2DpvZD4od15RdHEBZyjsuVlA',
    appId: '1:316659430730:web:1afaddd5a3f41be5cffdb3',
    messagingSenderId: '316659430730',
    projectId: 'hiremeinindia-14695',
    authDomain: 'hiremeinindia-14695.firebaseapp.com',
    databaseURL:
        'https://hiremeinindia-14695-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hiremeinindia-14695.appspot.com',
    measurementId: 'G-KVMWVJ99JL',
  ));
  print("Firebase initialized successfully!");

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // No need for onSelectNotification in recent versions
  );

  runApp(HireApp());
}

class HireApp extends StatefulWidget {
  const HireApp({Key? key});

  @override
  State<HireApp> createState() => _HireAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _HireAppState? state = context.findAncestorStateOfType<_HireAppState>();
    state?.setLocale(newLocale);
  }
}

class _HireAppState extends State<HireApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/document': (context) => GreyUserUpload(),
          '/payment': (context) => NewUserPayment(),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        debugShowCheckedModeBanner: false,
        home: NewUserPayment(),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String imageUrl;

  const MyImageWidget({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}
