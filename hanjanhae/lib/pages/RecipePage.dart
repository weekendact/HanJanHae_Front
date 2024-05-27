import 'package:flutter/material.dart';

class recipepage extends StatefulWidget {
  const recipepage({Key? key}) : super(key: key);

  @override
  State<recipepage> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage> {
  int _selectedIndex = -1; // 선택된 카드의 인덱스를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: const Text('Recipe'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33FFFFFF), // 흰색 (hex: 0x33FFFFFF, 20% 투명도)
                  Color(0x33D8B4B4), // 연한 분홍색 (hex: 0x33D8B4B4, 20% 투명도)
                  Color(0x33FFFFFF), // 흰색 (hex: 0x33FFFFFF, 20% 투명도)
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/tequila.png', "리큐르", 0),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "럼", 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "보드카", 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "데킬라", 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "진", 5),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "위스키", 6),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "무알콜", 7),
                ],
              ),
            ),
          ),
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: const Color(0xFFD9D9D9),
            ),
          ),
          if (_selectedIndex != -1) // 만약 카드가 선택되었으면 상자들을 보여줌
            ...[
            _buildBox(470, 20),
            _buildBox(470, 150),
            _buildBox(470, 280),
            _buildBox(335, 20),
            _buildBox(335, 150),
            _buildBox(335, 280),
          ],
        ],
      ),
    );
  }

  Widget _buildBox(double bottom, double left) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: SizedBox(
        width: 110,
        height: 150, // 이미지와 텍스트를 포함한 전체 높이
        child: Stack(
          children: [
            // 이미지
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // 둥근 모서리
                child: SizedBox(
                  width: 110,
                  height: 110, // 이미지의 높이
                  child: Image.asset(
                    'assets/req/cocktail.jpeg', // 여기에 이미지 경로 입력
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // 컨테이너
            Positioned(
              bottom: 40,
              left: 0,
              child: Container(
                width: 110, // 컨테이너의 너비
                height: 30, // 컨테이너의 높이
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    '칵이름',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlcoholTypeCard(
      BuildContext context, String imageAsset, String cocktailName, int index) {
    bool isSelected = _selectedIndex == index; // 현재 카드가 선택된 상태인지 확인

    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 현재 선택된 카드를 다시 탭하면 선택 해제
            _selectedIndex = _selectedIndex == index ? -1 : index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue
                          : Colors.transparent, // 선택된 카드일 때 파란색 테두리
                      width: 3,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      border: Border(
                        left: BorderSide(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 3,
                        ),
                        right: BorderSide(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 3,
                        ),
                        bottom: BorderSide(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cocktailName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
