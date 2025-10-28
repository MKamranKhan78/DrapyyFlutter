
import 'dart:convert';

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

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FiltersScreenState();
}


class _FiltersScreenState extends State<FilterScreen> {
  bool isLoading = false;

  List<PBBSizes> size_list = [];
  List<int> selectedIndexes = []; // ✅ Multiple selections, empty by default

  List<PBBColors> color_list = [];
  PBBColors? selectedColor; // selected color object
  int? selectedColorId; // store selected color id

  // Price Range
  RangeValues _priceRange = const RangeValues(0, 25000);


  @override
  void initState() {
    super.initState();
    getSizeAndColor();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "FILTERS",
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Size Title
            const Text(
              "Size",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 14, // reduced
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Choose your size",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 11, // reduced
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),
            _buildNavigationTabs(),

            const SizedBox(height: 10),

            // Color Row (Text + Dropdown)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Color",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16, // reduced
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DropdownButton<PBBColors>(
                    value: selectedColor,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    underline: const SizedBox(), // hide underline
                    hint: const Text(
                      "Select Color",
                      style: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    items: color_list.map((PBBColors value) {
                      return DropdownMenuItem<PBBColors>(
                        value: value,
                        child: Text(
                          value.color ?? "Unknown",
                          style: const TextStyle(
                            fontFamily: FontConstants.gothamPro,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedColor = val;
                        selectedColorId = val?.id; // ✅ get color id here
                      });
                      debugPrint("Selected Color ID: ${selectedColorId}");

                    },
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),

            // Price
            const Text(
              "Price",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 14, // reduced
                fontWeight: FontWeight.w500,
              ),
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 25000,
              activeColor: Colors.black,
              inactiveColor: Colors.grey[300],
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
          ],
        ),
      ),

      // ✅ Fixed Apply button here
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 70),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            onPressed: () {

              // Prepare data to send back
              Map<String, dynamic> dataToSend = {
                'colors': selectedColorId.toString(),
                'sizes': selectedIndexes,
                'min_price': _priceRange.start.round().toString(), // Round and convert to string
                'max_price': _priceRange.end.round().toString(),   // Round and convert to string
              };

              // Send data back and close screen
              Get.back(result: dataToSend);

            },
            child: const Text(
              "APPLY",
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: size_list.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndexes.contains(index);
            final item = size_list[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedIndexes.remove(index);
                  } else {
                    selectedIndexes.add(index);
                  }
                   print("SELECTED SIZES ---> ${selectedIndexes.map((i) => size_list[i].id).toList()}");
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    item.size.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getSizeAndColor() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.productByBroand);
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      PreferenceManager.getString(NetworkManager.API_TOKEN).toString(),
    };

    // ✅ Request body changed to match Kotlin version
    final requestBody = {
      "brand": "khazanatul-malabis",
      "per_page": "2",
      "current_page": "1",
      "category_level1_id": "",
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
      PBBGetProductByBrand.fromJson(json.decode(response.body));

      if (model.status == 1) {
        if(model.data!.sizes!.length > 0){
          size_list.clear();
          size_list.addAll(model.data!.sizes as Iterable<PBBSizes>);
        }

        if(model.data!.colors!.length > 0){
          color_list.clear();
          color_list.addAll(model.data!.colors as Iterable<PBBColors>);
        }


      } else if (model.status == 0 ||
          model.status == 401 ||
          model.status != null) {
        Get.snackbar(
          "Colors",
          model.message.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Colors",
          "Unexpected response from server.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Colors",
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