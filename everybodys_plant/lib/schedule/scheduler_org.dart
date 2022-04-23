// import 'package:everybodys_plant/service/schedule_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/service/plant_service.dart';

// ignore: camel_case_types
class Plant_schedule_Page extends StatefulWidget {
  const Plant_schedule_Page({Key? key}) : super(key: key);

  @override
  State<Plant_schedule_Page> createState() => _Plant_schedule_PageState();
}

// ignore: camel_case_types
class _Plant_schedule_PageState extends State<Plant_schedule_Page> {
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
  TextEditingController updateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantService>(
      builder: (context, plantService, child) {
        List<Plant> plantList = plantService.getByDate(selectedDate);
        return Scaffold(
          // 키보드가 올라올 때 화면 밀지 않도록 만들기(overflow 방지)
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

                /// 선택한 날짜의 일기 목록
                Expanded(
                  child: plantList.isEmpty
                      ? Center(
                          child: Text(
                            "등록된 식물이 없습니다.\n 식물을 등록해주세요",
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
                              /// text
                              title: Text(
                                plant.plantname.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),

                              /// createdAt
                              trailing: Text(
                                DateFormat('kk:mm').format(plant.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
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
              ],
            ),
          ),

          /// Floating Action Button
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            backgroundColor: Colors.indigo,
            onPressed: () {
              showCreateDialog(plantService);
            },
          ),
        );
      },
    );
  }

  /// 작성하기
  /// 엔터를 누르거나 작성 버튼을 누르는 경우 호출
  void createPlant(PlantService plantService) {
    // 앞뒤 공백 삭제
    String plantname_newText = createTextController_plantname.text.trim();
    String nickname_newText = createTextController_nickname.text.trim();
    String skillchecked_newText = createTextController_skillchecked.text.trim();
    String flowerpotindex_newText =
        createTextController_flowerpotindex.text.trim();
    String flowerspaceindex_newText =
        createTextController_flowerspaceindex.text.trim();

    if (plantname_newText.isNotEmpty) {
      //plantService.create(newText,);
      // plantService.create(
      //     plantname_newText,
      //     nickname_newText,
      //     skillchecked_newText,
      //     flowerpotindex_newText,
      //     flowerspaceindex_newText,
      //     selectedDate); //220423 수정
      // createTextController.text = "";
    }
  }

  /// 수정하기
  /// 엔터를 누르거나 수정 버튼을 누르는 경우 호출
  void updatePlant(PlantService plantService, Plant plant) {
    // 앞뒤 공백 삭제
    String updatedText = updateTextController.text.trim();
    if (updatedText.isNotEmpty) {
      //plantService.update(
      //plant.createdAt,
      //updatedText,
      //);
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

                onSubmitted: (_) {
                  // 엔터 누를 때 작성하기
                  createPlant(plantService);
                  Navigator.pop(context);
                },
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

                onSubmitted: (_) {
                  // 엔터 누를 때 작성하기
                  createPlant(plantService);
                  Navigator.pop(context);
                },
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

                onSubmitted: (_) {
                  // 엔터 누를 때 작성하기
                  createPlant(plantService);
                  Navigator.pop(context);
                },
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

                onSubmitted: (_) {
                  // 엔터 누를 때 작성하기
                  createPlant(plantService);
                  Navigator.pop(context);
                },
              ),
              TextField(
                controller: createTextController_flowerspaceindex,
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

                onSubmitted: (_) {
                  // 엔터 누를 때 작성하기
                  createPlant(plantService);
                  Navigator.pop(context);
                },
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
                createPlant(plantService);
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
        updateTextController.text = plant.plantname.toString();
        return AlertDialog(
          title: Text("일기 수정"),
          content: TextField(
            autofocus: true,
            controller: updateTextController,
            // 커서 색상
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "한 줄 일기를 작성해 주세요.",
              // 포커스 되었을 때 밑줄 색상
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
            onSubmitted: (v) {
              // 엔터 누를 때 수정하기
              updatePlant(plantService, plant);
              Navigator.pop(context);
            },
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
        updateTextController.text = plant.plantname.toString();
        return AlertDialog(
          title: Text("일기 삭제"),
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
