import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';
import 'CartScreen.dart';
import 'WishlistScreen.dart';

class BagFragment extends StatefulWidget {
  //const BagFragment({super.key});
  final String isCart; // 👈 parameter to receive

  const BagFragment({super.key, required this.isCart});

  @override
  State<BagFragment> createState() => _BagFragmentState();
}

class _BagFragmentState extends State<BagFragment> {
  int _selectedIndex = 0; // 0 = Cart, 1 = Wishlist
  //String is_cart = "0"; // control variable

  @override
  void initState() {
    super.initState();
    // decide initial tab based on is_cart
    _selectedIndex = (widget.isCart == "1") ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Column(
          children: [
            const SizedBox(height: 80),

            // Custom Tabs with two boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTab("CART", 0),
                _buildTab("WISHLIST", 1),
              ],
            ),
          ],
        ),
      ),

      // Switch content manually
      body: _selectedIndex == 0
          ? const CartScreen()
          : const WishlistScreen(),
    );
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 150,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: isSelected ? Colors.black : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}