// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void signOut(BuildContext context) async {
    // 로그아웃 함수
    switch (loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        await FlutterNaverLogin.logOut();
        break;
      case LoginPlatform.none:
        break;
    }

    loginPlatform = LoginPlatform.none;

    navigateToLogInPage(context);
  }