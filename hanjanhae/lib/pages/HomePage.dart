// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanjanhae/pages/AIChatPage.dart';
import 'package:hanjanhae/pages/SearchPage.dart';
import 'package:hanjanhae/service/Variable.dart';
import 'package:hanjanhae/service/userSecureStorageService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: () async {
              setState(() {}); // 새로고침
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Hot',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          '인기 칵테일',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: null,
                          ),
                        ),
                        IconButton(
                          // 검색 페이지 이동
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    ///////////////////////////////////kwp//////////////////////////////
                    const SizedBox(
                      height: 15.0,
                    ),
                    // Center(
                    //   child: SizedBox(
                    //     width: 300,
                    //     child: sliderWidget(),
                    //   ),
                    // ),
                    ///////////////////////////////////phj//////////////////////////////
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "입문자를 위한",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "칵테일 추천",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: const EdgeInsets.all(15.0),
                        )),
                      ],
                    ),
                    SizedBox(
                      // color: Colors.grey,
                      height: 170.0,
                      width: MediaQuery.of(context).size.width,
                      child: cocktailcard1(),
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "20대를 위한",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "칵테일 추천",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black,
                            margin: const EdgeInsets.all(15.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      // color: Colors.grey,
                      height: 170.0,
                      width: MediaQuery.of(context).size.width,
                      child: cocktailcard2(),
                    ),
                    ///////////////////////////////////cdh//////////////////////////////
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '오늘은 어떤걸',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '마실지 모르겠다면?',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'AI 한테 물어봐',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AIChaPpage(),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          Liqur[0][1],
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: 250.0,
                        ),
                      ),
                    ),
                    ///////////////////////////////////jmj//////////////////////////////
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          "커뮤니티",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: null,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "더보기",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget sliderWidget() {
  //   return CarouselSlider(
  //     carouselController: _controller,
  //     items: imageList.asMap().entries.map(
  //       (entry) {
  //         int index = entry.key;
  //         String imgLink = entry.value;
  //         return Builder(
  //           builder: (context) {
  //             return Stack(
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   child: SizedBox(
  //                     width: MediaQuery.of(context).size.width,
  //                     child: Image(
  //                       fit: BoxFit.cover,
  //                       image: AssetImage(imgLink),
  //                       height: 300,
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 170,
  //                   left: 53,
  //                   child: hotcocktailname(index),
  //                 )
  //               ],
  //             );
  //           },
  //         );
  //       },
  //     ).toList(),
  //     options: CarouselOptions(
  //       height: 250,
  //       viewportFraction: 1.0,
  //       autoPlay: true,
  //       autoPlayInterval: const Duration(seconds: 10),
  //       onPageChanged: (index, reason) {
  //         setState(() {
  //           current = index;
  //         });
  //       },
  //     ),
  //   );
  // }

  Widget hotcocktailname(int index) {
    String cocktailName = '';
    switch (index) {
      case 0:
        cocktailName = '스카치블루';

        break;
      case 1:
        cocktailName = '마티니';
        break;
      case 2:
        cocktailName = '모히또';
        break;
      case 3:
        cocktailName = '칵테일';
        break;
      case 4:
        cocktailName = '맥주';
        break;
    }

    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cocktailName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 20,
            child: goodbuttonlist(index),
          ),
        ],
      ),
    );
  }

  Widget goodbuttonlist(int index) {
    switch (index) {
      case 0:
        return goodbutton1(index);
      case 1:
        return goodbutton2(index);
      case 2:
        return goodbutton3(index);
      case 3:
        return goodbutton4(index);
      case 4:
        return goodbutton5(index);
      default:
        return Container();
    }
  }

  Widget goodbutton1(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      width: 60,
      height: 30,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (iconColor1 == Colors.grey) {
              iconColor1 = Colors.blue;
              likes1++;
            } else {
              iconColor1 = Colors.grey;
              likes1--;
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 14,
              color: iconColor1,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$likes1',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget goodbutton2(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      width: 60,
      height: 30,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (iconColor2 == Colors.grey) {
              iconColor2 = Colors.blue;
              likes2++;
            } else {
              iconColor2 = Colors.grey;
              likes2--;
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 14,
              color: iconColor2,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$likes2',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget goodbutton3(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      width: 60,
      height: 30,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (iconColor3 == Colors.grey) {
              iconColor3 = Colors.blue;
              likes3++;
            } else {
              iconColor3 = Colors.grey;
              likes3--;
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 14,
              color: iconColor3,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$likes3',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget goodbutton4(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      width: 60,
      height: 30,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (iconColor4 == Colors.grey) {
              iconColor4 = Colors.blue;
              likes4++;
            } else {
              iconColor4 = Colors.grey;
              likes4--;
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 14,
              color: iconColor4,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$likes4',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget goodbutton5(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      width: 60,
      height: 30,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (iconColor5 == Colors.grey) {
              iconColor5 = Colors.blue;
              likes5++;
            } else {
              iconColor5 = Colors.grey;
              likes5--;
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 14,
              color: iconColor5,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '$likes5',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCocktailCard(
      BuildContext context, String imageAsset, String cocktailName) {
    return SizedBox(
      width: 160,
      child: /* GestureDetector(
        onTap: () {
          print('$cocktailName 클릭.');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detail_page())); // 디테일 페이지로 이동
        }, */
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 140,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        cocktailName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        '(추천 받습니다)',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }

  Widget cocktailcard1() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일1"),
        _buildCocktailCard(context, 'assets/cocktail2.jpg', "칵테일2"),
        _buildCocktailCard(context, 'assets/cocktail3.jpg', "칵테일3"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일4"),
        _buildCocktailCard(context, 'assets/cocktail2.jpg', "칵테일5"),
        _buildCocktailCard(context, 'assets/cocktail3.jpg', "칵테일6"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일7"),
      ],
    );
  }

  Widget cocktailcard2() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildCocktailCard(context, 'assets/cocktail2.jpg', "칵테일1"),
        _buildCocktailCard(context, 'assets/cocktail3.jpg', "칵테일2"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일3"),
        _buildCocktailCard(context, 'assets/cocktail2.jpg', "칵테일4"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일5"),
        _buildCocktailCard(context, 'assets/cocktail2.jpg', "칵테일6"),
        _buildCocktailCard(context, 'assets/cocktail3.jpg', "칵테일7"),
      ],
    );
  }
}
