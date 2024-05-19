import 'package:flutter/material.dart';

class recipepage extends StatefulWidget {
  const recipepage({Key? key});

  @override
  State<recipepage> createState() => _recipepageState();
}

class _recipepageState extends State<recipepage> {
  int _selectedIndex = -1; // 선택된 카드의 인덱스를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //title: const Text('Recipe'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
            child: SizedBox(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/tequila.png', "데킬라", 0),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일2", 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일3", 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일4", 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일5", 5),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일6", 6),
                  _buildAlcoholTypeCard(
                      context, 'assets/cocktail1.jpg', "칵테일7", 7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 450,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xFFD9D9D9),
            ),
          ),
          if (_selectedIndex != -1) // 만약 카드가 선택되었으면 상자들을 보여줌
            ...[
            _buildBox(315, 20),
            _buildBox(315, 150),
            _buildBox(315, 280),
            _buildBox(185, 20),
            _buildBox(185, 150),
            _buildBox(185, 280),
          ],
        ],
      ),
    );
  }

  Widget _buildBox(double bottom, double left) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 선택된 카드가 없으면 선택 처리
            if (_selectedIndex == -1) {
              _selectedIndex = (bottom == 315) ? 0 : 1;
            }
          });
        },
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.blue, // 상자 색상
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _selectedIndex == (bottom == 315)
                  ? Colors.blue
                  : Colors.transparent, // 테두리 색상
              width: 3,
            ),
          ),
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
