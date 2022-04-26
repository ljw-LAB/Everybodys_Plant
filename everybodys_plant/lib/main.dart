// Library Import
//import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:everybodys_plant/home/home_done.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:everybodys_plant/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

//Pages Import
import 'package:everybodys_plant/service/plant_service.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';
import 'package:everybodys_plant/certification/email_auth_service.dart';

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
      home: AnimatedSplashScreen(
        duration: 4000, //머무는 시간
        splash: Image.asset(
          'assets/splashtest.png',
          fit: BoxFit.cover,
        ),
        splashIconSize: double.infinity,
        nextScreen: LoginHome(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
    //home: user == null ? Plant_schedule_Page() : LoginHome(),
    //home: EmailAuthService(),
    //home: LoginHome(),
    //home: Plant_schedule_Page(),
    //home: Loading(),
  }
}


// class Loading extends StatefulWidget {
//   @override
//   _LoadingState createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   void getLocation() async {
//     LocationPermission permission =
//         await Geolocator.requestPermission(); //오류 해결 코드
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print(position);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             getLocation();
//           },
//           child: Text(
//             'Get my location',
//             style: TextStyle(color: Colors.white),
//           ),
//           color: Colors.blue,
//         ),
//       ),
//     );
//   }
// }
