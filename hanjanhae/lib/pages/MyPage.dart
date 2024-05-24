// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/SettingPage.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '닉네임',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextButton(
              onPressed: () {
                /*
                  좋아요 목록 페이지
                 */
              },
              child: const Row(
                children: [
                  Text("좋아요 목록"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                /*
                  작성한 글 페이지
                 */
              },
              child: const Row(
                children: [
                  Text("내가 쓴 글"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                /*
                  시청 목록 페이지
                 */
              },
              child: const Row(
                children: [
                  Text("시청 목록"),
                  Expanded(
                      child: Center(
                    child: null,
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: null,
              ),
            ),
            const Row(
              children: [
                Text(
                  '이용약관',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Flexible(
                  // 줄 바꿈
                  child: Text(
                    'dataadfsdfasdfsdjhkfhjfdfffsdfsfdsfsdsdfsdkhdfhkfhdhsjgfghjgjhhjgjhgjhgjhgjhgjhggasdfsfsfsjghghjghghjghjghjgfhshjfhsdhkjfhshfhsj',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 80.0,
              ),
              child: Text(
                'Version 0.0.0',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}