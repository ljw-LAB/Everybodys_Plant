import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:flutter/material.dart';

class BottomHomePage extends StatefulWidget {
  const BottomHomePage({Key? key}) : super(key: key);

  @override
  State<BottomHomePage> createState() => _BottomHomePageState();
}

class _BottomHomePageState extends State<BottomHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              print("sign out");
              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginHome()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.shortestSide,
              child: Container(
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
