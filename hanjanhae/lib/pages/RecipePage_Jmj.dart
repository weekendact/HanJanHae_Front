import 'dart:convert';
import 'package:hanjanhae/pages/RecipePageTest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/RecipePage.dart';

class RecipepageTest extends StatefulWidget {
  const RecipepageTest({super.key});

  @override
  State<RecipepageTest> createState() => _RecipePageState();
}

class Liqur {
  final String cocktailPicture;
  late final String cocktailName;

  Liqur({required this.cocktailPicture, required this.cocktailName});

  factory Liqur.fromJson(Map<String, dynamic> json) {
    return Liqur(
        cocktailPicture: json['cocktailPicture'],
        cocktailName: json['cocktailName']);
  }
}

class _RecipePageState extends State<RecipepageTest> {
  List<Liqur> _liqurList = [];
  @override
  void initState() {
    super.initState();
    sendLiqurInfoToDatabase();
    fetchLiqurData();
  }

  String url = "";
  Future<List<Liqur>> sendLiqurInfoToDatabase() async {
    List<Liqur> list = [];
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonlist = jsonDecode(response.body);
        for (var json in jsonlist) {
          list.add(Liqur.fromJson(json));
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    return list;
  }

  Future<void> fetchLiqurData() async {
    List<Liqur> liqurList = await sendLiqurInfoToDatabase();
    setState(() {
      _liqurList = liqurList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Liqur>>(
      future: sendLiqurInfoToDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return recipepaget(liqurList: _liqurList);
        }
      },
    );
  }
}
