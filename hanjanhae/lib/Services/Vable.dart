import 'package:flutter/material.dart';

GlobalKey<FormState> logInDetailFormkey =
    GlobalKey<FormState>(); // 로그인 정보 페이지 폼키
TextEditingController nicknameController =
    TextEditingController(); // 로그인 정보 닉네임
TextEditingController ageController = TextEditingController(); // 로그인 정보 나이

enum LoginPlatform {
  // 로그인 플랫폼 리스트
  kakao,
  google,
  naver,
  none,
}

LoginPlatform loginPlatform = LoginPlatform.none;
