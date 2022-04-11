//로그인 홈화면
import 'package:flutter/material.dart';
import 'package:everybodys_plant/home/home.dart';

class LoginHome extends StatelessWidget {
  LoginHome({Key? key}) : super(key: key);

  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>(); //글로벌키 선언
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  // 유저가 텍스트필드에 뭘 입력했는지가져올 수 있음
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //oop를 알면 이해 쉬움 => 앱 실행후 아래 OutlineInputBorde가 생성되기 전에 이미 생성되어있음
  final double _cornerRadius = 8.0; //로그인 버튼 radius 고정값

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
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/secondlogo.png'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
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
        backgroundColor: Colors.green,
        title: Text("회원가입 정보입력"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "이메일",
                      hintText: "이메일을 입력하세요.",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => setState(() => isVisible = !isVisible),
                  style: TextButton.styleFrom(
                    primary: Colors.black, // 텍스트 컬러
                    shape: RoundedRectangleBorder(
                      // 라운드형 보더
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: Text("중복체크"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginHome()));
                },
                style: TextButton.styleFrom(
                  primary: Colors.white, // 텍스트 컬러
                  shape: RoundedRectangleBorder(
                    // 라운드형 보더
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
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
        border: OutlineInputBorder(
          // 텍스트필드 파란프레임 제거용
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 8),
        ),
      ),
    );
  }
}
