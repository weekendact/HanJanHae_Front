import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/MainPage.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'; // 카카오 로그인 패키지
import 'package:google_sign_in/google_sign_in.dart'; // 구글 로그인 패키지
import 'package:flutter_naver_login/flutter_naver_login.dart';

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
  final String kakaoapiUrl = 'http://localhost:8080/user/signup'; // 카카오 로그인 데이터베이스 엔드 포인트
  final String googleapiUrl = ''; // 구글 로그인 데이터베이스 엔드 포인트
  final String naverapiUrl = ''; // 네이버 로그인 데이터베이스 엔드 포인트

  void signInWithKakao() async { // 카카오 로그인
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

      final kakaoToken = token.accessToken; // 카카오 엑세스 토큰
      final kakaoInfo = json.decode(response.body);

      setState(() {
        loginPlatform = LoginPlatform.kakao; // 플랫폼 카카오
      });

      sendDateToDatebase(kakaoToken, kakaoInfo); // 데이터베이스 전송

      navigateToHomePage(); // 홈페이지 이동
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signInWithGoogle() async { // 구글 로그인
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleUserToken = await googleUser!.authentication;
    final googleToken = googleUserToken.accessToken; // 구글 엑세스 토큰

    setState(() {
      loginPlatform = LoginPlatform.google; // 플랫폼 구글
    });

    sendDateToDatebase(googleToken, googleUser); // 데이터베이스 전송

    navigateToHomePage(); // 홈페이지 이동
  }

  void signInWithNaver() async { // 네이버 로그인
    final NaverLoginResult naverResult = await FlutterNaverLogin.logIn();

    if (naverResult.status == NaverLoginStatus.loggedIn) {
      print('accesToken = ${naverResult.accessToken.accessToken}');
      print('id = ${naverResult.account.id}');
      print('email = ${naverResult.account.email}');
      print('name = ${naverResult.account.name}');
      print('info = ${naverResult.account}');
      final naverToken = naverResult.accessToken;

      setState(() {
        loginPlatform = LoginPlatform.naver;
      });

      sendDateToDatebase(naverToken, naverResult); // 데이터베이스 전송

      navigateToHomePage();
    }
  }

  void navigateToHomePage() { // 홈페이지 이동 함수
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const mainpage(),
      ),
    );
  }

  void signOut() async { // 로그아웃 함수
    switch (loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        await FlutterNaverLogin.logOut();
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      loginPlatform = LoginPlatform.none;
    });
  }

  void sendDateToDatebase(dynamic token, dynamic Info) async { // 데이터베이스 이동 함수
    final tokenData = token;
    if (loginPlatform == LoginPlatform.kakao) { // 카카오
      Map<String, dynamic> kakaoBody = {
        'access_token' : tokenData,
        'kakaoInfo' : Info,
      };
      String jsonKakaoBody = json.encode(kakaoBody); // json 형식으로 변환
      
      try {
        final kakaoResponse = await http.post(
          Uri.parse(kakaoapiUrl),
          headers:  <String, String> {
            'Content-Type' : 'application/json; charset=UTF-8',
          },
          body: jsonKakaoBody
        );
        if (kakaoResponse.statusCode == 200) {
          print('send');
        }
        else {
          print('error ${kakaoResponse.statusCode}');
        }
      }
      catch (error) {
        print('send error : $error');
      }
    }
    else if(loginPlatform == LoginPlatform.google) { // 구글
      Map<String, dynamic> googleBody = {
        'access_token' : tokenData,
        'user_id' : Info.id,
        'user_email' :Info.email,
      };

      String jsonGoogleBody = json.encode(googleBody); // json 형식 변환

      try {
        final googleResponse = await http.post(
          Uri.parse(googleapiUrl),
          headers: <String, String> {
            'Content-Type' : 'application/json; charset=UTF-8',
          },
          body: jsonGoogleBody
        );
        if(googleResponse.statusCode == 200) {
          print('send');
        }
        else {
          print('error ${googleResponse.statusCode}');
        }
      }
      catch (error) {
        print('send error : $error');
      }
    }
    else if(loginPlatform == LoginPlatform.naver) { // 네이버
      Map<String, dynamic> naverBody = {
        'access_token' : tokenData,
        'user_id' : Info.account.id,
        'user_email' :Info.account.email,
      };

      String jsonGoogleBody = json.encode(naverBody); // json 형식 변환

      try {
        final naverResponse = await http.post(
          Uri.parse(naverapiUrl),
          headers: <String, String> {
            'Content-Type' : 'application/json; charset=UTF-8',
          },
          body: jsonGoogleBody
        );
        if(naverResponse.statusCode == 200) {
          print('send');
        }
        else {
          print('error ${naverResponse.statusCode}');
        }
      }
      catch (error) {
        print('send error : $error');
      }
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
                  onPressed: () {
                    loginPlatform != LoginPlatform.none
                        ? navigateToHomePage()
                        : signInWithGoogle();
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
                    ? navigateToHomePage()
                    : signInWithNaver();
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
