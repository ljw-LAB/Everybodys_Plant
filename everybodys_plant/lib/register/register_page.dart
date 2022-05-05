import 'package:everybodys_plant/schedule/scheduler.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';
import 'package:everybodys_plant/service/plant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:everybodys_plant/home/home_done.dart';
import 'package:everybodys_plant/register/renderTextFormField.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final String? plantname; // 식물 이름 가져올 변수
  final PlantService? test_plantservice;

  RegisterPage(
      {Key? key, @required this.plantname, @required this.test_plantservice})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 텍스트필드에 입력된 값 가져오기 위한 컨트롤러
  TextEditingController textController1 =
      TextEditingController(); // 애칭 입력 값 가져오기 위한 컨트롤러

  // 재배 조건 선택 옵션
  final List<String> potitems = [
    '미지정',
    '화경/수경재배',
    '토분',
    '플라스틱 화분',
    '철제/시멘트 화분'
  ];
  // 재배 장소 선택 옵션
  final List<String> spaceitems = [
    '미지정',
    '방/원룸',
    '거실',
    '욕실',
    '베란다',
    '주방',
    '사무실',
    '야외',
    '기타'
  ];
  // 분갈이 주기
  final List<String> perioditems = ['미지정', '6개월', '1년', '2년'];
  String perioditems_value = '미지정';
  String spaceitems_value = '미지정';
  String potitems_value = '미지정';
  String _selectedValue = '1';
  String? error;
  DateTime? _selectedDate1; //마지막 물준날 날짜
  DateTime? _selectedDate2; //마지막 분갈이 날짜
  var _isChecked2 = false; //숙련자 여부 체크 변수
  bool isVisible = false;
  String test_date = "20220422"; //마지막 물준날 날짜
  Plant? test_plant;
  // 마지막 물준날 날짜 선택 기능
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

  // 마지막 분갈이 날짜 선택 기능
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

  // 이미지 불러오기 기능
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

  final formKey = GlobalKey<FormState>(); // Form - TextFormField 위젯 사용을 위한 변수

  String memo = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantService>(builder: (context, plantService, child) {
      List<Plant> plantList = plantService.getByDate(DateTime.now());
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.grey),
          title: Text("식물정보 등록",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.xmark, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Form(
          key: this.formKey,
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(width: 24),
                    Text("반갑습니다.",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff6B7583))),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 24),
                    Text("식물에 대해 알려주세요.",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff6B7583))),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 1)),
                      height: 154,
                      width: 154,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              AlertDialog alertDialog = AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: Center(
                                    child: Text(
                                  '이미지 불러오기',
                                  style: TextStyle(fontSize: 16),
                                )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    SizedBox(height: 24),
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
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "반려식물의 사진을\n 선택해주세요.",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
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
                    Text("식물명", style: TextStyle(color: Color(0xff6B7583))),
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
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('   ${widget.plantname}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 24),
                    Text("애칭", style: TextStyle(color: Color(0xff6B7583))),
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
                          controller: textController1,
                          decoration: InputDecoration(
                            errorText: error,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                    Text("마지막 물준날", style: TextStyle(color: Color(0xff6B7583))),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff69d5e7)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                child: Text(
                                  _selectedDate1 != null
                                      ? _selectedDate1
                                          .toString()
                                          .substring(0, 11)
                                      : '선택하지 않음',
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xff6B7583)),
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
                    Text("숙련자 인가요?",
                        style: TextStyle(color: Color(0xff6B7583))),
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
                    Text("숙련자", style: TextStyle(color: Color(0xff6B7583))),
                  ],
                ),
                Visibility(
                  visible: isVisible,
                  child: Row(
                    children: [
                      SizedBox(width: 24),
                      Text("어떤 화분에서 키우고 있나요",
                          style: TextStyle(color: Color(0xff6B7583))),
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
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('   ${widget.plantname}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: potitems_value,
                                isExpanded: true,
                                iconSize: 24,
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
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
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Row(
                    children: [
                      SizedBox(width: 24),
                      Text("어떤 공간에서 키우고 있나요",
                          style: TextStyle(color: Color(0xff6B7583))),
                    ],
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 370,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: spaceitems_value,
                          isExpanded: true,
                          iconSize: 24,
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
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
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff6B7583)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Row(
                    children: [
                      SizedBox(width: 24),
                      Text("마지막 분갈이 날짜",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xff6B7583))),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff69d5e7)),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  child: Text(
                                    _selectedDate2 != null
                                        ? _selectedDate2
                                            .toString()
                                            .substring(0, 11)
                                        : '선택하지 않음',
                                    style: const TextStyle(
                                        fontSize: 16, color: Color(0xff6B7583)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: perioditems_value,
                          isExpanded: true,
                          iconSize: 24,
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
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
                    Text("메모", style: TextStyle(color: Color(0xff6B7583))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        // height: 40,
                        // width: 370,
                        child: renderTextFormField(
                          onSaved: (val) {
                            setState(() {
                              this.memo = val;
                            });
                          },
                          validator: (val) {
                            return null;
                          },
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
                            color: Color(0xff69d5e7),
                            borderRadius: BorderRadius.circular(10)),
                        height: 70,
                        width: 340,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              // 식물 등록하기 버튼 클릭 시
                              String nickname = textController1.text;
                              if (nickname.isEmpty) {
                                setState(() {
                                  error = "애칭을 입력해주세요."; // 애칭 입력 안 되었을 때 에러 문구
                                });
                              } else {
                                setState(() {
                                  error = null; //애칭이 입력된 경우 에러 메시지 숨김
                                  formKey.currentState?.save(); // 메모 저장
                                });

                                // 다이얼로그 창 띄우기
                                AlertDialog alertDialog = AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  title: Center(
                                      child: Text(
                                    '등록을 완료하시겠습니까?',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xff6B7583)),
                                  )),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              createPlant(plantService);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Plant_schedule_Page(
                                                            test_service:
                                                                plantService)),
                                              );
                                            }, // nickname(애칭) 변수 반환하며 화면 종료
                                            child: Text(
                                              '완료하기',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('취소하기',
                                                  style: TextStyle(
                                                      color: Colors.black)))
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
                              }
                            },
                            child: Text("내 식물로 등록하기",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
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
        ),
      );
    });
  }

  void createPlant(PlantService plantService) {
    // 앞뒤 공백 삭제
    String? plantname_newText = widget.plantname;
    String nickname_newText = textController1.text.trim();
    String skillchecked_newText = _isChecked2 ? "숙련자" : "비숙련자";
    String flowerpotindex_newText = potitems[0];
    String flowerspaceindex_newText = spaceitems[0];

    if (plantname_newText!.isNotEmpty) {
      //plantService.create(newText,);
      plantService.create(
          plantname_newText,
          nickname_newText,
          skillchecked_newText,
          flowerpotindex_newText,
          flowerspaceindex_newText,
          DateTime.now(),
          _selectedDate1!,
          _selectedDate2!); //220423 수정
      // createTextController_plantname.text = "";
      // createTextController_nickname.text = "";
      // createTextController_skillchecked.text = "";
      // createTextController_flowerpotindex.text = "";
      // createTextController_flowerspaceindex.text = "";
    }
  }
}
