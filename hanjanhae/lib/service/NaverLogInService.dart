// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
import 'package:hanjanhae/service/Variable.dart';

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

    // sendDataToDatabase(naverId, naverEmail, Endpoints.signUpUrl);
  }
}
