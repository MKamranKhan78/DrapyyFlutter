import 'dart:async';
import 'dart:convert';
import 'package:drapyy/fragments/MenuFragment.dart';
import 'package:drapyy/fragments/ProfileFragment.dart';
import 'package:drapyy/helper/drawables.dart';
import 'package:drapyy/models/Model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../fragments/BagFragment.dart';
import '../fragments/HomeFragment.dart';
import '../fragments/SearchFragment.dart';
import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../network/Network.dart';
import 'LoginScreen.dart';
import 'NotificationsScreen.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<MainActivity> {
  int _currentIndex = 0;
  bool isLoading = false;

  String is_cart = "1";
  String cartCount = "";
  String wishCount = "";
  late StreamSubscription cartListener;
  late StreamSubscription wishListener;
  //
  // @override
  // Future<void> initState() async {
  //   super.initState();
  //
  //   if(PreferenceManager.getString(NetworkManager.PREF_CART_COUNT) != null){
  //     if(PreferenceManager.getString(NetworkManager.PREF_CART_COUNT).toString() != "null"){
  //       cartCount = PreferenceManager.getString(NetworkManager.PREF_CART_COUNT).toString();
  //     }
  //   }else{
  //     cartCount = "0";
  //   }
  //
  //   if(PreferenceManager.getString(NetworkManager.PREF_WISH_COUNT) != null){
  //     if(PreferenceManager.getString(NetworkManager.PREF_WISH_COUNT).toString() != "null"){
  //       wishCount = PreferenceManager.getString(NetworkManager.PREF_WISH_COUNT).toString();
  //     }
  //   }else{
  //     wishCount = "0";
  //   }
  //
  //   cartListener = eventBus.on<WishlistUpdatedEvent>().listen((event) {
  //     print("Cart Count Updated: ${event.count}");
  //     setState(() {
  //       PreferenceManager.setString(NetworkManager.PREF_CART_COUNT, event.count.toString() ?? "");
  //       cartCount = event.count;  // Update your UI
  //     });
  //   });
  //
  //   wishListener = eventBus.on<FavUpdatedEvent>().listen((event) {
  //     print("Fav Count Updated: ${event.count}");
  //     setState(() {
  //       PreferenceManager.setString(NetworkManager.PREF_WISH_COUNT, event.count.toString() ?? "");
  //       wishCount = event.count;  // Update your UI
  //     });
  //   });
  //
  //   print("API TOKEN ------> ${PreferenceManager.getString(NetworkManager.API_TOKEN)}");
  //   if (PreferenceManager.getString(NetworkManager.API_TOKEN).toString().isEmpty ||
  //       PreferenceManager.getString(NetworkManager.API_TOKEN) == null ||
  //       PreferenceManager.getString(NetworkManager.API_TOKEN) == "null") {
  //     print("MAINACT------>");
  //
  //
  //
  //
  //     //guestSignup("device_token_12345");
  //     final String? fcmToken =
  //         await FirebaseMessaging.instance.getToken();
  //
  //     debugPrint("FCM TOKEN: $fcmToken");
  //
  //     if (fcmToken != null && fcmToken.isNotEmpty) {
  //       guestSignup(fcmToken);
  //     }
  //
  //
  //
  //
  //   } else {
  //     getconfig();
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // Get Cart Count
    if (PreferenceManager.getString(NetworkManager.PREF_CART_COUNT) != null) {
      if (PreferenceManager.getString(NetworkManager.PREF_CART_COUNT).toString() != "null") {
        cartCount = PreferenceManager
            .getString(NetworkManager.PREF_CART_COUNT)
            .toString();
      }
    } else {
      cartCount = "0";
    }

    // Get Wishlist Count
    if (PreferenceManager.getString(NetworkManager.PREF_WISH_COUNT) != null) {
      if (PreferenceManager.getString(NetworkManager.PREF_WISH_COUNT).toString() != "null") {
        wishCount = PreferenceManager
            .getString(NetworkManager.PREF_WISH_COUNT)
            .toString();
      }
    } else {
      wishCount = "0";
    }

    // Cart Listener
    cartListener = eventBus.on<WishlistUpdatedEvent>().listen((event) {
      print("Cart Count Updated: ${event.count}");

      if (!mounted) return;

      setState(() {
        PreferenceManager.setString(
          NetworkManager.PREF_CART_COUNT,
          event.count.toString(),
        );

        cartCount = event.count;
      });
    });

    // Wishlist Listener
    wishListener = eventBus.on<FavUpdatedEvent>().listen((event) {
      print("Fav Count Updated: ${event.count}");

      if (!mounted) return;

      setState(() {
        PreferenceManager.setString(
          NetworkManager.PREF_WISH_COUNT,
          event.count.toString(),
        );

        wishCount = event.count;
      });
    });

    // Print API Token
    print(
      "API TOKEN ------> "
          "${PreferenceManager.getString(NetworkManager.API_TOKEN)}",
    );

    // Check API Token
    final String? apiToken =
    PreferenceManager.getString(NetworkManager.API_TOKEN);

    if (apiToken == null ||
        apiToken.isEmpty ||
        apiToken == "null") {

      print("MAINACT------>");

      // Get Firebase FCM Token and perform guest signup
      _getFCMTokenAndGuestSignup();
    } else {
      getconfig();
    }
  }


  /// Get Firebase FCM Token and call guest signup
  Future<void> _getFCMTokenAndGuestSignup() async {
    try {
      print("Getting Firebase FCM Token...");

      // Request notification permission
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get FCM Token
      final String? fcmToken =
      await FirebaseMessaging.instance.getToken();

      print("======================================");
      print("FIREBASE FCM TOKEN:");
      print(fcmToken);
      print("======================================");

      if (fcmToken != null && fcmToken.isNotEmpty) {
        print("Calling guestSignup with Firebase token...");

        guestSignup(fcmToken);
      } else {
        print("FCM TOKEN IS NULL OR EMPTY");
      }
    } catch (e) {
      print("FCM TOKEN ERROR: $e");
    }
  }




  @override
  void dispose() {
    cartListener.cancel();
    wishListener.cancel();
    super.dispose();
  }



  Future<void> guestSignup(String deviceToken) async {
    setState(() => isLoading = true);
    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.guest_api);
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

      final model = GuestResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        PreferenceManager.setString(
            NetworkManager.API_TOKEN, "Bearer ${model.data?.accessToken}");
        PreferenceManager.setString(
            NetworkManager.PREF_IS_GUEST, model.data!.user!.isGuest.toString());
        PreferenceManager.setString(
            NetworkManager.PREF_EMAIL, model.data!.user?.email ?? "");
        PreferenceManager.setString(
            NetworkManager.PREF_FULL_NAME, model.data!.user?.name ?? "");
        getconfig();
      } else {
        Get.snackbar("Guest", model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar("Guest", e.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  /// Build the screen dynamically so that BagFragment always receives the latest `is_cart` value.
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MenuFragment();
      case 2:
      // Construct BagFragment each time so it gets the current is_cart value
        return BagFragment(isCart: is_cart);
      case 3:
        return const SearchScreen();
      case 4:
        return const ProfileFragment();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Using Stack to overlay floating buttons at the top-right
      body: Stack(
        children: [
          // Main content (fragments)
          _getScreen(_currentIndex),

          // 🔹 Floating Favorite & Cart Buttons (Top-right)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 15.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        final isGuest = PreferenceManager
                            .getString(NetworkManager.PREF_IS_GUEST)
                            ?.toString() ?? "";

                        if (isGuest.isNotEmpty) {
                          if (isGuest == "0") {
                            // logged-in user: wishlist
                            setState(() {
                              is_cart = "0";
                              _currentIndex = 2;
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        }
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),

                          // ============================
                          // ❤️ Wishlist Count Badge
                          // ============================
                             Positioned(
                              right: 2,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    wishCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          is_cart = "1";
                          _currentIndex = 2;
                        });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Colors.black,
                          ),

                          // 🔥 Badge
                         Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20), // makes it circular/pill
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Center(
                                child: Text(
                                  cartCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // 🔹 Bottom Navigation Bar
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
                Drawables.img_homme,
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
                        setState(() {
                          _currentIndex = index;
                        });
                      } else {
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
                    // If tapping the cart icon in bottom nav, ensure is_cart is set to "1"
                    if (index == 2) {
                      setState(() {
                        is_cart = "1";
                        _currentIndex = index;
                      });
                    } else {
                      setState(() {
                        _currentIndex = index;
                      });
                    }
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
    setState(() => isLoading = true);

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.config_data);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    final client = CustomHttpClient(http.Client());

    try {
      final response = await client.get(url, headers: headers);
      final model = GetConfigResponsee.fromJson(json.decode(response.body));
      if (model.status == 1) {
        PreferenceManager.setString(
            NetworkManager.PREF_YOUTUBE, model.data!.youtube.toString());
        PreferenceManager.setString(
            NetworkManager.PREF_FACEBOOK, model.data!.facebook.toString());
        PreferenceManager.setString(
            NetworkManager.PREF_INSTAGRAM, model.data!.instagram.toString());
        PreferenceManager.setString(NetworkManager.PREF_PINTREST, "Not Provided");
      } else {
        Get.snackbar("Config", model.message.toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar("Config", e.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
