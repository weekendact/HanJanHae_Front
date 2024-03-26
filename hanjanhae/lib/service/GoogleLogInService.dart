import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:hanjanhae/service/SendDateToDatebaseService.dart';

const String googleapiUrl = ''; // 구글 로그인 데이터베이스 엔드 포인트

void signInWithGoogle(BuildContext context) async {
  // 구글 로그인
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // ignore: unused_local_variable
  final GoogleSignInAuthentication googleUserToken = await googleUser!.authentication;
  // final googleToken = googleUserToken.accessToken; // 구글 엑세스 토큰

  Map<String, dynamic> googleBody = {
      'email': googleUser.email,
      'id' : googleUser.id,
    };

  loginPlatform = LoginPlatform.google; // 플랫폼 구글

  sendDateToDatebase(googleBody, googleapiUrl); // 데이터베이스 전송

  navigateToHomePage(context); // 홈페이지 이동
}
