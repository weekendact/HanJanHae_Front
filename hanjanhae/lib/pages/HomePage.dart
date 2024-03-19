import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanjanhae/pages/SearchPage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int current = 0;
  Color iconColor = Colors.grey;
  final CarouselController _controller = CarouselController();
  List imageList = [
    "assets/cocktail.jpeg",
    "assets/cocktail.jpeg",
    "assets/cocktail.jpeg",
    "assets/cocktail.jpeg",
    "assets/cocktail.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                        )),
                        IconButton(
                          // 검색 페이지 이동
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const searchpage(),
                                ));
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    ///////////////////////////////////kwp//////////////////////////////
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: sliderWidget(),
                      ),
                    ),
                    ///////////////////////////////////phj//////////////////////////////
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "입문자들을 위한",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "칵테일 추천",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        // color: Colors.grey,
                        height: 170.0,
                        width: MediaQuery.of(context).size.width,
                        child: cocktailcard()),
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
                    ElevatedButton(
                      onPressed: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/cocktail.jpeg',
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
                          style: TextStyle(fontSize: 20),
                        ),
                        const Expanded(
                            child: Center(
                          child: null,
                        )),
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
                            )),
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

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(imgLink),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50.0,
                  child: hotcocktailname(),
                )
              ]);
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        onPageChanged: (index, reason) {
          setState(() {
            current = index;
          });
        },
      ),
    );
  }

  Widget hotcocktailname() {
    return Center(
      child: Stack(children: [
        SizedBox(
          width: 200,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '스카치블루',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      '부제목',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 120,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            width: 60,
            height: 30,
            child: Row(children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (iconColor == Colors.grey) {
                        iconColor = Colors.blue;
                      } else {
                        iconColor = Colors.grey;
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 15,
                        color: iconColor,
                      ),
                      const Expanded(
                          child: Center(
                        child: null,
                      )),
                      const Text(
                        '100',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
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
                      const SizedBox(height: 4),
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

  Widget cocktailcard() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일1"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일2"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일3"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일4"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일5"),
        _buildCocktailCard(context, 'assets/cocktail1.jpg', "칵테일6"),
      ],
    );
  }
}
