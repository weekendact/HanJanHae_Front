import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanjanhae/pages/SettingPage.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const settingspage(),
                ),
              );
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
                  // style: TextButton.styleFrom(foregroundColor: Colors.black,),
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
              onPressed: () {
                /*
                  좋아요 목록 페이지
                 */
              },
              // style: TextButton.styleFrom(
              //   foregroundColor: Colors.black,
              // ),
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
              onPressed: () {
                /*
                  작성한 글 페이지
                 */
              },
              // style: TextButton.styleFrom(
              //   foregroundColor: Colors.black,
              // ),
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
              onPressed: () {
                /*
                  시청 목록 페이지
                 */
              },
              // style: TextButton.styleFrom(
              //   foregroundColor: Colors.black,
              // ),
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
            const Expanded(
                child: Center(
              child: null,
            )),
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
              padding: EdgeInsets.only(bottom: 80.0),
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
