// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/pages/MainPage.dart';

void navigateToHomePage(BuildContext context) async {
  // 홈페이지 이동 함수
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const MainPage(),
    ),
  );
}

void navigateToLogInPage(BuildContext context) {
  // 로그인페이지 이동 함수
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
