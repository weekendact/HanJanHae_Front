import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjanhae/service/NavitateToService.dart';
import 'package:http/http.dart' as http;
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:hanjanhae/service/userSecureStorageService.dart';

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
    final kakaoInfo = response.body;
    loginPlatform = LoginPlatform.kakao; // 플랫폼 카카오

    SecureStorageService().saveToken(token.accessToken); // 내부 데이터베이스에 토큰 값 저장
    sendDataToDatabase(kakaoInfo, kakaoapiUrl); // 데이터베이스 전송
    navigateToHomePage(context); // 홈페이지 이동

  } catch (error) {
    print('카카오톡으로 로그인 실패 $error');
  }
}
