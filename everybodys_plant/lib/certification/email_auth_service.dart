import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthService extends ChangeNotifier {
  User? currentUser() {
    // 현재 유저(로그인 되지 않은 경우 null 반환)
    return FirebaseAuth.instance.currentUser;
  }

  static void signUp({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function onSuccess, // 가입 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 회원가입
    // 이메일 및 비밀번호 입력 여부 확인
    if (email.isEmpty) {
      onError("이메일을 입력해 주세요.");
      return;
    } else if (password.isEmpty) {
      onError("비밀번호를 입력해 주세요.");
      return;
    }

    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

//      if (result != null) {
//        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
//       await FirebaseAuth.instance.authStateChanges().listen((fu) {
//          if (fu?.emailVerified == true) {
//            if (result.user?.emailVerified == true) {
//              // 인증 메일 발송
//              // 새로운 계정 생성이 성공하였으므로 기존 계정이 있을 경우 로그아웃 시킴
//              //notifyListeners(); // 로그인 상태 변경 알림
//              //signOut();
//              onSuccess('이메일 인증 성공');
//            } else {
//              onError('이메일 인증 실패');
//            }
//          }
//        });
//      } else {
//        onError('이미 가입한 메일입니다');
//      }
      //  성공 함수 호출
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // 회원가입 실패시
      // Firebase auth 에러 발생
      if (e.code == 'weak-password') {
        onError('비밀번호를 6자리 이상 입력해 주세요.');
      } else if (e.code == 'email-already-in-use') {
        onError('이미 가입된 이메일 입니다.');
      } else if (e.code == 'invalid-email') {
        onError('이메일 형식을 확인해주세요.');
      } else if (e.code == 'user-not-found') {
        onError('일치하는 이메일이 없습니다.');
      } else if (e.code == 'wrong-password') {
        onError('비밀번호가 일치하지 않습니다.');
      } else {
        onError(e.message!);
      }
    } catch (e) {
      // 서버와 통신 실패시
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  void signIn({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function onSuccess, // 로그인 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 로그인
    if (email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
      return;
    }

    // 로그인 시도
    try {
      UserCredential signinResult =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
//      if (signinResult.user?.emailVerified == true) {
      onSuccess(); // 성공 함수 호출
      notifyListeners(); // 로그인 상태 변경 알림
//      } else {
//        onError('이메일 인증 실패');
//      }
    } on FirebaseAuthException catch (e) {
      // firebase auth 에러 발생
      onError(e.message!);
      //onError('가입되지 않은 이메일이거나 비밀번호가 틀렸습니다');
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }
}

void signOut() async {}
//