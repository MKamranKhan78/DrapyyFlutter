
// Current Orders Fragment
import 'package:drapyy/helper/colors.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class CurrentOrdersFragment extends StatelessWidget {
  const CurrentOrdersFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          _buildOrderItem(
            orderId: 'ORDER ID# 52',
            trackingNumber: 'DRPY7MRT000052',
            productName: 'VARSITY JACKET dhfhdkhf nkj hdfn jghdfdffd hdhfjkdhfjdhfjdjfjh fjdhfjk ',
            quantity: 'Qty 1',
            status: 'Pending',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String orderId,
    required String trackingNumber,
    required String productName,
    required String quantity,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID and Tracking Number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                trackingNumber,
                style: TextStyle(
                  fontFamily: FontConstants.gothamPro,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Product Name

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              Image.asset(
                Drawables.demo_product,
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),

              const SizedBox(width: 10),

              // Product details (Name + Row of Qty & Status)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      productName,
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Qty and Status in the same Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          quantity,
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // no fill color
                            border: Border.all(color: Colors.black, width: 1), // black border
                            borderRadius: BorderRadius.circular(0), // cube-like (slight rounding optional)
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black, // black text
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(height: 20,),
          Container(height: 1,color: black_color,),
        ],
      ),
    );
  }
}