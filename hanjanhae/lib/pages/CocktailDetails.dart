import 'package:flutter/material.dart';

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
