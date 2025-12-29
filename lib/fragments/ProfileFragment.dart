import 'dart:convert';
import 'dart:io';

import 'package:drapyy/activities/AccountInformationScreen.dart';
import 'package:drapyy/activities/BecomePartnerScreen.dart';
import 'package:drapyy/activities/ContactUsScreen.dart';
import 'package:drapyy/activities/FilterScreen.dart';
import 'package:drapyy/activities/MainActivity.dart';
import 'package:drapyy/activities/MyVoucherListingScreen.dart';
import 'package:drapyy/activities/NotificationsScreen.dart';
import 'package:drapyy/activities/PageNotFoundScreen.dart';
import 'package:drapyy/activities/PrivacyPolicyScreen.dart';
import 'package:drapyy/activities/RedeemScreen.dart';
import 'package:drapyy/activities/TermsAndConditionScreen.dart';
import 'package:drapyy/fragments/CurrentOrdersFragment.dart';
import 'package:drapyy/fragments/HomeFragment.dart';
import 'package:drapyy/helper/FontsConstants.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../activities/AddressListScreen.dart';
import '../activities/FollowingListScreen.dart';
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
  bool isFirstLoad = true;

  String wallet = "";
  String points = "";
  String orders = "";
  String following = "";
  String name = "";
  String image = "";
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path); // Update UI instantly
      });

      // Upload to server
      await updateProfile(_pickedImage!);
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: (isLoading && isFirstLoad)
            ? _buildShimmerEffect()
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Center(
                      child: Text(
                        "PROFILE",
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.white,size: 25,),
                    onPressed: () {
                      //Get.to(() => NotificationsScreen());
                    },
                  ),
                ],
              ),

              // Profile Image with shimmer
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30),
                child: GestureDetector(
                  onTap: _pickImage, // <--- Tap to select image
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: (isLoading && isFirstLoad)
                          ? Container(
                        color: Colors.grey.shade300,
                      )
                          : _pickedImage != null
                          ? Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        image.toString(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Name with shimmer
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: (isLoading && isFirstLoad)
                    ? Container(
                  width: 120,
                  height: 16,
                  color: Colors.grey.shade300,
                )
                    : Text(
                  toCamelCase(name.toString()),
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ),
              const SizedBox(height: 30),

              // Tabs Row with shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      (isLoading && isFirstLoad)
                          ? Container(
                        width: 40,
                        height: 14,
                        color: Colors.grey.shade300,
                      )
                          : Text(
                        wallet.toString(),
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
                      (isLoading && isFirstLoad)
                          ? Container(
                        width: 40,
                        height: 14,
                        color: Colors.grey.shade300,
                      )
                          : Text(
                        points.toString(),
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
                      if (!(isLoading && isFirstLoad)) {
                        Get.to(() =>  CurrentOrdersFragment());
                      }
                    },
                    child: Column(
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
                        (isLoading && isFirstLoad)
                            ? Container(
                          width: 40,
                          height: 14,
                          color: Colors.grey.shade300,
                        )
                            : Text(
                          orders.toString(),
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
                  InkWell(
                    onTap: (){
                      if (!(isLoading && isFirstLoad)) {
                        Get.to(FollowingListScreen());
                      }
                    },
                    child: Column(
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
                        (isLoading && isFirstLoad)
                            ? Container(
                          width: 40,
                          height: 14,
                          color: Colors.grey.shade300,
                        )
                            : Text(
                          following.toString(),
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.black, thickness: 0.5),

              // Menu Items with shimmer
              ..._buildMenuItemsWithShimmer(),

              const SizedBox(height: 30),

              // Logout Button with shimmer
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: (isLoading && isFirstLoad)
                      ? Container(
                    color: Colors.grey.shade300,
                  )
                      : ElevatedButton(
                    onPressed: () {
                      _showLogoutConfirmationDialog();
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

              Container(height: 30),
              // Footer section with shimmer
              (isLoading && isFirstLoad)
                  ? _buildFooterShimmer()
                  : Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 20),
                    Image.asset(
                      Drawables.new_drappy_image,
                      width: 250,
                      height: 250,
                    ),
                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("INSTAGRAM clicked");
                            print(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
                            _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_INSTAGRAM).toString());
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
                            print(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());
                            _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_FACEBOOK).toString());
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
                            print("YOUTUBE clicked");
                            _launchSocialLink(PreferenceManager.getString(NetworkManager.PREF_YOUTUBE).toString());
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
                      ],
                    ),
                    Container(height: 40),
                    Container(width: 300, height: 1, color: Colors.grey),
                    Container(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("PRIVACY POLICY clicked");
                            Get.to(Privacypolicyscreen());
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
                            Get.to(Termsandconditionscreen());
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

  String toCamelCase(String name) {
    if (name.isEmpty) return name;

    return name.split(" ").map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(" ");
  }


  // Shimmer effect widget
  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 20,),
          Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Center(
                  child: Container(
                    width: 100,
                    height: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
             /* Container(
                width: 25,
                height: 25,
                color: Colors.grey.shade300,
              ),*/
              const SizedBox(width: 16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              width: 120,
              height: 16,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => Column(
              children: [
                Container(
                  width: 50,
                  height: 14,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5),
                Container(
                  width: 40,
                  height: 14,
                  color: Colors.grey.shade300,
                ),
              ],
            )),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 0.5),
          ...List.generate(9, (index) => Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Container(
                  width: double.infinity,
                  height: 13,
                  color: Colors.grey.shade300,
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              ),
            ],
          )),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey.shade300,
            ),
          ),
          Container(height: 30),
          _buildFooterShimmer(),
        ],
      ),
    );
  }

  // Footer shimmer effect
  Widget _buildFooterShimmer() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 20),
          Container(
            width: 250,
            height: 250,
            color: Colors.grey.shade800,
          ),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) => Container(
              width: 80,
              height: 16,
              color: Colors.grey.shade700,
            )),
          ),
          Container(height: 40),
          Container(width: 300, height: 1, color: Colors.grey.shade800),
          Container(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 16,
                color: Colors.grey.shade700,
              ),
              Container(
                width: 10,
                height: 16,
                color: Colors.grey.shade700,
              ),
              Container(
                width: 100,
                height: 16,
                color: Colors.grey.shade700,
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // Build menu items with shimmer
  List<Widget> _buildMenuItemsWithShimmer() {
    List<String> menuItems = [
      "ACCOUNT INFORMATION",
      "NOTIFICATIONS",
      "DELIVERY ADDRESS",
      "WALLET            (Coming soon)",
      "VOCHERS",
      "REDEEM POINTS",
      "PAYMENT METHODS            (Coming soon)",
      "BECOME A PARTNER",
       "FAQS",
    ];

    List<Widget> widgets = [];
    for (int i = 0; i < menuItems.length; i++) {
      widgets.add(
        Column(
          children: [
            InkWell(
              onTap: (isLoading && isFirstLoad) ? null : () {
                _handleMenuTap(i);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: (isLoading && isFirstLoad)
                    ? Container(
                  width: double.infinity,
                  height: 13,
                  color: Colors.grey.shade300,
                )
                    : Text(
                  menuItems[i],
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
        ),
      );
    }
    return widgets;
  }

  // Handle menu tap
  void _handleMenuTap(int index) async {
    switch (index) {
      case 0: // ACCOUNT INFORMATION
        var result = await Get.to(() => AccountInformationScreen());
        if (result != null) {
          print("Received from B: $result");
          setState(() {
            getProfile();
          });
        }
        break;
      case 1: // DELIVERY ADDRESS
        Get.to(() => const NotificationsScreen());
        break;
      case 2: // DELIVERY ADDRESS
        Get.to(() => const AddressListScreen());
        break;
      case 3: // WALLET
         Get.to(() => PageNotFoundScreen());
        break;
      case 4: // VOCHERS
        Get.to(() => const MyVoucherListingScreen());
        break;
      case 5: // REDEEM POINTS
        Get.to(() => RedeemScreen(points: points.toString()));
        break;
      case 6: // PAYMENT METHODS
        Get.to(() => PageNotFoundScreen());
        break;
      case 7: // BECOME PARTNER
        Get.to(() => const BecomePartnerScreen());
        break;
      case 8: // HELPS FAQS
        Get.to(() => const ContactUsScreen());
        break;
    }
  }

  // Logout confirmation dialog
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          logout(); // Proceed with logout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchSocialLink(String url) async {
    Uri uri = Uri.parse(url);

    if (url.contains('facebook.com')) {
      final fbAppUrl = Uri.parse('fb://facewebmodal/f?href=$url');
      if (await canLaunchUrl(fbAppUrl)) {
        await launchUrl(fbAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    } else if (url.contains('instagram.com')) {
      final username = url.split('/').where((s) => s.isNotEmpty).last;
      final instaAppUrl = Uri.parse('instagram://user?username=$username');
      if (await canLaunchUrl(instaAppUrl)) {
        await launchUrl(instaAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    } else if (url.contains('youtube.com')) {
      final ytAppUrl = Uri.parse('youtube://$url');
      if (await canLaunchUrl(ytAppUrl)) {
        await launchUrl(ytAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildClickableSocialMediaItem(String text, String url) {
    return GestureDetector(
      onTap: (){},
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
      onTap: () {},
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
      final response = await client.post(
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
          PreferenceManager.clearAll();
          Get.offAll(MainActivity());
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Logout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Logout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Logout",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Logout",
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

  Future<void> getProfile() async {
    setState(() {
      isLoading = true;
      isFirstLoad = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.profile);
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
      final model = GetProfileResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          wallet = model.data!.wallet.toString();
          points = model.data!.points.toString();
          orders = model.data!.orders.toString();
          following = model.data!.following.toString();
          name = model.data!.user!.name.toString();
          image = model.data!.user!.image.toString();
          isFirstLoad = false;
        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        setState(() {
          isFirstLoad = false;
        });
      } else if (model.status == 401) {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        setState(() {
          isFirstLoad = false;
        });
      } else {
        Get.snackbar(
          "Profile",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        setState(() {
          isFirstLoad = false;
        });
      }
    } catch (e) {
      Get.snackbar(
        "Profile",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
      setState(() {
        isFirstLoad = false;
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> updateProfile(File img_file) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.updateImage);

    final request = http.MultipartRequest("POST", url);

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    });

    /// ---------------------------
    /// ADD MULTIPART IMAGE HERE
    /// ---------------------------

    request.files.add(
      await http.MultipartFile.fromPath(
        "image",       // <-- API parameter name
        img_file!.path,
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      final model = ApiResponseUpdateProfile.fromJson(json.decode(response.body));

      if (model.status == 1) {
        getProfile();
      } else {
        Get.snackbar(
          "Update",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("ERROR-------------------->"+e.toString());
      Get.snackbar(
        "Update",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
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