
import 'package:drapyy/helper/FontsConstants.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                print("Account Information Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("DELIVERY ADDRESS", () {
                print("DELIVERY Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("WALLET", () {
                print("WALLET Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("VOCHERS", () {
                print("VOCHERS Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("REDEEM POINTS", () {
                print("REDEEM Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("PAYMENT METHODS", () {
                print("PAYMENT Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("BECOME PARTNER", () {
                print("PAYMENT Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("SETTINGS", () {
                print("SETTINGS Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
              }),
              buildMenuRow("HELPS FAQS", () {
                print("HELPS FAQS Clicked");
                // Navigate to another screen
                // NavigationHelper.moveToNewScreenAndPreviousSave(AccountScreen());
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

                    Container(height: 30,),
                    Image.asset(
                      Drawables.img_drappy_white,
                      width: 200,
                      height: 100,
                    ),


                    Container(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "INSTAGRAM",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "FACEBOOK",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "PINTEREST",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 20,),
                    Text(
                      "YOUTUBE",
                      style: const TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Container(height: 20,),

                    Container(width: 300,height: 1,color: Colors.grey,),

                    Container(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "PRIVACY POLICY",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "/",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "TERMS OF USE",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),


                  ],
                ),
              ),



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