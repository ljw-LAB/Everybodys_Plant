// 기본 홈 화면 틀

import 'package:everybodys_plant/home/home_done.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/login/setting_page.dart';

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
  List _pages = [Plant_schedule_Page(), HomeDonePage()];

  @override
  Widget build(BuildContext context) {
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈")
      ],
    );

    //진짜 페이지 구성
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: SafeArea(
          child: Container(
            height: 48,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  //알람 버튼
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Bell.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox(width: 98)),
                  //제목 버튼
                  Container(
                    width: 83.17,
                    height: 16,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/title.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox(width: 98)),

                  //오른쪽 설정 버튼
                  GestureDetector(
                    onTap: () {
                      print("setting page");
                      // 로그인 페이지로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Setting.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
