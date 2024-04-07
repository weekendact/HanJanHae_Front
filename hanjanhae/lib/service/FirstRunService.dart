// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:hanjanhae/service/userSecureStorageService.dart';

void jwtTokenCheckService(BuildContext context) {
  // ignore: unnecessary_null_comparison
  if(SecureStorageService().selectToken() != null) {
    // 토큰 값이 비어있지 않고, 데이터베이스에 토큰 값 전송 후 유저 정보가 있으면 메인페이지로 이동 없으면 로그인 페이지로 이동
    navigateToHomePage(context);
  }
  else {
    navigateToLogInPage(context);
  }
}