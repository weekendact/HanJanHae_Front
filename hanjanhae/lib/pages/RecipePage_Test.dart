import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hanjanhae/service/database_helper.dart';

class recipepage_test extends StatefulWidget {
  const recipepage_test({Key? key}) : super(key: key);

  @override
  State<recipepage_test> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage_test> {
  int _selectedIndex = -1;
  List<Map<String, dynamic>> cocktails = [];

  @override
  void initState() {
    super.initState();
    _fetchCocktailsFromDatabase();
  }

  Future<void> _fetchCocktailsFromDatabase() async {
    final db = databasehelper();
    final data = await db.getCocktails();
    setState(() {
      cocktails = data;
    });
  }

  Future<void> sendCocktailInfoToDatabase(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse("http://yourserver.com/api/cocktails"), // 실제 서버의 엔드포인트 URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final entries = jsonDecode(response.body) as List<dynamic>;
        final db = databasehelper();

        for (var entry in entries) {
          await db.insertCocktail(entry['imageAsset'], entry['cocktailName']);
        }

        _fetchCocktailsFromDatabase();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cocktails.length,
                itemBuilder: (context, index) {
                  return _buildAlcoholTypeCard(
                      context,
                      cocktails[index]['imageAsset'],
                      cocktails[index]['cocktailName'],
                      index);
                },
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
          if (_selectedIndex != -1) ...[
            _buildBox(470, 20),
            _buildBox(470, 150),
            _buildBox(470, 280),
            _buildBox(335, 20),
            _buildBox(335, 150),
            _buildBox(335, 280),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendCocktailInfoToDatabase(context),
        child: const Icon(Icons.refresh),
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
            if (_selectedIndex == -1) {
              _selectedIndex = (bottom == 315) ? 0 : 1;
            }
          });
        },
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _selectedIndex == (bottom == 315)
                  ? Colors.blue
                  : Colors.transparent,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlcoholTypeCard(
      BuildContext context, String imageAsset, String cocktailName, int index) {
    bool isSelected = _selectedIndex == index;

    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () {
          setState(() {
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
