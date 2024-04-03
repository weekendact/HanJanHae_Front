import 'dart:convert';
import 'package:http/http.dart' as http;

void sendDataToDatabase(String id, String email, String apiUrl) async {
  // 유저 정보 데이터베이스 전송 함수
  Map<String, String> Body = {
    'usersSocialId': id,
    'usersEmail': email,
  };
  String jsonBody = json.encode(Body); // json 형식으로 변환

  try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody);

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 전송하였을 때의 처리
      print('Response body: ${response.body.toString()}');

      // 'content-type' 헤더 값 추출
      String contentType = response.headers['content-type'] ?? 'Unknown';
      print('Content-Type: $contentType');

      // 'X-Custom-Header' 헤더 값 추출
      String customHeaderValue =
          response.headers['x-custom-header'] ?? 'Not Provided';
      print('X-Custom-Header: $customHeaderValue');
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('An error occurred: $e');
  }
}

void sendTokenToDatabase(String token, String apiUrl) async { // 헤더에 보내는 형식으로 변경**
  // Token 데이터베이스 전송
  Map<String, dynamic> tokenValue = {
    'token': token,
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