import 'package:drapyy/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class BecomePartnerScreen extends StatefulWidget {
  const BecomePartnerScreen({super.key});

  @override
  State<BecomePartnerScreen> createState() => _BecomePartnerScreenState();
}

class _BecomePartnerScreenState extends State<BecomePartnerScreen> {

  String? selectedValueCity;

  final List<String> cityList = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];
  String? selectedValueOption;

  final List<String> listOption = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedValueOption1;

  final List<String> listOption1 = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedSupplyChain;

  final List<String> listSupplyChain = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedProduceInventory;

  final List<String> listInventory = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  String? selectedValueStoreType;

  final List<String> storeList = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // 👈 scrollable if content grows
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        // Back arrow
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        // Title centered
                        Expanded(
                          child: Center(
                            child: Text(
                              'BECOME SELLER',
                              style: const TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        // Spacer to balance
                        const SizedBox(width: 48),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR BRAND NAME",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR NAME",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR EAMIL",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "ENTER YOUR PHONE",
                    labelStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 12,
                      color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),


              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueCity,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select City",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: cityList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValueCity = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueOption,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select option",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listOption.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValueOption = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueStoreType,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Store Type",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: storeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValueStoreType = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedValueOption1,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Option",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listOption1.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValueOption1 = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedSupplyChain,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select Supply Chain",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listSupplyChain.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSupplyChain = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedProduceInventory,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8), // 👈 space between text & line
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,size: 30,), // dropdown icon
                  hint: const Text(
                    "Select PRODUCE INVENTORY",
                    style: TextStyle(
                      fontFamily: FontConstants.gothamPro,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  items: listInventory.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: FontConstants.gothamPro,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedProduceInventory = newValue;
                    });
                  },
                ),
              ),



              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "WEBSITE LINK",
                    labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: const TextStyle(fontFamily: FontConstants.gothamPro),
                  keyboardType: TextInputType.text, // ✅ email input
                  decoration: const InputDecoration(
                    labelText: "SOCIAL LINK",
                    labelStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    hintStyle: TextStyle(
                        fontFamily: FontConstants.gothamPro,
                        fontSize: 12,
                        color: grey
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),




              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
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
                            horizontal: 16,
                            vertical: 15,
                          ),
                          child: Center(
                            child: Text(
                              'SUBMIT REQUEST',
                              style: TextStyle(
                                fontFamily: FontConstants.gothamPro,
                                fontSize: 12, // Slightly smaller for grid layout
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
              ),

              const SizedBox(height: 40),
             ],
          ),
        ),
      ),
    );
  }

}