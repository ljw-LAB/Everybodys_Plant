// import 'package:everybodys_plant/service/schedule_service.dart';
import 'dart:io';

import 'package:everybodys_plant/home/home_done.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/service/plant_service.dart';

// ignore: camel_case_types
class Plant_schedule_Page extends StatefulWidget {
  final PlantService? test_service;
  final String? test_image;

  const Plant_schedule_Page(
      {Key? key, @required this.test_service, @required this.test_image})
      : super(key: key);

  @override
  State<Plant_schedule_Page> createState() => _Plant_schedule_PageState();
}

// ignore: camel_case_types
class _Plant_schedule_PageState extends State<Plant_schedule_Page> {
  int _selectedIndex = 1;
  // 이동할 페이지
  List _pages = [Plant_schedule_Page(), HomeDonePage()];

  // 달력 보여주는 형식
  CalendarFormat calendarFormat = CalendarFormat.month;
  // 선택된 날짜
  DateTime selectedDate = DateTime.now();

  // create text controller
  TextEditingController createTextController_plantname =
      TextEditingController();
  TextEditingController createTextController_nickname = TextEditingController();
  TextEditingController createTextController_createdAt =
      TextEditingController();
  TextEditingController createTextController_skillchecked =
      TextEditingController();
  TextEditingController createTextController_flowerpotindex =
      TextEditingController();
  TextEditingController createTextController_flowerspaceindex =
      TextEditingController();

  // update text controller
  TextEditingController updateTextController_plantname =
      TextEditingController();
  TextEditingController updateTextController_nickname = TextEditingController();
  TextEditingController updateTextController_createdAt =
      TextEditingController();
  TextEditingController updateTextController_skillchecked =
      TextEditingController();
  TextEditingController updateTextController_flowerpotindex =
      TextEditingController();
  TextEditingController updateTextController_flowerspaceindex =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
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

    return Consumer<PlantService>(
      builder: (context, plantService, child) {
        List<Plant> plantList = plantService.getByDate(selectedDate);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                /// 달력
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: selectedDate,
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    // 달력 형식 변경
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  eventLoader: (date) {
                    // 각 날짜에 해당하는 plantList 보여주기
                    return plantService.getByDate(date);
                  },
                  calendarStyle: CalendarStyle(
                    // today 색상 제거
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (_, focusedDay) {
                    setState(() {
                      selectedDate = focusedDay;
                    });
                  },
                ),
                Divider(height: 1),
                Row(
                  children: [
                    SizedBox(width: 24),
                    Image.asset('assets/Water.png'),
                    SizedBox(width: 8),
                    Text(
                      "물주기 일정",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColorList[1],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                /// 선택한 날짜의 일기 목록
                Expanded(
                  child: plantList.isEmpty
                      ? Center(
                          child: Text(
                            "식물을 등록해주세요",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: plantList.length,
                          itemBuilder: (context, index) {
                            // 역순으로 보여주기
                            int i = plantList.length - index - 1;
                            Plant plant = plantList[i];
                            return ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(0),
                                // padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        plantList.isEmpty
                                            ? Row(children: [
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                Text(
                                                  "식물을 등록해주세요",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                ),
                                              ])
                                            : Row(children: [
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                Text(
                                                  "마지막 물 준 날",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 6),
                                                  width: 1,
                                                  height: 16,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(
                                                          plant.lastwaterAt),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                )
                                              ]),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 24,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: Image.file(
                                                File(plant.plantimagepath),
                                              ).image,
                                              radius: 40,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(6),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6),
                                              child: Text('image',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 13)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              children: [
                                                Text(plant.plantname,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey)),
                                                Text(plant.nickname,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextButton(
                                                  child: const Text('선택하기'),
                                                  onPressed: () {
                                                    print(plantService);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// 클릭하여 update
                              onTap: () {
                                showUpdateDialog(plantService, plant);
                              },

                              /// 꾹 누르면 delete
                              onLongPress: () {
                                showDeleteDialog(plantService, plant);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            // item 사이에 Divider 추가
                            return Divider(height: 1);
                          },
                        ),
                ),
                Row(
                  children: [
                    SizedBox(width: 24),
                    Image.asset('assets/shovel.png'),
                    SizedBox(width: 8),
                    Text(
                      "분갈이 일정",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColorList[1],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                Expanded(
                  child: plantList.isEmpty
                      ? Center(
                          child: Text(
                            "식물을 등록해주세요",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: plantList.length,
                          itemBuilder: (context, index) {
                            // 역순으로 보여주기
                            int i = plantList.length - index - 1;
                            Plant plant = plantList[i];

                            return Visibility(
                                visible:
                                    plant.skillchecked == '비숙련자' ? false : true,
                                child: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.all(0),
                                    // padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            plantList.isEmpty
                                                ? Row(children: [
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Text(
                                                      "식물을 등록해주세요",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ])
                                                : Row(children: [
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Text(
                                                      "마지막 분갈이 날",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6),
                                                      width: 1,
                                                      height: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(plant
                                                              .lastwaterAt),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    )
                                                  ]),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                CircleAvatar(
                                                  backgroundImage: Image.file(
                                                    File(plant.plantimagepath),
                                                  ).image,
                                                  radius: 40,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(6),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6),
                                                  child: Text('image',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 13)),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.green),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(plant.plantname,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.grey)),
                                                    Text(plant.nickname,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextButton(
                                                      child: const Text('선택하기'),
                                                      onPressed: () {
                                                        print(plantService);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// 클릭하여 update
                                  onTap: () {
                                    showUpdateDialog(plantService, plant);
                                  },

                                  /// 꾹 누르면 delete
                                  onLongPress: () {
                                    showDeleteDialog(plantService, plant);
                                  },
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            // item 사이에 Divider 추가
                            return Divider(height: 1);
                          },
                        ),
                ),
              ],
            ),
          ),

          /// Floating Action Button
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            backgroundColor: Colors.indigo,
            onPressed: () {
              //showCreateDialog(plantService);
            },
          ),
        );
      },
    );
  }

  /// 수정하기
  /// 엔터를 누르거나 수정 버튼을 누르는 경우 호출
  void updatePlant(PlantService plantService, Plant plant) {
    // 앞뒤 공백 삭제
    String plantname_newText = updateTextController_plantname.text.trim();
    String nickname_newText = updateTextController_nickname.text.trim();
    String skillchecked_newText = updateTextController_skillchecked.text.trim();
    String flowerpotindex_newText =
        updateTextController_flowerpotindex.text.trim();
    String flowerspaceindex_newText =
        updateTextController_flowerspaceindex.text.trim();

    if (plantname_newText.isNotEmpty) {
      plantService.update(
          plant.createdAt,
          plantname_newText,
          nickname_newText,
          skillchecked_newText,
          flowerpotindex_newText,
          flowerspaceindex_newText); //220423 수정
    }
  }

  /// 작성 다이얼로그 보여주기
  void showCreateDialog(PlantService plantService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("식물 등록"),
          content: Column(
            children: [
              TextField(
                controller: createTextController_plantname,
                autofocus: true,
                // 커서 색상
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "식물을 등록해주세요.",
                  // 포커스 되었을 때 밑줄 색상
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
              TextField(
                controller: createTextController_nickname,
                autofocus: true,
                // 커서 색상
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "닉네임을 등록해주세요.",
                  // 포커스 되었을 때 밑줄 색상
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
              TextField(
                controller: createTextController_skillchecked,
                autofocus: true,
                // 커서 색상
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "숙련자를 등록해주세요.",
                  // 포커스 되었을 때 밑줄 색상
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
              TextField(
                controller: createTextController_flowerpotindex,
                autofocus: true,
                // 커서 색상
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "식물화분 등록해주세요.",
                  // 포커스 되었을 때 밑줄 색상
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
              TextField(
                controller: createTextController_flowerspaceindex,
                autofocus: true,
                // 커서 색상
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  hintText: "식물장소 등록해주세요.",
                  // 포커스 되었을 때 밑줄 색상
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            /// 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "취소",
                style: TextStyle(color: Colors.indigo),
              ),
            ),

            /// 작성 버튼
            TextButton(
              onPressed: () {
                // createPlant(plantService);
                Navigator.pop(context);
              },
              child: Text(
                "작성",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 수정 다이얼로그 보여주기
  void showUpdateDialog(PlantService plantService, Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController_plantname.text = plant.plantname;
        return AlertDialog(
          title: Text("식물 수정"),
          content: TextField(
            autofocus: true,
            controller: updateTextController_plantname,
            // 커서 색상
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "식물이름을 수정해 주세요.",
              // 포커스 되었을 때 밑줄 색상
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
            // onSubmitted: (v) {
            //   // 엔터 누를 때 수정하기
            //   updatePlant(plantService, plant);
            //   Navigator.pop(context);
            // },
          ),
          actions: [
            /// 취소 버튼
            TextButton(
              child: Text(
                "취소",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            /// 수정 버튼
            TextButton(
              child: Text(
                "수정",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                ),
              ),
              onPressed: () {
                // 수정하기
                updatePlant(plantService, plant);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// 삭제 다이얼로그 보여주기
  void showDeleteDialog(PlantService plantService, Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController_plantname.text = plant.plantname.toString();
        return AlertDialog(
          title: Text("식물 정보 삭제"),
          content: Text('"${plant.plantname.toString()}"를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              child: Text(
                "취소",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            /// Delete
            TextButton(
              child: Text(
                "삭제",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                ),
              ),
              onPressed: () {
                plantService.delete(plant.createdAt);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
