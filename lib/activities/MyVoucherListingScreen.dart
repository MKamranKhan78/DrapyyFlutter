import 'package:drapyy/activities/AddAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/FontsConstants.dart';

class MyVoucherListingScreen extends StatefulWidget {
  const MyVoucherListingScreen({super.key});

  @override
  State<MyVoucherListingScreen> createState() => _MyVoucherListingScreenState();
}

class _MyVoucherListingScreenState extends State<MyVoucherListingScreen> {
  final List<String> addresses = [
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
    "User promocode sample",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 👈 keeps content below status bar
        child: Column(
          children: [
            // Back arrow with left padding
            Row(
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),

                // Expanded makes the Text take remaining space and stay centered
                Expanded(
                  child: Center(
                    child: Text(
                      "MY VOUCHERS", // 👈 your text here
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // To balance Row (so title stays centered even with only one button)
                const SizedBox(width: 48), // same width as IconButton
              ],
            ),

            Container(height: 20,),


            // ListView below
            Expanded(
              child: ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey.shade400),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                addresses[index],
                                style: const TextStyle(
                                  fontFamily: FontConstants.gothamPro,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "test44553",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
