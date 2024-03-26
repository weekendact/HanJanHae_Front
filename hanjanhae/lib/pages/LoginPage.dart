import 'package:flutter/material.dart';
import 'package:hanjanhae/service/GoogleLogInService.dart';
import 'package:hanjanhae/service/KakaoLogInService.dart';
import 'package:hanjanhae/service/NaverLogInService.dart';
import 'package:hanjanhae/service/NavitateToService.dart';

enum LoginPlatform {
  kakao,
  google,
  naver,
  none,
}

LoginPlatform loginPlatform = LoginPlatform.none;

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 60.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 250.0,
                  width: 200.0,
                  margin: const EdgeInsets.only(
                    bottom: 100.0,
                  ),
                  color: Colors.grey,
                  child: const Center(
                    child: Text(
                      'Logo',
                    ),
                  ),
                ),
              ),
              Container(
                // 카카오 계정 로그인 버튼
                height: 50.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  color: const Color.fromARGB(255, 254, 229, 0),
                ),
                margin: const EdgeInsets.only(
                  bottom: 15.0,
                ),
                child: TextButton(
                  onPressed: () {
                    loginPlatform != LoginPlatform.none
                        ? navigateToHomePage(context)
                        : signInWithKakao(context);
                    //  print('${}');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/loginicon/kakaoicon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      const Expanded(
                        child: Text(
                          '카카오 계정 로그인',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // 구글 계정 로그인 버튼
                height: 50.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                margin: const EdgeInsets.only(
                  bottom: 15.0,
                ),
                child: TextButton(
                  onPressed: () {
                    loginPlatform != LoginPlatform.none
                        ? navigateToHomePage(context)
                        : signInWithGoogle(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/loginicon/googleicon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      const Expanded(
                        child: Text(
                          '구글 계정 로그인',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // 네이버 계정 로그인 버튼
                height: 50.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  color: const Color.fromARGB(255, 3, 199, 90),
                ),
                margin: const EdgeInsets.only(
                  bottom: 15.0,
                ),
                child: TextButton(
                  onPressed: () {
                    loginPlatform != LoginPlatform.none
                        ? navigateToHomePage(context)
                        : signInWithNaver(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/loginicon/navericon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      const Expanded(
                        child: Text(
                          '네이버 계정 로그인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
