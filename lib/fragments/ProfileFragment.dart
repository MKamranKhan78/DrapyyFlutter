
import 'package:drapyy/activities/AccountInformationScreen.dart';
import 'package:drapyy/activities/BecomePartnerScreen.dart';
import 'package:drapyy/activities/RedeemScreen.dart';
import 'package:drapyy/helper/FontsConstants.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../activities/AddressListScreen.dart';
import '../helper/NavigationHelper.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Profile Image
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 50),
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
                children: const [
                  // WALLET
                  Column(
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
                  Column(
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
                  Column(
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

                  // FOLLOWING
                  Column(
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

              }),
              buildMenuRow("VOCHERS", () {
                print("VOCHERS Clicked");
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



  Widget _buildSocialMediaSection() {
    return Column(
      children: [
        _buildClickableSocialMediaItem('INSTAGRAM', 'https://instagram.com/yourprofile'),
        _buildClickableSocialMediaItem('FACEBOOK', 'https://facebook.com/yourprofile'),
        _buildClickableSocialMediaItem('PINTEREST', 'https://pinterest.com/yourprofile'),
        _buildClickableSocialMediaItem('YOUTUBE', 'https://youtube.com/yourprofile'),
      ],
    );
  }

  Widget _buildLegalLinksSection() {
    return Column(
      children: [
        _buildClickableLegalLink('PRIVACY POLICY', '/privacy-policy'),
        _buildClickableLegalLink('TERMS OF USE', '/terms-of-use'),
      ],
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
}