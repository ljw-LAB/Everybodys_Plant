import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Plant {
  String? plantname; // 식물명
  String? nickname; // 애칭
  DateTime createdAt; // 마지막 물준날
  bool skillchecked; // 숙련자 Check여부
  int flowerpotindex; // 화분 종류
  int flowerspaceindex; // 공간 종류

  Plant({
    required this.plantname, // 식물명
    required this.nickname, // 애칭
    required this.createdAt, // 마지막 물준날
    required this.skillchecked, // 숙련자 Check여부
    required this.flowerpotindex, // 화분 종류
    required this.flowerspaceindex, // 공간 종류
  });

  /// Diary -> Map 변경
  Map<String, dynamic> toJson() {
    return {
      "text": plantname,
      "nickname": nickname, // 애칭
      "createdAt": createdAt.toString(),
      "skillchecked": skillchecked, // 숙련자 Check여부
      "flowerpotindex": flowerpotindex, // 화분 종류
      "flowerspaceindex": flowerspaceindex, // 공간 종류
      // DateTime은 문자열로 변경해야 jsonString으로 변환 가능합니다.
    };
  }

  /// Map -> Diary 변경
  factory Plant.fromJson(Map<String, dynamic> jsonMap) {
    return Plant(
      plantname: jsonMap['plantname'],
      nickname: jsonMap['nickname'], // 애칭
      createdAt: DateTime.parse(jsonMap['createdAt']),
      skillchecked: jsonMap['skillchecked'], // 숙련자 Check여부
      flowerpotindex: jsonMap['flowerpotindex'], // 화분 종류
      flowerspaceindex: jsonMap['flowerspaceindex'], // 공간 종류
      // 문자열로 넘어온 시간을 DateTime으로 다시 바꿔줍니다.
    );
  }
}

class PlantService extends ChangeNotifier {
  final plantCollection = FirebaseFirestore.instance.collection('plant');

  List<Plant> plantList = [];

  PlantService(SharedPreferences prefs);

  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    return plantCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String plantClass, String uid) async {
    // void create(Plant plantClass) async {
    // bucket 만들기
    await plantCollection.add({
      'uid': uid, // 유저 식별자
      "name": plantClass,
      // "nickname": plantClass.nickname, // 애칭
      // "createdAt": plantClass.createdAt.toString(),
      // "skillchecked": plantClass.skillchecked, // 숙련자 Check여부
      // "flowerpotindex": plantClass.flowerpotindex, // 화분 종류
      // "flowerspaceindex": plantClass.flowerspaceindex, // 공간 종류
    });
    notifyListeners(); // 화면 갱신
  }

  void update(String docId, bool isDone) async {
    // bucket isDone 업데이트
    await plantCollection.doc(docId).update({'skillchecked': isDone});
    notifyListeners(); // 화면 갱신
  }

  void delete(String docId) async {
    // bucket 삭제
    await plantCollection.doc(docId).delete();
    notifyListeners(); // 화면 갱신
  }

  List<Plant> getByDate(DateTime selectedDate) {
    return plantList
        .where((diary) => isSameDay(selectedDate, diary.createdAt))
        .toList();
  }
}
