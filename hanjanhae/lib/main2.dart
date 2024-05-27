import 'dart:convert';
import 'dart:io';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'package:hanjanhae/pages/CocktailDetails.dart';

void main() {
  final String URL = "http://10.200.73.254:8080/";
  final request = Uri.parse(URL + "drink/cocktails/search");

  fetch() async {
    // 요청 본문에 포함될 데이터를 정의합니다.
    final Map<String, dynamic> requestBody = {"drinkType": 3};

    final response = await http.post(
      request,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final String responseBodyString = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseBody = jsonDecode(responseBodyString);
      final List<dynamic> cocktails = responseBody['result']['result'];
      return cocktails
          .map<CocktailDetails>((json) => CocktailDetails.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load cocktails");
    }
  }

  test("API GET 테스트", () async {
    print("받아오는 중");
    await fetch().then((value) {
      for (var v in value) {
        v.printing();
      }
    }).catchError((error) => print("error: $error"));

    print("받아옴");
  });
}
