import 'package:drapyy/activities/ProductListingActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';



class MenuFragment extends StatefulWidget {
  const MenuFragment({super.key});

  @override
  State<MenuFragment> createState() => _MenuFragmentState();
}

class _MenuFragmentState extends State<MenuFragment> {
  // Static list of strings
  final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];

  final List<String> items2 = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 50),

          Center(
            child: Text(
              "MENU", // 👈 your text here
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Horizontal List
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${items[index]} clicked")),
                    );
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: FontConstants.gothamPro,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Vertical List
          Expanded( // 👈 important
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              itemCount: items2.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const ProductListingActivity());

                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      items2[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: FontConstants.gothamPro,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
