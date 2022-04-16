//로그인 홈화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:everybodys_plant/home/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

// 스플래시 스크린
class splashscreen extends StatelessWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
      duration: 2500, //머무는 시간
      splash: Image.asset(
        'assets/splashscreen_plant.png',
        fit: BoxFit.cover,
      ),
      splashIconSize: double.infinity,
      nextScreen: LoginHome(),
      splashTransition: SplashTransition.fadeTransition,
    ));
  }
}

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
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _FormKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 40),
              Text(
                "이메일 주소를 입력해주세요",
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                  "이메일 주소", _emailController), //중복사용을 위해 메소드로 추출
              SizedBox(height: 8),
              _buildTextFormField("비밀번호", _passwordController),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            //MaterialPageRoute 안정장치로 Builder를사용해 Route기능으로
                            context,
                            MaterialPageRoute(builder: (context) => FindID()));
                      },
                      style: TextButton.styleFrom(primary: Colors.black),
                      child: Text("아이디"),
                    ),
                    Text("/"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindPassword()));
                      },
                      style: TextButton.styleFrom(primary: Colors.black),
                      child: Text("비밀번호"),
                    ),
                    Text("찾기"),
                  ],
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  //메인화면으로 이동하기-설정페이지test용=>추후 MyHomePage로 변경
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
                style: TextButton.styleFrom(
                  primary: Colors.white, // 텍스트 컬러
                  shape: RoundedRectangleBorder(
                    // 라운드형 보더
                    borderRadius: BorderRadius.circular(_cornerRadius),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Text("로그인"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                style: TextButton.styleFrom(primary: Colors.black),
                child: Text("회원가입"),
              ),
            ],
          ),
        ),
      ),
    );
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

//세팅페이지
class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var switchValue = false;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
            Text("sample@naver.com"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "이름",
                      hintText: "이름을 입력해주세요",
                    ),
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
                      backgroundColor: Color(0xff69D5E7),
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
              decoration: InputDecoration(
                labelText: "비밀번호",
                hintText: "10~20자 이내로 입력",
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "비밀번호 확인",
                      hintText: "10~20자 이내로 입력",
                    ),
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
                      backgroundColor: Color(0xff69D5E7),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "휴대폰 번호",
                      hintText: "-을 제외한 번호를 입력",
                    ),
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
                      backgroundColor: Color(0xff69D5E7),
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
          ],
        ),
      ),
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
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Color(
                      0xff69D5E7,
                    ),
                  ),
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
  }
}

//아이디 찾기
class FindID extends StatelessWidget {
  const FindID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("아이디 찾기"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 62,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "회원님의 이름과\n전화번호를 입력해주세요",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18),
            TextFormField(
                decoration: InputDecoration(
              hintText: "이름을 입력해주세요",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            )),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "핸드폰 번호를 입력해주세요",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FindIDDetail()));
                },
                style: TextButton.styleFrom(
                  primary: Colors.white, // 텍스트 컬러
                  shape: RoundedRectangleBorder(
                    // 라운드형 보더
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Text("다음"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 아이디찾기 디데일
class FindIDDetail extends StatelessWidget {
  const FindIDDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("아이디 찾기"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "고객님의 아이디 목록입니다.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Text("seijin0722@naver.com"),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              style: TextButton.styleFrom(
                primary: Colors.white, // 텍스트 컬러
                shape: RoundedRectangleBorder(
                  // 라운드형 보더
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.green,
              ),
              child: Text("로그인"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: Text("회원가입"),
            ),
          ],
        ),
      ),
    );
  }
}

//비밀번호 찾기
class FindPassword extends StatelessWidget {
  const FindPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("비밀번호 찾기"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 62,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "회원님의 이메일과\n전화번호를 입력해주세요",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18),
            TextFormField(
                decoration: InputDecoration(
              hintText: "이메일을 입력해주세요",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            )),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "핸드폰 번호를 입력해주세요",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FindPWDetail()));
                },
                style: TextButton.styleFrom(
                  primary: Colors.white, // 텍스트 컬러
                  shape: RoundedRectangleBorder(
                    // 라운드형 보더
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Text("다음"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//비밀번호 찾기 디테일
class FindPWDetail extends StatelessWidget {
  const FindPWDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("비밀번호 찾기"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text("고객님의 비밀번호입니다."),
      ),
    );
  }
}

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

//회원가입
class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isVisible = false;
  // 여러 텍스트필드 숨겼다가 보였다가 하기
  final TextEditingController _NameController = TextEditingController();

  final TextEditingController _signupforPWController = TextEditingController();

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
    return Scaffold(
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
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "이메일",
                      hintText: "이메일을 입력하세요.",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    style: TextButton.styleFrom(
                      primary: Colors.black, // 텍스트 컬러
                      shape: RoundedRectangleBorder(
                        // 라운드형 보더
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xff69D5E7),
                    ),
                    child: Text(
                      "중복체크",
                      style: TextStyle(
                        color: Colors.white,
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
                  _buildTextFormField2("이름을 입력해주세요", _NameController),
                  SizedBox(height: 16),
                  _buildTextFormField2("비밀번호를 입력해주세요", _signupforPWController),
                  SizedBox(height: 16),
                  _buildTextFormField2("비밀번호를 다시 입력해주세요", _cPasswordController),
                  SizedBox(height: 16),
                  _buildTextFormField2("연락처를 입력해주세요", _ContactnumberController),
                ],
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: isVisible,
              child: TextButton(
                onPressed: () {
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                            builder: (context) => LoginHome()));
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 20),
                                    primary: Colors.white, // 텍스트 컬러
                                    shape: RoundedRectangleBorder(
                                      // 라운드형 보더
                                      borderRadius:
                                          BorderRadius.circular(_cornerRadius),
                                    ),
                                    backgroundColor: Color(0xff69D5E7),
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
                      });
                },
                style: TextButton.styleFrom(
                  primary: Colors.white, // 텍스트 컬러
                  shape: RoundedRectangleBorder(
                    // 라운드형 보더
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color(0xff69D5E7),
                ),
                child: Text("등록하기"),
              ),
            ),
          ],
        ),
      ),
    );
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
}
