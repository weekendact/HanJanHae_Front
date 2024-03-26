import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:hanjanhae/service/SendDateToDatebaseService.dart';

const String naverapiUrl = ''; // 네이버 로그인 데이터베이스 엔드 포인트

void signInWithNaver(BuildContext context) async {
  // 네이버 로그인
  final NaverLoginResult naverResult = await FlutterNaverLogin.logIn();

  if (naverResult.status == NaverLoginStatus.loggedIn) {
    print('accesToken = ${naverResult.accessToken.accessToken}');
    print('id = ${naverResult.account.id}');
    print('email = ${naverResult.account.email}');
    print('name = ${naverResult.account.name}');
    print('info = ${naverResult.account}');

    Map<String, dynamic> naverBody = {
      'email' : naverResult.account.email,
      'id' : naverResult.account.id,
    };

    // final naverInfo = json.encode(naverBody);

    loginPlatform = LoginPlatform.naver;

    sendDateToDatebase(naverBody, naverapiUrl); // 데이터베이스 전송

    navigateToHomePage(context);
  }
}
