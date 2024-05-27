import 'package:flutter/material.dart';
import 'package:hanjanhae/service/Database_Helper.dart';

class recipepage_scw extends StatefulWidget {
  const recipepage_scw({Key? key}) : super(key: key);

  @override
  State<recipepage_scw> createState() => _RecipePageState();
}

class _RecipePageState extends State<recipepage_scw> {
  late Future<Map<String, dynamic>> _fetchCocktailInfoFuture;

  @override
  void initState() {
    super.initState();
    // 음료 정보 가져오는 Future를 초기화합니다.
    _fetchCocktailInfoFuture = fetchCocktailInfo();
  }

  Future<Map<String, dynamic>> fetchCocktailInfo() async {
    try {
      // 음료 정보를 가져오는 메서드 호출
      return DatabaseHelper().fetchCocktailNameAndPicture("your_drink_type");
    } catch (e) {
      // 에러 처리
      print("Error fetching cocktail info: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchCocktailInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            // 데이터가 정상적으로 가져와졌을 때 화면에 표시
            final cocktailName = snapshot.data?['name'] ?? "Unknown Cocktail";
            final cocktailPicture = snapshot.data?['picture'] ?? "";
            return _buildCocktailInfo(cocktailName, cocktailPicture);
          }
        },
      ),
    );
  }

  Widget _buildCocktailInfo(String cocktailName, String cocktailPicture) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cocktailName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Image.network(
            cocktailPicture,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
