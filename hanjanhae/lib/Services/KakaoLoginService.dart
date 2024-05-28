// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjanhae/DatabaseUrlAdress.dart';
import 'package:hanjanhae/Services/SendDataToDatabase.dart';
import 'package:hanjanhae/Services/UserSecureStorageService.dart';
import 'package:hanjanhae/Services/Vable.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

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
    final Map<String, dynamic> kakaoUser = jsonDecode(kakaoInfo);
    loginPlatform = LoginPlatform.kakao; // 플랫폼 카카오

    // id, email 값 추출
    String kakaoId = kakaoUser['id'].toString();
    var kakaoEmail;
    if (kakaoUser['kakao_account'] != null &&
        kakaoUser['kakao_account']['has_email']) {
      kakaoEmail = kakaoUser['kakao_account']['email'];
    }
    print(kakaoEmail);
    print(kakaoId);
    // sendDataToDatabase(kakaoId, kakaoEmail, Endpoints.signUpUrl); // 데이터베이스 전송

    Future<String?> jwt = SecureStorageService().selectToken();
    await sendTokenToDatabase(jwt, Endpoints.nicknameDuplicateUrl);
  } catch (error) {
    print('카카오톡으로 로그인 실패 $error');
  }
}
