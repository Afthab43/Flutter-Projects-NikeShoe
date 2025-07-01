import 'package:brand_app/view/Screen/cartscreen.dart';
import 'package:brand_app/view/Screen/favoritescreen.dart';
import 'package:brand_app/view/Screen/searchscreen.dart';
import 'package:brand_app/view/view.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    FavoriteScreen(),
  ];

  void _onItemTapped(int index) {
    if (index >= 0 && index < 4) {
      // number of items
      setState(() {
        _selectedIndex = index;
      });
      // _pageController.jumpToPage(_selectedIndex);
      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
        // curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,

        physics: NeverScrollableScrollPhysics(),
        children: _screen,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 30.00,
        bubbleCurve: Curves.linear,
        selectedColor: const Color.fromARGB(255, 255, 115, 0),
        strokeColor: const Color.fromARGB(255, 255, 115, 0),
        unSelectedColor: const Color.fromARGB(255, 151, 151, 150),
        backgroundColor: Colors.white,
        // scaleFactor: 0.5,
        items: [
          CustomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            selectedIcon: Icon(CupertinoIcons.home),
          ),
          CustomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            selectedIcon: Icon(CupertinoIcons.search),
          ),

          CustomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            selectedIcon: Icon(CupertinoIcons.shopping_cart),
          ),
          CustomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            selectedIcon: Icon(CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }
}
