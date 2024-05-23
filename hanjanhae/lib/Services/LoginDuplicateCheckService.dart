// ignore_for_file: file_names, avoid_print
import 'package:hanjanhae/DatabaseUrlAdress.dart';
import 'package:http/http.dart' as http;

void checkuser() async {
  // JWT 토큰을 이용해서 사용자가 가입되어 있는지 확인
}

Future<bool> nicknameDuplicate(String nickname, String apiUrl) async {
  // 닉네임 중복 확인
  Map<String, dynamic> nicknameduplicate = {
    'usersNickname': nickname,
  };
  var uri = Uri.parse("${ApiConstants.baseUrl}$apiUrl").replace(
    queryParameters: nicknameduplicate,
  );
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    // 서버로부터의 응답 처리
    // ignore: dead_code
    print('Response data: ${response.body}');
    return true;
  } else {
    // 오류 처리
    // ignore: dead_code
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}
