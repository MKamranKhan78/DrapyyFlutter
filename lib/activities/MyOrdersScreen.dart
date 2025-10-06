

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fragments/CurrentOrdersFragment.dart';
import '../fragments/HistoryOrdersFragment.dart';
import '../helper/FontsConstants.dart';

class Myordersscreen extends StatefulWidget {
  const Myordersscreen({super.key});

  @override
  State<Myordersscreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<Myordersscreen> {
  int _selectedIndex = 0; // 0 = Current, 1 = History

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              "MY ORDERS",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Container(height: 30,width: 30,)
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab("CURRENT", 0),
              _buildTab("HISTORY", 1),
            ],
          ),
        ),
      ),

      // Body based on tab selection
      body: _selectedIndex == 0
          ? const CurrentOrdersFragment()
          : const HistoryOrdersFragment(),
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
        width: 160,
        height: 40,
        margin: const EdgeInsets.symmetric( vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white ,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "GothamPro",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black ,
          ),
        ),
      ),
    );
  }
}




