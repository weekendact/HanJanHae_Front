import 'package:flutter/material.dart';
import 'package:hanjanhae/Services/KakaoLoginService.dart';
import 'package:hanjanhae/Services/NaverLoginServuce.dart';
import 'package:hanjanhae/Services/Vable.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 500,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color.fromARGB(255, 254, 229, 0),
            ),
            child: TextButton(
              onPressed: () {
                loginPlatform == LoginPlatform.kakao;

                //? //navigateToHomePage(context)홈페이지 구현
                //: 홈페이지 구현 완료시
                signInWithKakao(context);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/kakaoicon.png',
                    width: 30,
                    height: 30,
                  ),
                  const Expanded(
                    child: Text(
                      '카카오 계정 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0), color: Colors.green),
            child: TextButton(
              onPressed: () {
                loginPlatform == LoginPlatform.naver;

                //? //navigateToHomePage(context)홈페이지 구현
                //: 홈페이지 구현 완료시
                signInWithNaver(context);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/kakaoicon.png',
                    width: 30,
                    height: 30,
                  ),
                  const Expanded(
                    child: Text(
                      '네이버 계정 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
