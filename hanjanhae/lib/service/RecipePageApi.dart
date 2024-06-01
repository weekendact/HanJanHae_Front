import 'dart:convert';
import 'package:http/http.dart' as http;

class CocktailDetails {
  final String cocktailName;
  final String cocktailPicture;

  CocktailDetails({
    required this.cocktailName,
    required this.cocktailPicture,
  });

  factory CocktailDetails.fromJson(Map<String, dynamic> json) {
    return CocktailDetails(
      cocktailName: json["cocktailName"],
      cocktailPicture: json["cocktailPicture"],
    );
  }

  printing() {
    print(
        "cocktailName : ${this.cocktailName}, cocktailPicture : ${this.cocktailPicture}\n");
  }
}

Future<List<CocktailDetails>> fetchCocktailDetails(int drinkType) async {
  final String URL = "http://10.200.72.251:8080/drink/cocktails/search";
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
