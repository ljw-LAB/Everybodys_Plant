import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import 'package:everybodys_plant/register/plantlist.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> potitems = ['화경/수경재배', '토분', '플라스틱 화분', '철제/시멘트 화분'];
  final List<String> spaceitems = [
    '방/원룸',
    '거실',
    '욕실',
    '베란다',
    '주방',
    '사무실',
    '야외',
    '기타'
  ];
  final List<String> perioditems = ['일', '주', '개월', '사용 안함'];
  String perioditems_value = '일';
  String spaceitems_value = '방/원룸';
  String potitems_value = '화경/수경재배';

  String _selectedValue = '1';
  DateTime? _selectedDate1; //마지막 물준날
  DateTime? _selectedDate2; //마지막 분갈이
  var _isChecked2 = false; //숙련자 여부 변수
  bool isVisible = false;

  // 마지막 물준날 데이트 픽커
  void _presentDatePicker1() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate1 = pickedDate;
      });
    });
  }

  // 마지막 분갈이 데이트 픽커
  void _presentDatePicker2() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate2 = pickedDate;
      });
    });
  }

  PickedFile? _image;

  Future getImageFromCam() async {
    //for camera
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image!;
    });
  }

  Future getImageFromGallery() async {
    //for gallery
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text(
              'New Post',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                child: Text('Capture Image with Camera',
                    style: TextStyle(color: Colors.black)),
                onPressed: getImageFromCam,
              ),
              SimpleDialogOption(
                child: Text('Select Image from Gallery',
                    style: TextStyle(color: Colors.black)),
                onPressed: getImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("식물정보 등록",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.xmark, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 24),
                Text("반갑습니다."),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text("식물에 대해 알려주세요."),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 3)),
                  height: 152,
                  width: 152,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          AlertDialog alertDialog = AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            title: Center(
                                child: Text(
                              '이미지 불러오기',
                              style: TextStyle(fontSize: 16),
                            )),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        FloatingActionButton(
                                          onPressed: getImageFromCam,
                                          tooltip: 'Pick Image',
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.grey,
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                        Text("카메라",
                                            style: TextStyle(fontSize: 12))
                                      ],
                                    ),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    Column(
                                      children: [
                                        FloatingActionButton(
                                          onPressed: getImageFromGallery,
                                          tooltip: 'Pick Image',
                                          child: Icon(
                                            Icons.wallpaper,
                                            color: Colors.grey,
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                        Text('갤러리에서',
                                            style: TextStyle(fontSize: 12))
                                      ],
                                    ),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('취소'))
                              ],
                            ),
                          );
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return alertDialog;
                              });
                        },
                        tooltip: 'Pick Image',
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text("식물명"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    width: 370,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text("애칭"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    width: 370,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text("마지막 물준날"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 40,
                      width: 370,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: _presentDatePicker1,
                            child: const Text('날짜 선택'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            child: Text(
                              _selectedDate1 != null
                                  ? _selectedDate1.toString().substring(0, 11)
                                  : '선택하지 않음',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text("숙련자 인가요?"),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Checkbox(
                    value: _isChecked2,
                    onChanged: (value) {
                      setState(() {
                        _isChecked2 = value!;
                        isVisible = !isVisible;
                      });
                    }),
                Text("숙련자"),
              ],
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Text("어떤 화분에서 키우고 있나요"),
                ],
              ),
            ),
            //어떤 화분인지
            Visibility(
              visible: isVisible,
              child: Center(
                child: Container(
                  height: 40,
                  width: 370,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: potitems_value,
                      isExpanded: true,
                      iconSize: 24,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      items: potitems.map((String potitems_map_val) {
                        return DropdownMenuItem(
                          value: potitems_map_val,
                          child: Text(potitems_map_val),
                        );
                      }).toList(),
                      onChanged: (potitems_val) {
                        setState(() {
                          potitems_value = potitems_val as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Text("어떤 공간에서 키우고 있나요"),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Center(
                child: Container(
                  height: 40,
                  width: 370,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: spaceitems_value,
                      isExpanded: true,
                      iconSize: 24,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      items: spaceitems.map((String spaceitems_map_val) {
                        return DropdownMenuItem(
                          value: spaceitems_map_val,
                          child: Text(spaceitems_map_val),
                        );
                      }).toList(),
                      onChanged: (s_value) {
                        setState(() {
                          spaceitems_value = s_value as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: SizedBox(
                height: 40,
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "분갈이 정보",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "마지막 분갈이 날짜",
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 40,
                        width: 370,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: _presentDatePicker2,
                              child: const Text('날짜 선택'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              child: Text(
                                _selectedDate2 != null
                                    ? _selectedDate2.toString().substring(0, 11)
                                    : '선택하지 않음',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "분갈이 주기",
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Center(
                child: Container(
                  height: 40,
                  width: 370,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: perioditems_value,
                      isExpanded: true,
                      iconSize: 24,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      items: perioditems.map((String perioditems_map_val) {
                        return DropdownMenuItem(
                          value: perioditems_map_val,
                          child: Text(perioditems_map_val),
                        );
                      }).toList(),
                      onChanged: (String? p_value) {
                        setState(() {
                          perioditems_value = p_value as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: SizedBox(
                height: 32,
              ),
            ),
            Row(
              children: [
                SizedBox(width: 24),
                Text(
                  "메모",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    width: 370,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(thickness: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    height: 70,
                    width: 340,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          AlertDialog alertDialog = AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            title: Center(
                                child: Text(
                              '등록을 완료하시겠습니까?',
                              style: TextStyle(fontSize: 18),
                            )),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Text('완료하기',
                                            style: TextStyle(
                                                color: Colors.black))),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('취소하기',
                                            style:
                                                TextStyle(color: Colors.black)))
                                  ],
                                ),
                              ],
                            ),
                          );
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return alertDialog;
                              });
                        },
                        child: Text("내 식물로 등록하기",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )),
      ),
    );
  }
}
