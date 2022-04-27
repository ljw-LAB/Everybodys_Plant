//회원가입
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:everybodys_plant/certification/email_auth_service.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isVisible = false;
  // 여러 텍스트필드 숨겼다가 보였다가 하기
  final TextEditingController displaynameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController signupforPWController = TextEditingController();

  final TextEditingController _cPasswordController = TextEditingController();

  final TextEditingController _ContactnumberController =
      TextEditingController();

  //oop를 알면 이해 쉬움 => 앱 실행후 아래 OutlineInputBorde가 생성되기 전에 이미 생성되어있음
  final double _cornerRadius = 8.0;
  //로그인 버튼 radius 고정값
  final OutlineInputBorder _secondborder = OutlineInputBorder(
      // 텍스트필드 파란프레임 제거용
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 8));

  @override
  Widget build(BuildContext context) {
    return Provider<EmailAuthService>(
      create: (_) => EmailAuthService(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "회원가입 정보입력",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextFormField(
                      //  onSaved: (deger) => = deger!,
                      textInputAction: TextInputAction.done,
                      controller: displaynameController,
                      decoration: InputDecoration(
                        labelText: "닉네임",
                        hintText: "10자이내로 입력하세요.",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: TextButton(
                        onPressed: () => setState(() => isVisible = !isVisible),
                        style: TextButton.styleFrom(
                          primary: Colors.black, // 텍스트 컬러
                          shape: RoundedRectangleBorder(
                            // 라운드형 보더
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: plantPrimaryColor,
                        ),
                        child: Text(
                          "중복체크",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Visibility(
                // ListView는 Visibility랑 호환X
                visible: isVisible,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    _buildTextFormField2("이메일을 입력해주세요", emailController),
                    SizedBox(height: 16),
                    _buildTextFormField2("비밀번호를 입력해주세요", signupforPWController),
                    SizedBox(height: 16),
                    //_buildTextFormField2(
                    //    "비밀번호를 다시 입력해주세요", _cPasswordController),
                    //SizedBox(height: 16),
                    //_buildTextFormField2(
                    //    "연락처를 입력해주세요", _ContactnumberController),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isVisible,
                child: TextButton(
                  onPressed: () {
                    // EmailAuthService의 sign up함수호출
                    EmailAuthService.signUp(
                      email: emailController.text,
                      password: signupforPWController.text,
                      onSuccess: () {
                        //회원가입 완료 후 팝업
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "회원가입을 완료하였습니다.\n 가입해주셔서 감사합니다.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: TextButton(
                                      onPressed: () {
                                        // '확인'클릭 시 로그인 화면으로 돌아가기
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginHome()));
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize:
                                            const Size(double.infinity, 20),
                                        primary: Colors.white, // 텍스트 컬러
                                        shape: RoundedRectangleBorder(
                                          // 라운드형 보더
                                          borderRadius: BorderRadius.circular(
                                              _cornerRadius),
                                        ),
                                        backgroundColor: plantPrimaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      onError: (err) {
                        //회원가입 완료 후 팝업
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    err,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: TextButton(
                                      onPressed: () {
                                        // '확인'클릭 시 바텀시트내려감
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize:
                                            const Size(double.infinity, 20),
                                        primary: Colors.white, // 텍스트 컬러
                                        shape: RoundedRectangleBorder(
                                          // 라운드형 보더
                                          borderRadius: BorderRadius.circular(
                                              _cornerRadius),
                                        ),
                                        backgroundColor: plantPrimaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white, // 텍스트 컬러
                    shape: RoundedRectangleBorder(
                      // 라운드형 보더
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: plantPrimaryColor,
                  ),
                  child: Text("등록하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField _buildTextFormField2(
    String labelText, TextEditingController controller) {
  return TextFormField(
    cursorColor: Colors.black, //커서 색깔
    controller: controller,
    validator: (text) {
      if (text == null || text.isEmpty) {
        return "입력창이 비어있어요!";
      }

      return null;
    },
    style: TextStyle(color: Colors.black45), //글씨 색깔
    decoration: InputDecoration(
      filled: true, // 텍스트필드 내부 색깔 채울건지 여부
      fillColor: Colors.white, // 텍스트필드 색깔
      labelText: labelText,
    ),
  );
}
