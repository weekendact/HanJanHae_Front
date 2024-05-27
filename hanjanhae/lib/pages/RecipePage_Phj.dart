import 'package:flutter/material.dart';
import 'package:hanjanhae/service/Database_Helper.dart';

class recipepage_phj extends StatefulWidget {
  const recipepage_phj({Key? key}) : super(key: key);

  @override
  State<recipepage_phj> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage_phj> {
  int _selectedIndex = -1;
  List<String> _recipeDetails = [];
  List<String> _imageUrls = [];
  String _cocktailName = ''; // 칵테일 이름 저장 변수
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadRecipeDetails(int id) async {
    try {
      Map<String, dynamic> recipeDetails =
          await _dbHelper.fetchRecipeDetails(id);
      setState(() {
        _recipeDetails = [];
        _imageUrls = [];
        _cocktailName =
            recipeDetails['cocktail_name'] ?? 'Unknown Cocktail'; // 칵테일 이름 저장
        recipeDetails.forEach((key, value) {
          if (key != 'cocktail_name') {
            _recipeDetails.add(value.toString() ?? 'No details available');
            _imageUrls.add(value['image_url'] ?? '');
          }
        });
      });
    } catch (e) {
      print('Failed to load recipe details: $e');
    }
  }

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33FFFFFF),
                  Color(0x33D8B4B4),
                  Color(0x33FFFFFF),
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
                      context, 'assets/alcohol_icon/tequila.png', "리큐르", 0, 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "럼", 1, 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "보드카", 2, 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "데낄라", 3, 4),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "진", 4, 5),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "위스키", 5, 6),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "무알콜", 6, 7),
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
          if (_selectedIndex != -1 && _recipeDetails.isNotEmpty)
            ..._buildDynamicBoxes(_recipeDetails),
        ],
      ),
    );
  }

  List<Widget> _buildDynamicBoxes(List<String> details) {
    List<Widget> boxes = [];
    double bottom = 470;
    double left = 20;

    for (int i = 0; i < details.length; i++) {
      String? imageUrl = _imageUrls.isNotEmpty ? _imageUrls[i] : '';
      imageUrl = imageUrl.isNotEmpty
          ? imageUrl
          : 'No Image Available'; // 이미지 URL이 빈 문자열인 경우 'No Image Available'로 설정
      boxes.add(_buildBox(bottom, left, details[i] ?? 'No details available',
          imageUrl, _cocktailName));
      left += 130;
      if (left + 110 > MediaQuery.of(context).size.width) {
        left = 20;
        bottom -= 140;
      }
    }

    return boxes;
  }

  Widget _buildBox(double bottom, double left, String content, String imageUrl,
      String cocktailName) {
    // 칵테일 이름 추가
    return Positioned(
      bottom: bottom,
      left: left,
      child: SizedBox(
        width: 110,
        height: 150, // 이미지와 텍스트를 포함한 전체 높이
        child: Stack(
          children: [
            // 이미지 또는 텍스트
            if (imageUrl.isNotEmpty)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Image.network(imageUrl),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // 둥근 모서리
                  child: SizedBox(
                    width: 110,
                    height: 110, // 이미지의 높이
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  content,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            // 텍스트를 감싸는 컨테이너
            Positioned(
              bottom: 0,
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
                    cocktailName, // 데이터베이스에서 받아온 칵테일 이름
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

  Widget _buildAlcoholTypeCard(BuildContext context, String imageAsset,
      String cocktailName, int index, int id) {
    bool isSelected = _selectedIndex == index;

    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _selectedIndex = _selectedIndex == index ? -1 : index;
          });
          if (_selectedIndex == index) {
            await _loadRecipeDetails(id);
          } else {
            setState(() {
              _recipeDetails = [];
            });
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
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
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
