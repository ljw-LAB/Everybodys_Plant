import 'dart:convert';

import 'package:everybodys_plant/home/Bottomhome.dart';
import 'package:everybodys_plant/main.dart';
import 'package:everybodys_plant/register/plantlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Plant {
  String plantname; // 식물명
  String nickname; // 애칭
  DateTime createdAt; // 마지막 물준날
  String skillchecked; // 숙련자 Check여부
  String flowerpotindex; // 화분 종류
  String flowerspaceindex; // 공간 종류

  Plant(
      {required this.plantname, // 식물명
      required this.nickname, // 애칭
      required this.createdAt, // 마지막 물준날
      required this.skillchecked, // 숙련자 Check여부
      required this.flowerpotindex, // 화분 종류
      required this.flowerspaceindex // 공간 종류
      });

  /// Plant -> Map 변경
  Map<String, dynamic> toJson() {
    return {
      "plantname": plantname,
      "nickname": nickname,
      "createdAt": createdAt.toString(),
      "skillchecked": skillchecked,
      "flowerpotindex": flowerpotindex,
      "flowerspaceindex": flowerspaceindex,
      // DateTime은 문자열로 변경해야 jsonString으로 변환 가능합니다.
    };
  }

  /// Map -> Plant 변경
  factory Plant.fromJson(Map<String, dynamic> jsonMap) {
    return Plant(
      plantname: jsonMap['plantname'],
      nickname: jsonMap['nickname'],
      createdAt: DateTime.parse(jsonMap['createdAt']),
      skillchecked: jsonMap['skillchecked'],
      flowerpotindex: jsonMap['flowerpotindex'],
      flowerspaceindex: jsonMap['flowerspaceindex'],
      // 문자열로 넘어온 시간을 DateTime으로 다시 바꿔줍니다.
    );
  }
}

/// Plant 담당
class PlantService extends ChangeNotifier {
  PlantService(this.prefs) {
    // 생성자가 호출될 때 SharedPreferences로 저장해 둔 diaryList를 불러옵니다.
    // 저장할 때와 반대로 String -> Map -> Diary로 변환합니다.
    List<String> strintPlantList = prefs.getStringList("PlantList") ?? [];
    for (String stringPlant in strintPlantList) {
      // String -> Map
      Map<String, dynamic> jsonMap = jsonDecode(stringPlant);

      // Map -> Plant
      Plant plant = Plant.fromJson(jsonMap);
      PlantList.add(plant);
    }
  }

  /// SharedPreferences 인스턴스
  SharedPreferences prefs;

  /// Plant 목록
  List<Plant> PlantList = [];

  /// 특정 날짜의 plant 조회
  List<Plant> getByDate(DateTime date) {
    return PlantList.where((plant) => isSameDay(date, plant.createdAt))
        .toList();
  }

  /// Plant 작성
  void create(String plantname, String nickname, String skillchecked,
      String flowerpotindex, String flowerspaceindex, DateTime selectedDate) {
    DateTime now = DateTime.now();

    // 선택된 날짜(selectedDate)에 현재 시간으로 추가
    DateTime createdAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
    );

    Plant plant = Plant(
      plantname: plantname,
      nickname: nickname,
      createdAt: createdAt,
      skillchecked: skillchecked,
      flowerpotindex: flowerpotindex,
      flowerspaceindex: flowerspaceindex,
    );

    PlantList.add(plant);
    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// Plant 수정
  void update(DateTime createdAt, String plantname, String nickname,
      String skillchecked, String flowerpotindex, String flowerspaceindex) {
    // createdAt은 중복될 일이 없기 때문에 createdAt을 고유 식별자로 사용
    // createdAt이 일치하는 plant 조회
    Plant plant = PlantList.firstWhere((plant) => plant.createdAt == createdAt);

    // text 수정
    plant.plantname = plantname;
    plant.nickname = nickname;
    plant.skillchecked = skillchecked;
    plant.flowerpotindex = flowerpotindex;
    plant.flowerpotindex = flowerpotindex;
    plant.flowerspaceindex = flowerspaceindex;

    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// Plant 삭제
  void delete(DateTime createdAt) {
    // createdAt은 중복될 일이 없기 때문에 createdAt을 고유 식별자로 사용
    // createdAt이 일치하는 plant 삭제
    PlantList.removeWhere((plant) => plant.createdAt == createdAt);
    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// 변경된 Plant SharedPreferences로 저장
  /// 함수 이름을 _로 이름을 시작하면 DiaryService 내부에서만 호출할 수 있습니다.
  void _savePlantList() {
    // Diary라는 직접 만든 클래스는 shared preferences에 그대로 저장할 수 없습니다.
    // SharedPreferences에서 저장할 수 있는 String 형태로 변환을 해주겠습니다.
    // 나만의 규칙을 만들어 Diary를 String 형태로 변환할 수 있지만, 보통 json이라는 규칙을 이용합니다.
    // Plant -> Map -> String 순서로 변환합니다.
    List<String> stringPlantList = [];
    for (Plant plant in PlantList) {
      // Plant -> Map
      Map<String, dynamic> jsonMap = plant.toJson();

      // Map -> String
      String stringPlant = jsonEncode(jsonMap);
      stringPlantList.add(stringPlant);
    }
    prefs.setStringList("PlantList", stringPlantList);
  }
}
