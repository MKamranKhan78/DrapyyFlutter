

import 'dart:convert';

import 'package:drapyy/fragments/MenuFragment.dart';
import 'package:drapyy/fragments/ProfileFragment.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:drapyy/models/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../fragments/BagFragment.dart';
import '../fragments/HomeFragment.dart';
import '../fragments/SearchFragment.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../network/Network.dart';
import 'LoginScreen.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<MainActivity> {
  int _currentIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    print("hjshjshddhhhh------>"+PreferenceManager.getString(NetworkManager.API_TOKEN).toString());
    if(PreferenceManager.getString(NetworkManager.API_TOKEN).toString().isEmpty || PreferenceManager.getString(NetworkManager.API_TOKEN) == null || PreferenceManager.getString(NetworkManager.API_TOKEN) == "null"){
      print("MAINACT------>");
      guestSignup("sdhfjdshfjhsd j fhdsjgf hsgdhfgshdghf gdshgf hsdg fsd");
    }else{
      getconfig();
    }
  }

  Future<void> guestSignup(String deviceToken) async {
    setState(() {
      isLoading = true;
    });
    final url =
    Uri.parse(NetworkManager.BASE_URL + NetworkManager.guest_api);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final requestBody = {
      "device_token": deviceToken.toString(),
    };
    final client = CustomHttpClient(http.Client());
    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print('POST URL: $url');
      print('Request Body: ${jsonEncode(requestBody)}');
      print('Response Code: ${response.statusCode}');
      print("-------------------------------------FULL RESPONSE------------------------------------------------");
      Toastutils.printFullText(response.body.toString());
      print("-------------------------------------------------------------------------------------");
      final model = GuestResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {

          PreferenceManager.setString(NetworkManager.API_TOKEN, "Bearer ${model.data?.accessToken.toString()}");
          PreferenceManager.setString(NetworkManager.PREF_IS_GUEST, model.data!.user!.isGuest.toString());
          PreferenceManager.setString(NetworkManager.PREF_EMAIL, model.data!.user?.email ?? "");
          PreferenceManager.setString(NetworkManager.PREF_MOBILE, model.data!.user?.phoneNo ?? "");
          PreferenceManager.setString(NetworkManager.PREF_FULL_NAME, model.data!.user?.name ?? "");
          PreferenceManager.setString(NetworkManager.PREF_USER_ID, model.data!.user!.id.toString());
          PreferenceManager.setString(NetworkManager.PREF_CITY_NAME, model.data!.user?.city ?? "");
          PreferenceManager.setString(NetworkManager.PREF_DOB_NAME, model.data!.user?.dateOfBirth ?? "");
          PreferenceManager.setString(NetworkManager.PREF_ADRESS, model.data!.user?.address ?? "");
          PreferenceManager.setString(NetworkManager.PREF_POSTAL_CODE, model.data!.user?.postalCode ?? "");
          getconfig();


        });
      } else if (model.status == 0) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Guest",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Guest",
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }




  final List<Widget> _screens = const [
    HomeScreen(),
    MenuFragment(),
    BagFragment(),
    SearchScreen(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👇 Only the selected screen is built
      body: _screens[_currentIndex],

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final icons = [
                Drawables.img_home,
                Drawables.img_menu,
                Drawables.img_cart,
                Drawables.img_search,
                Drawables.img_profile,
              ];

              bool isSelected = _currentIndex == index;

              return GestureDetector(
                onTap: () async {
                  if (index == 4) {
                    final isGuest = PreferenceManager
                        .getString(NetworkManager.PREF_IS_GUEST)
                        ?.toString() ??
                        "";

                    if (isGuest.isNotEmpty) {
                      if (isGuest == "0") {
                        // ✅ Normal user
                        setState(() {
                          _currentIndex = index;
                        });
                      } else {
                        // 🚫 Guest → redirect to login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        );
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: isSelected ? 8 : 0),
                  child: Image.asset(
                    icons[index],
                    height: isSelected ? 32 : 26,
                    width: isSelected ? 32 : 26,
                    color: Colors.black,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> getconfig() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.config_data);
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
      final model = GetConfigResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          PreferenceManager.setString(NetworkManager.PREF_YOUTUBE, model.data!.youtube.toString() ?? "");
          PreferenceManager.setString(NetworkManager.PREF_FACEBOOK, model.data!.facebook.toString() ?? "");
          PreferenceManager.setString(NetworkManager.PREF_INSTAGRAM, model.data!.instagram.toString() ?? "");
          PreferenceManager.setString(NetworkManager.PREF_PINTREST, "Not Provided" ?? "");
        });



      } else if (model.status == 0) {
        Get.snackbar(
          "Config",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else if (model.status == 401) {
        Get.snackbar(
          "Config",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Config",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Config",
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