import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/MainPage.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

enum LoginPlatform {
  kakao,
  google,
  naver,
  none,
}

// String _accessTokenUser = AccessTokenInfo.fromJson(u).toString();

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  LoginPlatform loginPlatform = LoginPlatform.none;
  final String apiUrl = 'http://localhost:8080/user/signup'; // 데이터베이스 엔드 포인트

  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final kakaoToken = token.accessToken;
      final kakaoReToken = token.refreshToken;

      print(kakaoToken);
      print(kakaoReToken);

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      sendDateToDatebase(kakaoToken);

      setState(() {
        loginPlatform = LoginPlatform.kakao;
      });
      navigateToHomePage();
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const mainpage(),
      ),
    );
  }

  void signOut() async {
    switch (loginPlatform) {
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      loginPlatform = LoginPlatform.none;
    });
  }

  void sendDateToDatebase(String token) async {
    final tokenData = token;
    Map<String, dynamic> body = {
      'access_token' : tokenData
    };
    String jsonBody = json.encode(body); // json 형식으로 변환

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers:  <String, String>{
          'Content-Type' : 'application/json; charset=utf8',
        },
        body: jsonBody
      );
      if (response.statusCode == 200) {
        print('send');
      }
      else {
        print('error ${response.statusCode}');
      }
    }
    catch (error) {
      print('send error : $error');
    }
  }

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
                        ? navigateToHomePage()
                        : signInWithKakao();
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
                  onPressed: () {},
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
                  onPressed: () {},
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
                          style: TextStyle(fontSize: 15.0),
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
