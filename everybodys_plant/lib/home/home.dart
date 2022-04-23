import 'package:everybodys_plant/home/Bottomhome.dart';

import 'package:everybodys_plant/register/register_page.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // 이동할 페이지
  List _pages = [Plant_schedule_Page(), BottomHomePage(), RegisterPage()];

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      // selectedItemColor: Colors.white,
      // unselectedItemColor: Colors.white.withOpacity(.60),
      // selectedFontSize: 14,
      // unselectedFontSize: 14,
      onTap: (value) {
        setState(() {
          _selectedIndex = value; //page
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "스케쥴"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "등록"),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: bottomNavigationBar,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
