import 'package:everybodys_plant/certification/email_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "비밀번호 재설정",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text(
                    "비밀번호를 재설정하기 위해\n이메일을 입력해주세요",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "이메일을 입력해주세요",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (email)=>
                    //  email != null && !EmailValidator.validate(email)
                    //  ? '유효한 이메일을 입력하세요' : null,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: plantPrimaryColor,
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: Icon(Icons.email_outlined),
                    label: Text(
                      '비밀번호 재설정하기',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: resetPassword,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//비밀번호
  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('비밀번호 재설정을 메일로 보냈습니다')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('알맞은 이메일을 입력하세요')));
      Navigator.of(context).pop();
    }
  }
}
