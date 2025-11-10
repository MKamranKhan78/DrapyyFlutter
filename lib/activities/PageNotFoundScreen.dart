

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class PageNotFoundScreen extends StatelessWidget {

  PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ✅ Green Check Icon in Circle
            Icon(
              Icons.accessibility_sharp,
              color: Colors.black,
              size: 70,
            ),

            const SizedBox(height: 10),

            // SUCCESSFUL Text
            Text(
              "PAGE NOT FOUND",
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro, // 👈 your font
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                textAlign: TextAlign.center, // ✅ Correct usage
                "WE CAN'T FIND THE PAGE YOU LOOKING FOR.",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

