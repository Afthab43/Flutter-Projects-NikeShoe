import 'package:brand_app/model/shoe.model.dart';
import 'package:flutter/material.dart';

final List<ShoeModel> dummyData = [
  ShoeModel(
    id: '1',
    name: 'NIKE AIR MAX 200',
    price: 240.0,
    tag: 'Trending Now',
    imageUrl: 'assets/images/nike_air_max_200.png',
    colors: ['orange', 'blue', 'black'],
    sizes: ['US 6', 'US 7', 'US 8', 'US 9'],
    rating: 4.5,
    description:
        'Inspired by the energy flows on Earth, as lava flows and the rhythm of waves.',
    modelColor: Colors.orange,
  ),
  ShoeModel(
    id: '2',
    name: 'Nike Air Max 97',
    price: 190.0,
    tag: 'Best Selling',
    imageUrl: 'assets/images/nike_air_max_97.png',
    colors: ['black', 'yellow', 'red'],
    sizes: ['US 6', 'US 7', 'US 8'],
    rating: 4.7,
    description:
        'Nike Air Max 97 brings a sleek look inspired by Japanese bullet trains.',
    modelColor: Colors.black,
  ),
  ShoeModel(
    id: '3',
    name: 'Nike Air Max 260',
    price: 220.0,
    tag: 'Top Rated',
    imageUrl: 'assets/images/nike_air_max_260.png',
    colors: ['green', 'orange', 'white'],
    sizes: ['US 7', 'US 8', 'US 9'],
    rating: 4.8,
    description:
        'Comfort and style meet in this high-performance shoe made for all-day wear.',
    modelColor: Colors.green,
  ),
];

final List<Map<String, String>> categories = [
  {'id': '0', 'name': 'All', 'imageUrl': 'assets/icons/search.png'},
  {'id': '1', 'name': 'Sneakers', 'imageUrl': 'assets/icons/search.png'},
  {'id': '2', 'name': 'Watch', 'imageUrl': 'assets/icons/search.png'},
  {'id': '3', 'name': 'Jacket', 'imageUrl': 'assets/icons/search.png'},
];

List<ShoeModel> itemsOnCart = [];
