
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FiltersScreenState();
}


class _FiltersScreenState extends State<FilterScreen> {
  // Size lists
  final List<String> clothingSizes = ["XS", "S", "M", "L", "XL", "XXL"];
  final List<String> shoeSizes = ["14", "14.5", "15"];

  String? selectedSize;
  String selectedColor = "Lime";

  // Price Range
  RangeValues _priceRange = const RangeValues(0, 100);

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

      body: Padding(
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

            // Sizes List (Clothing)
            SizedBox(
              height: 36, // slightly smaller
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: clothingSizes.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final size = clothingSizes[index];
                  final isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Shoe Sizes List
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: shoeSizes.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final size = shoeSizes[index];
                  final isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Color Row (Text + Dropdown)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Color",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14, // reduced
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedColor,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  underline: const SizedBox(), // hide underline
                  items: <String>["Lime", "Red", "Blue", "Black"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 13, // reduced
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedColor = val!;
                    });
                  },
                ),
              ],
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
              max: 500,
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
            onPressed: () {},
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
}