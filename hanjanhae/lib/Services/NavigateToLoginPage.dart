import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/LoginPage.dart';

void navigateToLogInPage(BuildContext context) {
  // 로그인페이지 이동 함수
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
