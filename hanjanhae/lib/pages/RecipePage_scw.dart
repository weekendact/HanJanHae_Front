import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hanjanhae/pages/CocktailDetails.dart';

class recipepage_scw extends StatefulWidget {
  const recipepage_scw({Key? key}) : super(key: key);

  @override
  State<recipepage_scw> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage_scw> {
  int _selectedIndex = -1; // 선택된 카드의 인덱스를 저장하는 변수
  Future<List<CocktailDetails>>? _cocktailDetails;

  Future<List<CocktailDetails>> fetch(int drinkType) async {
    final String URL = "http://10.200.73.254:8080/drink/cocktails/search";
    final request = Uri.parse(URL);
    final Map<String, dynamic> requestBody = {"drinkType": drinkType};

    final response = await http.post(
      request,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final String responseBodyString = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseBody = jsonDecode(responseBodyString);
      final List<dynamic> cocktails = responseBody['result']['result'];
      return cocktails
          .map<CocktailDetails>((json) => CocktailDetails.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load cocktails");
    }
  }

  void _onCardTap(int index, int drinkType) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? -1 : index;
      if (_selectedIndex != -1) {
        _cocktailDetails = fetch(drinkType);
      } else {
        _cocktailDetails = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe'),
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
                      context, 'assets/alcohol_icon/tequila.png', "리큐르", 0, 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "럼", 1, 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "보드카", 2, 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "데킬라", 3, 4),
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
          if (_selectedIndex != -1)
            FutureBuilder<List<CocktailDetails>>(
              future: _cocktailDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return _buildCocktailList(snapshot.data!);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCocktailList(List<CocktailDetails> cocktails) {
    return ListView.builder(
      itemCount: cocktails.length,
      itemBuilder: (context, index) {
        final cocktail = cocktails[index];
        return _buildBox(cocktail.cocktailName, cocktail.cocktailPicture);
      },
    );
  }

  Widget _buildBox(String name, String picture) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            picture,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Text(name),
        ],
      ),
    );
  }

  Widget _buildAlcoholTypeCard(BuildContext context, String imageAsset,
      String cocktailName, int index, int drinkType) {
    bool isSelected = _selectedIndex == index; // 현재 카드가 선택된 상태인지 확인

    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () => _onCardTap(index, drinkType),
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
