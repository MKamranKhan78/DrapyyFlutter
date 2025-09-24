

import 'package:drapyy/fragments/MenuFragment.dart';
import 'package:drapyy/fragments/ProfileFragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fragments/BagFragment.dart';
import '../fragments/HomeFragment.dart';
import '../fragments/SearchFragment.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<MainActivity> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MenuFragment(),
    BagFragment(),
    SearchScreen(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // keeps state of all fragments
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            final icons = [
              Icons.home,
              Icons.menu,
              Icons.shopping_cart,
              Icons.search,
              Icons.person,
            ];

            bool isSelected = _currentIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: isSelected ? 8 : 0), // 👆 move up
                child: Icon(
                  icons[index],
                  size: isSelected ? 30 : 26,
                  color: Colors.black,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}