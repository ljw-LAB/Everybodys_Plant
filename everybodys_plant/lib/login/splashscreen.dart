// 스플래시 스크린
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
      duration: 6000, //머무는 시간
      splash: Image.asset(
        'assets/splashtest.png',
        fit: BoxFit.cover,
      ),
      splashIconSize: double.infinity,
      nextScreen: LoginHome(),
      splashTransition: SplashTransition.fadeTransition,
    ));
  }
}
