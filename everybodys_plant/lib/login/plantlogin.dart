//로그인 홈화면
import 'package:everybodys_plant/certification/email_auth_service.dart';
import 'package:everybodys_plant/home/home_frame.dart';
import 'package:everybodys_plant/login/ForgetPassword_page.dart';
import 'package:everybodys_plant/login/setting_page.dart';
import 'package:everybodys_plant/login/signup_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:everybodys_plant/schedule/scheduler_org.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginHome extends StatefulWidget {
  LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  //글로벌키 선언
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  // 유저가 텍스트필드에 뭘 입력했는지가져올 수 있음
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //oop를 알면 이해 쉬움 => 앱 실행후 아래 OutlineInputBorde가 생성되기 전에 이미 생성되어있음
  final double _cornerRadius = 8.0;
  //로그인 버튼 radius 고정값
  final OutlineInputBorder _border = OutlineInputBorder(
      // 텍스트필드 파란프레임 제거용
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 8));

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(
      builder: (context, service, child) {
        final user = service.currentUser();
        return Scaffold(
          // 텍스트필드를 쳤을때 키보드가 올라오면 29픽셀이 오버플로우되는 현상
          // 이를 해결하기 위해 Scaffold 의 resizeToAvoidBottomInset: false 속성 값 적용
          // true가 디폴트값이기 때문에 false로 안하면 overflow에러 생김
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              elevation: 0, //앱바 그림지 효과지우기
              centerTitle: true,
              backgroundColor: Colors.white),
          body: SafeArea(
            child: Form(
              key: _FormKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "이메일 주소를 입력해주세요",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: size * 12),
                    _buildTextFormField(
                        "아이디(이메일)", emailController), //중복사용을 위해 메소드로 추출
                    SizedBox(height: 8),
                    _buildTextFormField("비밀번호", passwordController),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            style: TextButton.styleFrom(primary: Colors.black),
                            child: Text(
                              "비밀번호를 잊으셨나요?",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        service.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                          onSuccess: () {
                            // 로그인 성공
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //  content: Text("로그인 성공"),
                            // ));
                          },
                          onError: (err) {
                            // 에러 발생
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(err),
                            ));
                          },
                        );
                        //메인화면으로 이동하기-SettingPage설정페이지test용=>추후 MyHomePage로 변경
                        //                    Navigator.push(
                        //                        context,
                        //                        MaterialPageRoute(
                        //                            builder: (context) => MyHomePage()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: plantPrimaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          "로그인하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        style: TextButton.styleFrom(primary: plantPrimaryColor),
                        child: Text("이메일로 가입"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

TextFormField _buildTextFormField(
    String labelText, TextEditingController controller) {
  return TextFormField(
    cursorColor: plantPrimaryColor, //커서 색깔
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
      fillColor: Colors.black12, // 텍스트필드 색깔
      labelText: labelText,
      // border: _border,
      //  enabledBorder: _border, //바깥보더사라짐
      //  focusedBorder: _border,
      labelStyle: TextStyle(color: Colors.black45),
    ),
  );
}

//비밀번호 찾기

//로그인 후 메인홈
class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Main Home",
                style: TextStyle(color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ),
      ),
    );
  }
}
