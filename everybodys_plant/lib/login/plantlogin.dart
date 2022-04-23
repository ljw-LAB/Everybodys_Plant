//로그인 홈화면
import 'package:everybodys_plant/certification/email_auth_service.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';
import 'package:flutter/material.dart';
import 'package:everybodys_plant/home/home.dart';
import 'package:provider/provider.dart';

class LoginHome extends StatefulWidget {
  LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  // 유저가 텍스트필드에 뭘 입력했는지가져올 수 있음
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //oop를 알면 이해 쉬움 => 앱 실행후 아래 OutlineInputBorde가 생성되기 전에 이미 생성되어있음
  final double _cornerRadius = 8.0;
  //로그인 버튼 radius 고정값
  final OutlineInputBorder _border = OutlineInputBorder(
      // 텍스트필드 파란프레임 제거용
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 8));

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(builder: (context, authService, child) {
      return Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/secondlogo.png'),
                  SizedBox(height: 16),
                  _buildTextFormField(
                      "이메일 주소", _emailController), //중복사용을 위해 메소드로 추출
                  SizedBox(height: 20),
                  _buildTextFormField("비밀번호", _passwordController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("로그인", style: TextStyle(fontSize: 21)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        // 라운드형 보더
                        borderRadius: BorderRadius.circular(_cornerRadius),
                      ),
                    ),
                    onPressed: () {
                      // 로그인
                      authService.signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        onSuccess: () {
                          // 로그인 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("로그인 성공"),
                          ));

                          // HomePage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text("회원가입", style: TextStyle(fontSize: 21)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        // 라운드형 보더
                        borderRadius: BorderRadius.circular(_cornerRadius),
                      ),
                    ),
                    onPressed: () {
                      // 회원가입
                      EmailAuthService.signUp(
                        email: _emailController.text,
                        password: _passwordController.text,
                        onSuccess: () {
                          // 회원가입 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("회원 가입 성공"),
                          ));
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      cursorColor: Colors.white, //커서 색깔
      controller: controller,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "입력창이 비어있어요!";
        }

        return null;
      },
      style: TextStyle(color: Colors.white), //글씨 색깔
      decoration: InputDecoration(
        filled: true, // 텍스트필드 내부 색깔 채울건지 여부
        fillColor: Colors.black45, // 텍스트필드 색깔
        labelText: labelText,
        border: _border,
        enabledBorder: _border, //바깥보더사라짐
        focusedBorder: _border,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
