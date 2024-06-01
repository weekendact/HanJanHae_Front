import 'package:flutter/material.dart';

void main() {
  runApp(const communitypage());
}

class communitypage extends StatelessWidget {
  const communitypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            CommunityItem(),
          ],
        ),
      ),
    );
  }
}

class CommunityItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 338,
          height: 80,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/req/cocktail.jpeg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Positioned(
                left: 132,
                top: 20,
                child: SizedBox(
                  width: 69,
                  height: 14,
                  child: Text(
                    '칵이름',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Jalnan',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 132,
                top: 50,
                child: SizedBox(
                  width: 116,
                  height: 8,
                  child: Text(
                    '설명 설명 설명 설명',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      fontFamily: 'Jalnan',
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 24,
                child: Container(
                  width: 62,
                  height: 32,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 62,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: 11,
                        child: SizedBox(
                          width: 25,
                          height: 14,
                          child: Text(
                            '10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Jalnan',
                              fontWeight: FontWeight.w400,
                              height: 0.15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
