// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hanjanhae/service/Variable.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
