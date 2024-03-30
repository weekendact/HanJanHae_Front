import 'dart:convert';
import 'package:http/http.dart' as http;

void sendDataToDatebase(dynamic Info, String apiUrl) async {
    // 데이터베이스 이동 함수
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