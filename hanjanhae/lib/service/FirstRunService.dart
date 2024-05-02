// ignore_for_file: file_names, unrelated_type_equality_checks, unnecessary_null_comparison, use_build_context_synchronously
// import 'package:flutter/material.dart';
// import 'package:hanjanhae/DatabaseUrlAddresses.dart';
// import 'package:hanjanhae/service/NavitateToService.dart';
// import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';
// import 'package:hanjanhae/service/userSecureStorageService.dart';

// Future<void> jwtTokenCheckService(BuildContext context) async {
//   final Future<String?> token = SecureStorageService().selectToken();
  
//   // 토큰이 null이 아니라면, 즉 토큰이 존재한다면
//   if (token != null) {
//     final bool isUserValid = await sendTokenToDatabase(token as String?, Endpoints.logInUrl);
    
//     // 데이터베이스에 토큰 값 전송 후 유저 정보가 있으면 메인 페이지로 이동, 없으면 로그인 페이지로 이동
//     if (isUserValid) {
//       navigateToHomePage(context);
//     } else {
//       navigateToLogInPage(context);
//     }
//   } else {
//     // 토큰이 null이라면 로그인 페이지로 이동
//     navigateToLogInPage(context);
//   }
// }