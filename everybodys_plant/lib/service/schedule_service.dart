import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Plant {
  String text; // 내용
  DateTime createdAt; // 작성 시간

  Plant({
    required this.text,
    required this.createdAt,
  });

  /// Diary -> Map 변경
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      // DateTime은 문자열로 변경해야 jsonString으로 변환 가능합니다.
      "createdAt": createdAt.toString(),
    };
  }

  /// Map -> Diary 변경
  factory Plant.fromJson(Map<String, dynamic> jsonMap) {
    return Plant(
      text: jsonMap['text'],
      // 문자열로 넘어온 시간을 DateTime으로 다시 바꿔줍니다.
      createdAt: DateTime.parse(jsonMap['createdAt']),
    );
  }
}

class PlantService extends ChangeNotifier {
  /// 생성자
  PlantService(this.prefs) {
    // 생성자가 호출될 때 SharedPreferences로 저장해 둔 diaryList를 불러옵니다.
    // 저장할 때와 반대로 String -> Map -> Diary로 변환합니다.
    List<String> strintPlantList = prefs.getStringList("plantList") ?? [];
    for (String stringPlant in strintPlantList) {
      // String -> Map
      Map<String, dynamic> jsonMap = jsonDecode(stringPlant);

      // Map -> Diary
      Plant plant = Plant.fromJson(jsonMap);
      plantList.add(plant);
    }
  }

  /// SharedPreferences 인스턴스
  SharedPreferences prefs;

  /// Diary 목록
  List<Plant> plantList = [];

  /// 특정 날짜의 plant 조회
  List<Plant> getByDate(DateTime date) {
    return plantList
        .where((plant) => isSameDay(date, plant.createdAt))
        .toList();
  }

  /// Diary 작성
  void create(String text, DateTime selectedDate) {
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
      text: text,
      createdAt: createdAt,
    );
    plantList.add(plant);
    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// Diary 수정
  void update(DateTime createdAt, String newContent) {
    // createdAt은 중복될 일이 없기 때문에 createdAt을 고유 식별자로 사용
    // createdAt이 일치하는 plant 조회
    Plant plant = plantList.firstWhere((plant) => plant.createdAt == createdAt);

    // text 수정
    plant.text = newContent;
    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// Diary 삭제
  void delete(DateTime createdAt) {
    // createdAt은 중복될 일이 없기 때문에 createdAt을 고유 식별자로 사용
    // createdAt이 일치하는 plant 삭제
    plantList.removeWhere((plant) => plant.createdAt == createdAt);
    notifyListeners();

    // plant 정보가 변경될 때 마다 저장해줍니다.
    _savePlantList();
  }

  /// 변경된 Diary SharedPreferences로 저장
  /// 함수 이름을 _로 이름을 시작하면 PlantService 내부에서만 호출할 수 있습니다.
  void _savePlantList() {
    // Diary라는 직접 만든 클래스는 shared preferences에 그대로 저장할 수 없습니다.
    // SharedPreferences에서 저장할 수 있는 String 형태로 변환을 해주겠습니다.
    // 나만의 규칙을 만들어 Diary를 String 형태로 변환할 수 있지만, 보통 json이라는 규칙을 이용합니다.
    // Diary -> Map -> String 순서로 변환합니다.
    List<String> stringPlantList = [];
    for (Plant plant in plantList) {
      // Diary -> Map
      Map<String, dynamic> jsonMap = plant.toJson();

      // Map -> String
      String stringPlant = jsonEncode(jsonMap);
      stringPlantList.add(stringPlant);
    }
    prefs.setStringList("plantList", stringPlantList);
  }
}
