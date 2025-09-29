import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final List<Map<String, String>> redeemOptions = [
    {'points': '3000', 'currency': 'Rs.50'},
    {'points': '5500', 'currency': 'Rs.100'},
    {'points': '10000', 'currency': 'Rs.200'},
    {'points': '15000', 'currency': 'Rs.300'}, // Added extra option for grid demo
    {'points': '20000', 'currency': 'Rs.400'}, // Added extra option for grid demo
    {'points': '25000', 'currency': 'Rs.500'}, // Added extra option for grid demo
    {'points': '3000', 'currency': 'Rs.50'},
    {'points': '5500', 'currency': 'Rs.100'},
    {'points': '10000', 'currency': 'Rs.200'},
    {'points': '15000', 'currency': 'Rs.300'}, // Added extra option for grid demo
    {'points': '20000', 'currency': 'Rs.400'}, // Added extra option for grid demo
    {'points': '25000', 'currency': 'Rs.500'}, // Added extra option for grid demo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Back arrow (left aligned)
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      // Title centered horizontally
                      Expanded(
                        child: Center(
                          child: Text(
                            'REDEEM',
                            style: const TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),

                      // Spacer to balance the Row so text stays center
                      const SizedBox(width: 48), // same width as IconButton
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 10,),
                            Text(
                              'POINTS',
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            Text(
                              '345',
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: black_color,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                               },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Center(
                                  child: Text(
                                    'REDEEM',
                                    style: TextStyle(
                                      fontFamily: FontConstants.gothamPro,
                                      fontSize: 18, // Slightly smaller for grid layout
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Redeem Options Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                 child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 15, // Horizontal spacing between items
                    mainAxisSpacing: 15, // Vertical spacing between items
                   ),
                  itemCount: redeemOptions.length,
                  itemBuilder: (context, index) {
                    return _buildRedeemOption(
                      points: redeemOptions[index]['points']!,
                      currency: redeemOptions[index]['currency']!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedeemOption({
    required String points,
    required String currency,
  }) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
         border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Points Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                points,
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 20, // Slightly smaller for grid layout
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
               Text(
                'PTS',
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 12, // Slightly smaller for grid layout
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF888888),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "For",
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 14, // Slightly smaller for grid layout
                  fontWeight: FontWeight.w600,
                  color: grey_color,
                ),
              ),
              Container(width: 5,),
              Text(
                'Rs.50',
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 16, // Slightly smaller for grid layout
                  fontWeight: FontWeight.w600,
                  color: black_color,
                ),
              ),
            ],
          ),

          Container(height: 20,),

          // AVAIL Button
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
               ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    _handleAvailTap(points, currency);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Center(
                      child: Text(
                        'AVAIL',
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 12, // Slightly smaller for grid layout
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAvailTap(String points, String currency) {
    // Handle the avail button tap
    print('Avail tapped: $points points for $currency');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Redeeming $points points for $currency'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}