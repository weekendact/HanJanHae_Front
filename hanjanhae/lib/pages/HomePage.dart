import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/SearchPage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: () async {
              setState(() {}); // 새로고침
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        'Hot',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        '인기 칵테일',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(
                          child: Center(
                        child: null,
                      )),
                      IconButton( // 검색 페이지 이동
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const searchpage(),));
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    height: 300,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: size.width,
                    height: 300,
                  ),
                  Container(
                    color: Colors.green,
                    width: size.width,
                    height: 300,
                  ),
                  Container(
                    color: Colors.blue,
                    width: size.width,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
