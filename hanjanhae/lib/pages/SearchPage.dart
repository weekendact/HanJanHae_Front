import 'package:flutter/material.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SearchBar( // 검색 박스
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context); // 뒤로가기
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  trailing: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  elevation: const MaterialStatePropertyAll(2),
                  hintText: "검색어를 입력하세요.",
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                    child: Text(
                      "최근 검색어",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
