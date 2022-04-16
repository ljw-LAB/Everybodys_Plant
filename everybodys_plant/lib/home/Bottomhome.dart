import 'dart:core';

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
DateTime _date_now = DateTime.now();
var date_now_yy = DateFormat('yyyy-MM-dd').format(_date_now);
var date_now_mm = DateFormat('MM-dd').format(_date_now);
int date_interval = 23;
String nickname = "귀요미";

class BottomHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          //PageTop
          Center(
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
              ],
            ),
          ),
          SizedBox(height: 16), //Expanded 필요

          //PageMiddle
          Column(
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
              ElevatedButton(
                onPressed: () async {
                  const url =
                      'mailto:dev-yakuza@gmail.com?subject=Hello&body=Test';
                  if (await canLaunch(url)) {
                    launch(url);
                  } else {
                    // ignore: avoid_print
                    print("Can't launch $url");
                  }
                },
                child: const Text('Mail to'),
              ),

              GestureDetector(
                onTap: () async {
                  const url =
                      'mailto:dev-yakuza@gmail.com?subject=Hello&body=Test';
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
              SizedBox(height: size * 3),
              Container(
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
              SizedBox(height: size * 3),
              Container(
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
              SizedBox(height: size * 3),
            ],
          )
        ],
      ),
    );
  }
}

// Widget _pageOfTop() {
//   return Column(
//     children: <Widget>[
//       // Expanded(child: SizedBox()),
//       Container(
//         height: 154,
//         width: 154,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/test_plant.jpg'),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(6),
//         ),
//       ),
//       // Expanded(child: SizedBox()),
//       Container(
//         height: 21,
//         width: 82,
//         decoration: BoxDecoration(border: Border.all(color: colorList[2])),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
//           child: FittedBox(
//             fit: BoxFit.fitWidth,
//             child: Text(
//               '함께한지 + $date_interval',
//               style: TextStyle(color: colorList[2]),
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }

// Widget _pageOfMiddle() {
//   return Text('pageOfMiddle');
// }

// Widget _pageOfBottom() {
//   final items = List.generate(15, (i) {
//     var num = i + 1;
//     return ListTile(
//       leading: Icon(Icons.notifications),
//       title: Text('$num번째 ListTile'),
//     );
//   });
//   return ListView(
//     physics: NeverScrollableScrollPhysics(), // 해당 리스트의 스크롤 금지
//     shrinkWrap: true, // 상위 리스트 위젯이 별도로 있다면 true 로 설정해야 스크롤이 가능
//     children: items,
//   );
// }
