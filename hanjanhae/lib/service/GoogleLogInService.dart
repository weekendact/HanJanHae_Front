import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
import 'package:hanjanhae/service/DatabaseUrlAddresses.dart';

void signInWithGoogle(BuildContext context) async {
  // 구글 로그인
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // ignore: unused_local_variable
  final GoogleSignInAuthentication googleUserToken =
      await googleUser!.authentication;

  // ignore: unnecessary_null_comparison
  if (googleUser == null) { // 로그인 실패 시 로그인 페이지 이동
    MaterialPageRoute(
      builder: (context) => const loginpage(),
    );
  }

  loginPlatform = LoginPlatform.google; // 플랫폼 구글

  String googleId = googleUser.id;
  var googleEmail = googleUser.email;

  print('${googleId}');
  print('${googleEmail}');
  print('');

  sendDataToDatabase(googleId, googleEmail, loginApiUrl); // 데이터베이스 전송
}
