// import 'dart:html';

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
  int _selectedIndex = 1;
  // 이동할 페이지
  List _pages = [Plant_schedule_Page(), BottomHomePage(), RegisterPage()];

  @override
  Widget build(BuildContext context) {
    //상단바 -> SliverAppBar??
    AppBar appBar = AppBar(
      //가운데
      title: Container(
        width: 84,
        height: 16,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/secondlogo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),

      //왼쪽
      leading: GestureDetector(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/secondlogo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      //오른쪽
      actions: [
        GestureDetector(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/secondlogo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],

      //설정
      automaticallyImplyLeading: false, //뒤로가기 제거
      elevation: 0, //Appbar 구분 선 제거
      centerTitle: true, //title 가운데
    );

    //하단바
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

    //진짜 페이지 구성
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: appBar,
      body: SafeArea(child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: bottomNavigationBar,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
