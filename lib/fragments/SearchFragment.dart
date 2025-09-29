import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center, // 👈 Center text & hint
            decoration: const InputDecoration(
              hintText: "WHAT ARE YOU LOOKING FOR ?",
              hintStyle: TextStyle(
                color: Colors.grey,       // 👈 hint color
                fontSize: 14,             // 👈 hint size
                fontWeight: FontWeight.w400,
                fontFamily: FontConstants.gothamPro,
                letterSpacing: 1.2,       // 👈 spacing for uppercase look
              ),
            ),
            style: TextStyle(
              color: Colors.black,       // 👈 text color
              fontSize: 16,              // 👈 entered text size
              fontWeight: FontWeight.w400,
              fontFamily: FontConstants.gothamPro,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),

    );
  }

}