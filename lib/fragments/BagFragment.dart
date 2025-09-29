import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';
import 'CartScreen.dart';
import 'WishlistScreen.dart';

class BagFragment extends StatefulWidget {
  const BagFragment({super.key});

  @override
  State<BagFragment> createState() => _BagFragmentState();
}


class _BagFragmentState extends State<BagFragment> {
  int _selectedIndex = 0; // 0 = Cart, 1 = Wishlist

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Column(
          children: [
            const SizedBox(height: 40),

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
          color: Colors.white, // always white background
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 14,
            fontWeight:  FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
