import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:http/http.dart' as http;
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/SendDateToDatebaseService.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

const String kakaoapiUrl =
    'http://localhost:8080/user/signup'; // 카카오 로그인 데이터베이스 엔드 포인트

void signInWithKakao(BuildContext context) async {
  // 카카오 로그인
  try {
    bool isInstalled = await isKakaoTalkInstalled();
    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final url = Uri.https('kapi.kakao.com', '/v2/user/me');

    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'},
    );

    // final kakaoToken = token.accessToken; // 카카오 엑세스 토큰
    // final kakaoInfo = json.decode(response.body);
    final kakaoInfo = response.body;

    loginPlatform = LoginPlatform.kakao; // 플랫폼 카카오

    sendDateToDatebase(kakaoInfo, kakaoapiUrl); // 데이터베이스 전송

    navigateToHomePage(context);
  } catch (error) {
    print('카카오톡으로 로그인 실패 $error');
  }
}
