import 'package:everybodys_plant/certification/email_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ManageProfileInformationWideget extends StatefulWidget {
  const ManageProfileInformationWideget({Key? key}) : super(key: key);

  @override
  State<ManageProfileInformationWideget> createState() =>
      _ManageProfileInformationWidegetState();
}

class _ManageProfileInformationWidegetState
    extends State<ManageProfileInformationWideget> {
  var _displayNameController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _displayNameController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthService>(
      builder: (context, service, child) {
        final user = service.currentUser();
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "기본정보",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "개인정보 보호를 위해\n내 정보는 모두 안전하게 암호화됩니다.",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "이메일",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 10),
              Text(
                user == null ? "로그인해 주세요 🙂" : "${user.email}👋",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "닉네임",
                        hintText: "닉네임을 입력해주세요",
                      ),
                      controller: _displayNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.black, // 텍스트 컬러
                        shape: RoundedRectangleBorder(
                          // 라운드형 보더
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: plantPrimaryColor,
                      ),
                      child: Text(
                        "변경",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true, // 비밀번호 안보이게 하기
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: "새로운 비밀번호",
                  hintText: "6~20자 이내로 입력",
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextFormField(
                      obscureText: true, // 비밀번호 안보이게 하기
                      controller: _repeatPasswordController,
                      validator: (value) {
                        return _newPasswordController.text == value
                            ? null
                            : "비밀번호를 다시 입력해주세요.";
                      },
                      decoration: InputDecoration(
                        labelText: "비밀번호 재확인",
                        hintText: "6~20자 이내로 입력",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.black, // 텍스트 컬러
                          shape: RoundedRectangleBorder(
                            // 라운드형 보더
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: plantPrimaryColor),
                      child: Text(
                        "변경",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              //            Row(
              //              crossAxisAlignment: CrossAxisAlignment.start,
              //              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //              children: [
              //                Expanded(
              //                  child: TextFormField(
              //                    decoration: InputDecoration(
              //                      labelText: "휴대폰 번호",
              //                      hintText: "-을 제외한 번호를 입력",
              //                    ),
              //                  ),
              //                ),
              //            Padding(
              //              padding: const EdgeInsets.all(10),
              //              child: TextButton(
              //                onPressed: () {
              //                  service.withdrawalAccount();
              //                },
              //                style: TextButton.styleFrom(
              //                  primary: Colors.black, // 텍스트 컬러
              //                  shape: RoundedRectangleBorder(
              //                    // 라운드형 보더
              //                    borderRadius: BorderRadius.circular(4),
              //                  ),
              //                  backgroundColor: Color(0xff69D5E7),
              //                ),
              //                child: Text(
              //                  "변경",
              //                  style: TextStyle(
              //                    color: Colors.white,
              //                  ),
              //                ),
              //              ),
              //            ),
            ],
            //            ),
            //          ],
          ),
        );
      },
    );
  }
}
