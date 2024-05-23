Future<void> LoginTokenToServer(String token) async {
  final url = 'https://your-backend-server.com/auth/kakao'; // 실제 서버 URL로 변경
  try {
    var http;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('서버에 토큰 전송 성공');
    } else {
      print('서버에 토큰 전송 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('서버에 토큰 전송 중 오류 발생: $e');
  }
}
