import 'package:flutter/material.dart';
import 'package:hanjanhae/service/Database_Helper.dart';

class recipepage_phj extends StatefulWidget {
  const recipepage_phj({Key? key}) : super(key: key);

  @override
  State<recipepage_phj> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage_phj> {
  int _selectedIndex = -1;
  Map<String, dynamic>? _selectedRecipeDetails;
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
        _selectedRecipeDetails = recipeDetails;
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
                      context, 'assets/alcohol_icon/tequila.png', "데킬라", 0, 1),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일2", 1, 2),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일3", 2, 3),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일4", 3, 4),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일5", 4, 5),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일6", 5, 6),
                  _buildAlcoholTypeCard(
                      context, 'assets/req/cocktail1.jpg', "칵테일7", 6, 7),
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
          if (_selectedIndex != -1 && _selectedRecipeDetails != null) ...[
            _buildBox(470, 20, _selectedRecipeDetails!['ingredient1']),
            _buildBox(470, 150, _selectedRecipeDetails!['ingredient2']),
            _buildBox(470, 280, _selectedRecipeDetails!['ingredient3']),
            _buildBox(335, 20, _selectedRecipeDetails!['instruction1']),
            _buildBox(335, 150, _selectedRecipeDetails!['instruction2']),
            _buildBox(335, 280, _selectedRecipeDetails!['instruction3']),
          ],
        ],
      ),
    );
  }

  Widget _buildBox(double bottom, double left, String content) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: () {
          // 박스를 클릭했을 때 수행할 작업을 여기에 추가할 수 있습니다.
        },
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
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
              _selectedRecipeDetails = null;
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
}
