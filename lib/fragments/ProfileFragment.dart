
import 'dart:convert';

import 'package:drapyy/activities/AccountInformationScreen.dart';
import 'package:drapyy/activities/BecomePartnerScreen.dart';
import 'package:drapyy/activities/FilterScreen.dart';
import 'package:drapyy/activities/MyVoucherListingScreen.dart';
import 'package:drapyy/activities/NotificationsScreen.dart';
import 'package:drapyy/activities/PrivacyPolicyScreen.dart';
import 'package:drapyy/activities/RedeemScreen.dart';
import 'package:drapyy/activities/TermsAndConditionScreen.dart';
import 'package:drapyy/helper/FontsConstants.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../activities/AddressListScreen.dart';
import '../activities/MyOrdersScreen.dart';
import '../helper/NavigationHelper.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileFragment> {

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  const SizedBox(width: 48), // same width as IconButton

                  // Expanded makes the Text take remaining space and stay centered
                  Expanded(
                    child: Center(
                      child: Text(
                        "PROFILE", // 👈 your text here
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // Back button
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.black,size: 25,),
                    onPressed: () {
                      Get.to(() => NotificationsScreen());
                    },
                  ),

                  // To balance Row (so title stays centered even with only one button)
                ],
              ),

              // Profile Image
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 30),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Name
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "MAX CONVERSION",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tabs Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // WALLET
                  const Column(
                    children: [

                      Text(
                        "WALLET",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        "120", // value
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),

                  // POINTS
                  const Column(
                    children: [

                      Text(
                        "POINTS",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),


                      SizedBox(height: 5),

                      Text(
                        "80",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),

                  // ORDERS
                  InkWell(
                    onTap: (){

                      Get.to(() =>  Myordersscreen());

                    },
                    child: const Column(
                      children: [

                        Text(
                          "ORDERS",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "25",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),
                  ),

                  // FOLLOWING
                  const Column(
                    children: [

                      Text(
                        "FOLLOWING",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "10",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),


              const SizedBox(height: 20),

              const Divider(color: Colors.black, thickness: 0.5),

              // Menu Items (inline, no extra widget class)
              buildMenuRow("ACCOUNT INFORMATION", () {
                 Get.to(() => const AccountInformationScreen());
              }),
              buildMenuRow("DELIVERY ADDRESS", () {
                print("DELIVERY Clicked");
                Get.to(() => const AddressListScreen());

              }),
              buildMenuRow("WALLET", () {
                print("WALLET Clicked");
                Get.to(() => FilterScreen());

              }),
              buildMenuRow("VOCHERS", () {
                print("VOCHERS Clicked");

                Get.to(() => const MyVoucherListingScreen());

              }),
              buildMenuRow("REDEEM POINTS", () {
                print("REDEEM Clicked");
                Get.to(() => const RedeemScreen());
              }),
              buildMenuRow("PAYMENT METHODS", () {
                print("PAYMENT Clicked");
              }),
              buildMenuRow("BECOME PARTNER", () {
                print("PAYMENT Clicked");
                Get.to(() => const BecomePartnerScreen());
              }),
              buildMenuRow("SETTINGS", () {
                print("SETTINGS Clicked");
              }),
              buildMenuRow("HELPS FAQS", () {
                print("HELPS FAQS Clicked");
              }),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      "LOGOUT",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              Container(height: 30,),
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 40),
                    Image.asset(
                      Drawables.img_drappy_white,
                      width: 200,
                      height: 100,
                    ),

                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("INSTAGRAM clicked");
                            // 👉 Add navigation or link open here
                          },
                          child: Text(
                            "INSTAGRAM",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("FACEBOOK clicked");
                          },
                          child: Text(
                            "FACEBOOK",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("PINTEREST clicked");
                          },
                          child: Text(
                            "PINTEREST",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(height: 30),
                    InkWell(
                      onTap: () {
                        print("YOUTUBE clicked");
                      },
                      child: Text(
                        "YOUTUBE",
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Container(height: 30),
                    Container(width: 300, height: 1, color: Colors.grey),
                    Container(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("PRIVACY POLICY clicked");
                            Get.to(() => const Privacypolicyscreen());

                          },
                          child: Text(
                            "PRIVACY POLICY",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          "/",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("TERMS OF USE clicked");
                            Get.to(() => const Termsandconditionscreen());

                          },
                          child: Text(
                            "TERMS OF USE",
                            style: TextStyle(
                              fontFamily: FontConstants.gothamPro,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }





  Widget _buildClickableSocialMediaItem(String text, String url) {
    return GestureDetector(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClickableLegalLink(String text, String route) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective page
        // Navigator.pushNamed(context, route);

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: FontConstants.gothamPro,
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }


  Widget buildMenuRow(String title, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 0.5,
        ),
      ],
    );
  }



  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.logout);
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
      final model = GetNotificationsResponse.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          Get.snackbar(
            "Status ${model.status}",
            model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2),
          );
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Status ${model.status}",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
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