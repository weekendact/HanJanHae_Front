// ignore_for_file: file_names, unnecessary_string_interpolations, avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:hanjanhae/service/Variable.dart';
import 'package:http/http.dart' as http;
import 'package:hanjanhae/service/userSecureStorageService.dart';

Future<void> sendTestToDatabase() async {

  dynamic saveToken = await SecureStorageService().selectToken() as dynamic;

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}${Endpoints.testaUrl}"),  // http://10.200.32.200:8080/testa
      headers: <String, String>{
        'Content-Type': 'application/json;', // charset=UTF-8',
        'Authorization': '$saveToken',
      },
    );
    if (response.statusCode == 200) {
      print("ok");
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('An error occurred: $e');
  }
}

Future<void> sendLoginDataToDatabased(String id, String email, String apiUrl) async {
  // 유저 정보 데이터베이스 전송 함수
  Map<String, String> body = {
    'usersSocialId': id,
    'usersSocialEmail': email,
  };
  String jsonBody = json.encode(body); // json 형식으로 변환

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),  // http://10.200.32.200:8080/users/login
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      // login 엔드포인트
      print(response.headers);
      String contentType = response.headers['authorization'] ?? 'unknown';
      print("---------------------------");
      print('$contentType');
      SecureStorageService().saveToken(contentType);
      print("---------------------------");

      sendTestToDatabase();
      
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('An error occurred: $e');
  }
}

Future<void> sendDataToDatabase(String id, String email, String apiUrl) async {
  // 유저 정보 데이터베이스 전송 함수
  Map<String, String> body = {
    'usersSocialId': id,
    'usersSocialEmail': email,
  };
  String jsonBody = json.encode(body); // json 형식으로 변환

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),  // http://10.200.32.200:8080/users/join
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      // login 엔드포인트
      print(response.body);
      sendLoginDataToDatabased(id, email, Endpoints.logInUrl);
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('An error occurred: $e');
  }
}

Future<void> sendTokenToDatabase(Future<String?> token, String apiUrl) async {
  // 헤더에 보내는 형식으로 변경**
  // Token 데이터베이스 전송
  // String jsontoken = json.encode(token);

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),
      headers: {'Authorization': '${token}'},
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Authorization': '$jsontoken',
      // },
    );
    if (response.statusCode == 200) {
      print('send');
    } else {
      print('error ${response.statusCode}');
    }
  } catch (error) {
    print('send error : $error');
  }
}

Future<void> sendBaseLiquorToDatabase(String baseLiquor, String apiUrl) async {
  String headerValue = Uri.encodeComponent('보드카');

  var headers = {
  'Content-Type': 'application/json',
  'Custom-Header': headerValue, // 인코딩된 '보드카'
};
  Map<String, String> body = {
    'drinkTypeName': baseLiquor,
  };

  String jsonBody = jsonEncode(body);

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$apiUrl"),
      headers: headers,
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Custom-Header': headerValue,
      // },
      // body: jsonBody,
    );
    if (response.statusCode == 200) {
      drinks = jsonDecode(response.body) as List<dynamic>;
      print(drinks);
      print('send');
    } else {
      print('error ${response.statusCode}');
    }
  } catch (error) {
    print('send error : $error');
  }
}