import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:hanjanhae/pages/RecipePage_Jmj.dart';

class recipepaget extends StatefulWidget {
  final List<Liqur> liqurList;

  const recipepaget({
    super.key,
    required this.liqurList,
  });

  @override
  State<recipepaget> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepaget> {
  int _selectedLiqur = -1; // 선택된 카드의 인덱스를 저장하는 변수
  Map<int, ImageProvider?> selectedImages = {};

  @override
  Widget build(BuildContext context) {
    var snapshot;
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
                children: snapshot.data != null
                    ? List.generate(
                        snapshot.data!.length,
                        (index) => _buildAlcoholTypeCard(
                            context, widget.liqurList[index], index),
                      )
                    : [Container()],
                /*
                    [
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID1'), 0),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID2'), 1),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID3'), 2),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID1'), 3),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID1'), 4),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID1'), 5),
                  _buildAlcoholTypeCard(context,
                      Liqur(image: 'assets/req/cocktail.jpeg', id: 'ID1'), 6),                
                ],
                    */
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
          if (_selectedLiqur != -1) // 만약 카드가 선택되었으면 상자들을 보여줌
            ...[
            _buildBox(470, 20, 0),
            _buildBox(470, 150, 1),
            _buildBox(470, 280, 2),
            _buildBox(335, 20, 3),
            _buildBox(335, 150, 4),
            _buildBox(335, 280, 5),
          ],
        ],
      ),
    );
  }

  Widget _buildBox(double bottom, double left, int index) {
    bool isSelected =
        _selectedLiqur == (bottom == 315 ? 0 : 1); // 선택된 카드인지 여부 확인
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 선택된 카드가 없으면 선택 처리
            if (_selectedLiqur == -1) {
              _selectedLiqur = (bottom == 315) ? 0 : 1;
            }
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
                      image: selectedImages[index] ??
                          AssetImage(widget.liqurList[index].image),
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
                        widget.liqurList[index].id,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
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

  Widget _buildAlcoholTypeCard(BuildContext context, Liqur liqur, int index) {
    bool isSelected = _selectedLiqur == index; // 현재 카드가 선택된 상태인지 확인

    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            // 현재 선택된 카드를 다시 탭하면 선택 해제
            _selectedLiqur = isSelected == index ? -1 : index;
          });
          String imageUrl = liqur.image;
          String id = liqur.id;
          _updateSelectedData(imageUrl, id);
          try {
            final response = await http.post(Uri.parse(imageUrl));
            if (response.statusCode == 200) {
              setState(() {
                selectedImages[index] = MemoryImage(response.bodyBytes);
              });
            } else {
              print('Failed to load image data: ${response.statusCode}');
            }
          } catch (e) {
            print('Error loading image data: $e');
          }
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
                      image: selectedImages[index] ?? AssetImage(liqur.image),
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
                        liqur.id,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
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

  void _updateSelectedData(String imageUrl, String id) {
    setState(() {
      selectedImages[_selectedLiqur] = NetworkImage(imageUrl);
      widget.liqurList[_selectedLiqur].id = id;
    });
  }
}
