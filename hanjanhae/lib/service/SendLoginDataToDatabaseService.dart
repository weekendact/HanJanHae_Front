// ignore_for_file: file_names, unnecessary_string_interpolations, avoid_print, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:http/http.dart' as http;

void sendDataToDatabase(String id, String email, String apiUrl) async {
  // 유저 정보 데이터베이스 전송 함수
  Map<String, String> body = {
    'usersSocialId': id,
    'usersEmail': email,
  };
  String jsonBody = json.encode(body); // json 형식으로 변환

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    // 201 신규 사용자
    // 200 기존 사용자
    if (response.statusCode == 201) {
      // 신규 사용자
      print('Response body: ${response.body}');
    } else if (response.statusCode == 200) {
      // 기존 사용자
      print("Response body: ${response.body}");
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('An error occurred: $e');
  }
}

Future<bool> sendTokenToDatabase(String? token, String apiUrl) async {
  // 헤더에 보내는 형식으로 변경**
  // Token 데이터베이스 전송
  // String jsontoken = json.encode(token);

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),
      headers: {'Authorization': 'Bearer ${token}'},
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Authorization': '$jsontoken',
      // },
    );
    if (response.statusCode == 200) {
      print('send');
      return true;
    } else {
      print('error ${response.statusCode}');
      return false;
    }
  } catch (error) {
    print('send error : $error');
    return false;
  }
}