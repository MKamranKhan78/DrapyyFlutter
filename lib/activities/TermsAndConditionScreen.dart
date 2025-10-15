
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../helper/ToastUtils.dart';
import '../helper/customHttpClient.dart';
import '../helper/preference_manager.dart';
import '../models/Model.dart';
import '../network/Network.dart';

class Termsandconditionscreen extends StatefulWidget {
  const Termsandconditionscreen({super.key});

  @override
  State<Termsandconditionscreen> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<Termsandconditionscreen> {

  bool isLoading = false;
  String content ="";


  @override
  void initState() {
     super.initState();
     getTermsAndCondition();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Terms And Conditions",
          style: TextStyle(
            fontFamily: "GothamPro",
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Html(
            data: content ?? "<p>No data available.</p>",
            style: {
              "body": Style(
                fontSize: FontSize(14),
                fontFamily: "GothamPro",
                lineHeight: LineHeight(1.6),
              ),
              "p": Style(
                margin: Margins.symmetric(vertical: 8),
              ),
            },
          ),
        ),
      ),
    );
  }

  Future<void> getTermsAndCondition() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(NetworkManager.BASE_URL + NetworkManager.termsAndCondition);
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
      final model = PrivacyPolicyResponse.fromJson(json.decode(response.body));
      if (model.status == 1) {
        setState(() {
          print(model.data!.content!.description.toString());
          if(model.data!.content!.description != null){
            content = model.data!.content!.description.toString();
          }
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
