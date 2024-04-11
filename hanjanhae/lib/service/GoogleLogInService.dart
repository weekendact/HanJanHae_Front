// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';

void signInWithGoogle(BuildContext context) async {
  // 구글 로그인
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // ignore: unused_local_variable
  final GoogleSignInAuthentication googleUserToken =
      await googleUser!.authentication;

  // ignore: unnecessary_null_comparison
  if (googleUser == null) { // 로그인 실패 시 로그인 페이지 이동
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    );
  }

  String googleId = googleUser.id;
  var googleEmail = googleUser.email;

  sendDataToDatabase(googleId, googleEmail, Endpoints.signUpUrl); // 데이터베이스 전송
}
