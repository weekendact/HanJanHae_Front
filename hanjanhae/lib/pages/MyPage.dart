import 'package:flutter/material.dart';

class mypage extends StatefulWidget {
  const mypage({super.key});

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              /*
                설정 페이지 이동 구현 위치
               */
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100.0,
                ),
                TextButton(
                  onPressed: () {
                    /*
                      로그인 페이지 이동 구현 위치
                     */
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Row(
                    children: [
                      Text(
                        "로그인",
                        style: TextStyle(
                          fontSize: 30.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Row(
                children: [
                  Text("좋아요 목록"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Row(
                children: [
                  Text("내가 쓴 글"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Row(
                children: [
                  Text("시청 목록"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
