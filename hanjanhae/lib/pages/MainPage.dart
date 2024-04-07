// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/HomePage.dart';
import 'package:hanjanhae/pages/MyPage.dart';
import 'package:hanjanhae/pages/PostingPage.dart';
import 'package:hanjanhae/pages/RecipePage.dart';

class MainpPage extends StatefulWidget {
  const MainpPage({super.key});

  @override
  State<MainpPage> createState() => _MainpPageState();
}

class _MainpPageState extends State<MainpPage> {
  List<Widget> pages = [
    // 바텀 버튼 페이지 리스트
    const HomePage(key: ValueKey("homepage")),
    const RecipePage(key: ValueKey("recipepage")),
    const PostingPage(key: ValueKey("postingpage")),
    const MyPage(key: ValueKey("mypage")),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: pages[currentIndex], // currentIndex
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            key: ValueKey("homepage"),
          ),
          BottomNavigationBarItem(
            label: "Recipe",
            icon: Icon(Icons.book),
            key: ValueKey("recipepage"),
          ),
          BottomNavigationBarItem(
            label: "Post",
            icon: Icon(Icons.chat),
            key: ValueKey("postingpage"),
          ),
          BottomNavigationBarItem(
            label: "MyPage",
            icon: Icon(Icons.account_circle),
            key: ValueKey("mypage"),
          ),
        ],
      ),
    );
  }
}
