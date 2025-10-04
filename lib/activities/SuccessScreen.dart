

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class SuccessScreen extends StatelessWidget {

  SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ✅ Green Check Icon in Circle
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 50,
              ),
            ),

            const SizedBox(height: 24),

            // SUCCESSFUL Text
            Text(
              "SUCCESSFUL!",
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro, // 👈 your font
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              "YOU SUCCESSFULLY REDEEMED",
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 4),

            // Points
            Text(
              "77 Points!",
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // sharp rectangle
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

