// 세팅페이지-푸시알람/개인정보수정/로그아웃/회원탈퇴
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:everybodys_plant/login/manage_profile_information_widget.dart';
import 'package:everybodys_plant/login/plantlogin.dart';
import 'package:everybodys_plant/certification/email_auth_service.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(
      builder: (context, service, child) {
        final user = service.currentUser();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0, //앱바 그림지 효과지우기
            backgroundColor: Colors.white,
            title: Text(
              "설정",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(primary: Colors.black),
                      child: Text(
                        "푸쉬알림 On/Off",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Spacer(),
                    Switch(
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        })
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InfoEdit()));
                  },
                  style: TextButton.styleFrom(primary: Colors.black),
                  child: Text(
                    "개인정보 수정",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Divider(
                  color: Colors.black12,
                ),
                TextButton(
                  onPressed: () {
                    service.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginHome()));
                  },
                  style: TextButton.styleFrom(primary: Colors.black),
                  child: Text(
                    "로그아웃",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Divider(
                  color: Colors.black12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Withdrawal()));
                  },
                  style: TextButton.styleFrom(primary: Colors.black),
                  child: Text(
                    "회원탈퇴",
                    style: TextStyle(
                      color: Color(0xffEA4C09), //컬러값 지정
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 개인정보 수정페이지
class InfoEdit extends StatefulWidget {
  InfoEdit({Key? key}) : super(key: key);

  @override
  State<InfoEdit> createState() => _InfoEditState();
}

class _InfoEditState extends State<InfoEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(
      builder: (context, service, child) {
        final user = service.currentUser();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0, //앱바 그림지 효과지우기
            centerTitle: true,
            backgroundColor: Colors.white,

            title: const Text(
              "개인정보 수정",
              style: TextStyle(color: Colors.black),
            ),
          ), //resizeToAvoidBottomInset=>overflow에러 발생 해결책
          bottomSheet: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ManageProfileInformationWideget(),
          ),
        );
      },
    );
  }
}

//회원탈퇴페이지

class Withdrawal extends StatefulWidget {
  Withdrawal({Key? key}) : super(key: key);

  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(
      builder: (context, service, child) {
        final user = service.currentUser();
        return Scaffold(
          appBar: AppBar(
            elevation: 0, //앱바 그림지 효과지우기
            centerTitle: true,
            backgroundColor: Colors.white,
            title: const Text(
              "회원탈퇴",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "회원탈퇴 확인",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "회원탈퇴시 모두의 식물 서비스이용이 불가합니다.\n동의하시면 비밀번호를 입력해주세요.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    hintText: "10~20자 이내로 입력",
                  ),
                ),
                Spacer(),
                Positioned(
                  bottom: 18,
                  left: 24,
                  right: 24,
                  child: GestureDetector(
                    onTap: () {
                      service.withdrawalAccount();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginHome()));
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
                        "계정 삭제하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
