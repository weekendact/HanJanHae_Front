import 'package:flutter/material.dart';
import 'package:hanjanhae/service/RecipePageApi.dart';

class recipepage extends StatefulWidget {
  const recipepage({Key? key}) : super(key: key);

  @override
  State<recipepage> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage> {
  int _selectedIndex = -1; // 선택된 카드의 인덱스를 저장하는 변수
  Future<List<CocktailDetails>>? _cocktailDetails;

  void _onCardTap(int index, int drinkType) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? -1 : index;
      if (_selectedIndex != -1) {
        _cocktailDetails = fetchCocktailDetails(drinkType);
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
                      context, 'assets/alcohol_icon/liqueur.png', "리큐르", 0, 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/rum.png', "럼", 1, 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/vodka.png', "보드카", 2, 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/tequila.png', "데킬라", 3, 4),
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/gin.png', "진", 4, 5),
                  _buildAlcoholTypeCard(
                      context, 'assets/alcohol_icon/whiskey.png', "위스키", 5, 6),
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
                  return Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final cocktail = snapshot.data![index];
                        return _buildBox(
                            cocktail.cocktailName, cocktail.cocktailPicture);
                      },
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBox(String name, String picture) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            picture,
            height: 110,
            width: 110,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                width: 120,
                color: Colors.grey,
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 45,
          // left: 0,
          // right: 0,
          child: Container(
            width: 120,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
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
