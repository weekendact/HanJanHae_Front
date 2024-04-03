import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
import 'package:hanjanhae/service/DatabaseUrlAddresses.dart';

void signInWithNaver(BuildContext context) async {
  // 네이버 로그인
  final NaverLoginResult naverResult = await FlutterNaverLogin.logIn();
  // ignore: unused_local_variable
  NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;
  if (naverResult.status == NaverLoginStatus.loggedIn) {
    loginPlatform = LoginPlatform.naver;

    String naverId = naverResult.account.id;
    var naverEmail = naverResult.account.email;

    print(naverId);
    print(naverEmail);
    print('');

    sendDataToDatabase(naverId, naverEmail, loginApiUrl);

    // SecureStorageService().saveToken(naverToken.accessToken); // 내부 데이터베이스에 토큰 값 저장
    // navigateToHomePage(context); // 홈페이지 이동
  }
}
