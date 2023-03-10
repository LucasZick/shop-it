import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String? description;
  final double? price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required String this.title,
    required String? this.description,
    required double? this.price,
    required String this.imageUrl,
    bool this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String? token, String? userId) async {
    _toggleFavorite();

    try {
      final String _baseUrl = '${Constants.baseApiUrl}/userFavorites';
      final response = await http.put(
        Uri.parse("$_baseUrl/$userId/$id.json?auth=$token"),
        body: json.encode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } on Exception catch (_) {
      _toggleFavorite();
    }
  }
}
