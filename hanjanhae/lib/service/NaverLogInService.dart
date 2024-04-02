import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
import 'package:hanjanhae/service/userSecureStorageService.dart';

const String naverapiUrl = ''; // 네이버 로그인 데이터베이스 엔드 포인트

void signInWithNaver(BuildContext context) async {
  // 네이버 로그인
  final NaverLoginResult naverResult = await FlutterNaverLogin.logIn();
  NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;
  if (naverResult.status == NaverLoginStatus.loggedIn) {
    Map<String, dynamic> naverBody = {
      'email' : naverResult.account.email,
      'id' : naverResult.account.id,
    };
    loginPlatform = LoginPlatform.naver;

    SecureStorageService().saveToken(naverToken.accessToken); // 내부 데이터베이스에 토큰 값 저장
    sendDataToDatabase(naverBody, naverapiUrl); // 데이터베이스 전송
    navigateToHomePage(context); // 홈페이지 이동
  }
}
