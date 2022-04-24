// 기본 홈 화면

import 'dart:core';
// import 'dart:html';

import 'package:everybodys_plant/register/plantlist.dart';
import 'package:everybodys_plant/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//변수 리스트
List<Color> primaryColorList = [
  Color(0xff20B2CA),
  Color(0xff69D5E7),
  Color(0xffFFBC0F),
  Color(0xffFFE7A8),
];
//긍/부정 및 상태
List<Color> emotionColorList = [
  Color(0xff58D344),
  Color(0xffED9615),
  Color(0xffEA4C09),
];
List<Color> GreyscaleColorList = [
  Color(0xff1F1F1F),
  Color(0xff6B7583),
  Color(0xff7F8B9C),
  Color(0xff94A2B5),
  Color(0xffA9B8CF),
  Color(0xffC6C6C6),
];
List<Color> shadowColorList = [
  Color(0xffFFFFFF),
  Color(0xff69D5E7),
];
Color background = Color(0xffFAFAFB);
Color line = Color(0xffEBEBED);

final size = 4;

//Date 처리
DateTime _date_now = DateTime.now(); //날짜
var date_now_yy = DateFormat('yyyy-MM-dd').format(_date_now); //날짜 format
var date_now_mm = DateFormat('MM-dd').format(_date_now); //날짜 format
int date_interval = 23; //물주기 날짜
String nickname = "귀요미"; //닉네임
var _isVisible = true; //등록 여부에 따라 화면 다르게 보이기

class HomeDonePage extends StatefulWidget {
  final String? nickname;
  final String? plantname;
  final String? memo;
  const HomeDonePage(
      {Key? key,
      @required this.nickname,
      @required this.plantname,
      @required this.memo})
      : super(key: key);
  @override
  State<HomeDonePage> createState() => _HomeDonePageState();
}

class _HomeDonePageState extends State<HomeDonePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          //PageTop
          Center(
            child: Column(
              children: [
                //미등록 시
                Visibility(
                  visible: _isVisible,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 154,
                            width: 154,
                            decoration: BoxDecoration(
                              color: shadowColorList[0],
                              border: Border.all(
                                color: primaryColorList[1],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColorList[1].withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5.0,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            //onPressed: () => PlantList(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => PlantList())));
                            },
                            icon: Icon(Icons.add_circle_outline_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 등록 완료 시
                Visibility(
                  visible: !_isVisible,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15), //Expanded 필요
                      //메인 식물 사진
                      Container(
                        height: 154,
                        width: 154,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/test_plant.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),

                      SizedBox(height: size * 2), //Expanded 필요

                      //함께한지 며칠되었는지 표시
                      Container(
                        height: 21,
                        width: 82,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColorList[2])),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "함께한지 + $date_interval",
                              style: TextStyle(color: primaryColorList[2]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8), //Expanded 필요

                      //닉네임
                      Container(
                        height: 22,
                        width: 50,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(nickname),
                        ),
                      ),
                      SizedBox(height: 8), //Expanded 필요

                      //입양일
                      Container(
                        height: 14,
                        width: 88,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('입양일 ' + date_now_yy),
                        ),
                      ),
                      SizedBox(height: 16), //Expanded 필요
                    ],
                  ),
                ),
              ],
            ),
          ),

          //PageMiddle
          Visibility(
            visible: !_isVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 19,
                  width: 53,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      date_now_mm + '일정',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: size * 3),

                //알림 칸
                Container(
                  height: 78,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColorList[1],
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColorList[1].withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 5.0,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  //내용
                  child: Row(
                    children: [
                      SizedBox(width: size * 5),
                      //아이콘
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: background,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                          ),
                        ),
                      ),
                      SizedBox(width: size * 3),
                      //문구
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '3월 28일 마지막 물주기',
                            style: TextStyle(color: background),
                          ),
                          Text(
                            nickname + '물갈이 날입니다.',
                            style: TextStyle(
                              color: background,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size * 7),

          //PageBottom
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 19,
                width: 191,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('반려식물, 더 편하게 다가가기'),
                ),
              ),
              SizedBox(height: size * 3),

              //관련 정보
              Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      const url = 'https://flutter.dev/';
                      if (await canLaunch(url)) {
                        launch(url);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: primaryColorList[2],
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColorList[1].withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner_1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size * 3),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      const url = 'https://flutter.dev/';
                      if (await canLaunch(url)) {
                        launch(url);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: primaryColorList[2],
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColorList[1].withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner_2.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size * 3),

              Visibility(
                visible: !_isVisible,
                child: GestureDetector(
                  onTap: () async {
                    const url = 'https://flutter.dev/';
                    if (await canLaunch(url)) {
                      launch(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColorList[2],
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColorList[1].withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 5.0,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size * 3),
            ],
          ),
        ],
      ),
    );
  }
}
