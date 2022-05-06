// Library Import
//import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

//Pages Import
import 'package:everybodys_plant/service/plant_service.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';
import 'package:everybodys_plant/certification/email_auth_service.dart';
import 'package:everybodys_plant/register/register_page.dart';
import 'package:everybodys_plant/home/home_done.dart';

//void main() => runApp(Schedule());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // sharedPreferences 인스턴스 불러오기
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantService(prefs)),
        ChangeNotifierProvider(create: (context) => EmailAuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = context.read<EmailAuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          // 선언 완료 후 표시할 위젯
          if (snapshot.connectionState == ConnectionState.done) {
            _initFirebaseMessaging(context);
            // _getToken();
            return AnimatedSplashScreen(
              duration: 2000, //머무는 시간
              splash: Image.asset(
                'assets/splashimg.png',
                fit: BoxFit.cover,
              ),
              splashIconSize: double.infinity,
              nextScreen: LoginHome(),
              splashTransition: SplashTransition.fadeTransition,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },

        //   child: AnimatedSplashScreen(
        //     duration: 2000, //머무는 시간
        //     splash: Image.asset(
        //       'assets/splashtest.png',
        //       fit: BoxFit.cover,
        //     ),
        //     splashIconSize: double.infinity,
        //     nextScreen: LoginHome(),
        //     splashTransition: SplashTransition.fadeTransition,
        //   ),
        // ),
      ),
    );
  }
}

_initFirebaseMessaging(BuildContext context) {
  FirebaseMessaging.onMessage.listen((event) {
    print(event.notification!.title);
    print(event.notification!.body);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

  _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print("messaing.getToken(), ${await messaging.getToken()}");
  }
}
