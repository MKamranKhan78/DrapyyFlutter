import 'dart:convert';

import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/FontsConstants.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

class RedeemScreen extends StatefulWidget {

  final String points;

  const RedeemScreen({super.key, required this.points});


  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {

  bool isLoading = false;

  List<AvailPointt> redeemList = [];

  @override
  void initState() {
    super.initState();
    getAvailablePoints();
  }

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
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            Text(
                              widget.points.toString(),
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 30,
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

            isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
                : redeemList.isEmpty
                ? Center(
              child: Column(
                children: [
                  Container(height: 50,),
                  Text(
                    "No Redeem list found",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )
                :
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 15, // Horizontal spacing between items
                    mainAxisSpacing: 15, // Vertical spacing between items
                  ),
                  itemCount: redeemList.length,
                  itemBuilder: (context, index) {
                    final item = redeemList[index];
                    return _buildRedeemOption(
                      points: item.points.toString(),
                      currency: item.amount.toString(),
                      onTap: () {
                        availPoints(item.points.toString(), item.amount.toString());
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRedeemOption({
    required String points,
    required String currency,
    VoidCallback? onTap, // 👈 Add this
  }) {
    return InkWell(
      onTap: onTap, // 👈 Handles item tap
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points text
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  points,
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'PTS',
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "For",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: grey_color,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Rs.$currency",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: black_color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // AVAIL button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      availPoints(points, currency);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: const Center(
                        child: Text(
                          'AVAIL',
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 12,
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
      ),
    );
  }





  Future<void> getAvailablePoints() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.avail_points_list);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };


    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = AvailPointsListResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
           if(model.data!.availPoints!.length > 0){
             redeemList.clear();
             redeemList.addAll(model.data!.availPoints as Iterable<AvailPointt>);
           }
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Redeem Points",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Redeem Points",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Redeem Points",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Redeem Points",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  Future<void> availPoints(
      String points,
      String amounts,
      ) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.avail_Points);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };



    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "points": points.toString(),
      "amounts": amounts.toString(),
    };

    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print('POST URL: $url');
      print('Request Headers: $headers');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print(
          "-------------------------------------FULL RESPONSE-------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print(
          "-------------------------------------------------------------------------------------");

      final model =
      BrandGetProductByBrand.fromJson(json.decode(response.body));

      if (model.status == 1) {
        Get.snackbar(
          "Redeem Points",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Redeem Points",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Redeem Points",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Redeem Points",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }












}