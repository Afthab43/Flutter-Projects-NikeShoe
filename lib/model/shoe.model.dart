import 'package:flutter/material.dart';

class ShoeModel {
  final String id;
  final String name;
  final double price;
  final String tag;
  final String imageUrl;
  final List<String> colors;
  final List<String> sizes;
  final double rating;
  final String description;
  final Color modelColor;

  ShoeModel({
    required this.id,
    required this.name,
    required this.price,
    required this.tag,
    required this.imageUrl,
    required this.colors,
    required this.sizes,
    required this.rating,
    required this.description,
    required this.modelColor,
  });

  factory ShoeModel.fromJson(Map<String, dynamic> json) {
    return ShoeModel(
      id: json['id'].toString(),
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      tag: json['tag'],
      imageUrl: 'assets/images/${json['image']}', // adjust if needed
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'],
      modelColor:
          Colors.orange, // Placeholder, you can map color names to Color here
    );
  }

  static Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'black':
        return Colors.black;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'white':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }
}
