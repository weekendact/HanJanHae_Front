import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/RecipePage.dart';

class RecipepageTest extends StatefulWidget {
  const RecipepageTest({super.key});

  @override
  State<RecipepageTest> createState() => _RecipePageState();
}

class Cocktail {
  final String name;
  final String description;

  Cocktail({required this.name, required this.description});

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      name: json['name'],
      description: json['description'],
    );
  }
}

class Services {
  static String url = "";
  static Future<void> sendCocktailInfoToDatabase(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var entries = jsonDecode(response.body) as List<dynamic>;
      } else {
        // 서버 에러 처리
        print('Request failed with status: ${response.statusCode}.');
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      // 네트워크 에러 처리
      print('An error occurred: $e');
    }
  }
}

class _RecipePageState extends State<RecipepageTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void loadcocktail() async {
    final cocktails = await Services.sendCocktailInfoToDatabase(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: recipepage(),
    );
  }
}
