// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/HomePage.dart';
import 'package:hanjanhae/pages/MyPage.dart';
import 'package:hanjanhae/pages/PostingPage.dart';
import 'package:hanjanhae/pages/RecipePage.dart';

int current = 0;
Color iconColor = Colors.grey;
int likes1 = 0; //좋아요버튼 1
int likes2 = 0; //좋아요버튼 2
int likes3 = 0; //좋아요버튼 3
int likes4 = 0; //좋아요버튼 4
int likes5 = 0; //좋아요버튼 5
Color iconColor1 = Colors.grey; //좋아요버튼 초기값 색1
Color iconColor2 = Colors.grey; //좋아요버튼 초기값 색2
Color iconColor3 = Colors.grey; //좋아요버튼 초기값 색3
Color iconColor4 = Colors.grey; //좋아요버튼 초기값 색4
Color iconColor5 = Colors.grey; //좋아요버튼 초기값 색5
List imageList = [ // 메인 페이지 상단 사진
  "assets/cocktail.jpeg",
  "assets/cocktail1.jpg",
  "assets/cocktail2.jpg",
  "assets/cocktail3.jpg",
  "assets/cocktail.jpeg",
];

String? selectedChoiceGender; // 성별
int logInDetailAge = 0; // 나이

String? nicknameErrorText; // 닉네임 에러 텍스트
String? genderErrorText; // 성별 에러 텍스트
String? ageErrorText; // 나이 에러 텍스트

GlobalKey<FormState> logInDetailFormkey = GlobalKey<FormState>();  // 로그인 정보 페이지 폼키
TextEditingController nicknameController = TextEditingController(); // 로그인 정보 닉네임
TextEditingController ageController = TextEditingController(); // 로그인 정보 나이

enum LoginPlatform { // 로그인 플랫폼 리스트
  kakao,
  google,
  naver,
  none,
}

LoginPlatform loginPlatform = LoginPlatform.none; // 로그인 플랫폼 초기화

List<Widget> pages = [
    // 바텀 버튼 페이지 리스트
    const HomePage(key: ValueKey("homepage")),
    const RecipePage(key: ValueKey("recipepage")),
    const PostingPage(key: ValueKey("postingpage")),
    const MyPage(key: ValueKey("mypage")),
  ];
  int currentIndex = 0;
  

List<dynamic> drinks = <dynamic>[];