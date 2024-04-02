import 'dart:convert';
import 'package:http/http.dart' as http;

void sendDataToDatabase(dynamic Info, String apiUrl) async {
    // 유저 정보 데이터베이스 전송 함수
    Map<String, dynamic> Body = {
      'Info': Info,
    };
    String jsonBody = json.encode(Body); // json 형식으로 변환

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonBody);
      if (response.statusCode == 200) {
        print('send');
      } else {
        print('error ${response.statusCode}');
      }
    } catch (error) {
      print('send error : $error');
    }
  }

void sendTokenToDatabase(String token, String apiUrl)  async {
  // Access Token 데이터베이스 전송
  Map<String, dynamic> tokenValue = {
    'token' : token,
  };
  String jsontoken = json.encode(tokenValue);

  try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsontoken);
      if (response.statusCode == 200) {
        print('send');
      } else {
        print('error ${response.statusCode}');
      }
    } catch (error) {
      print('send error : $error');
    }
}