
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Termsandconditionscreen extends StatefulWidget {
  const Termsandconditionscreen({super.key});

  @override
  State<Termsandconditionscreen> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<Termsandconditionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // go back
          },
        ),
        title: const Text(
          "Terms and Conditions",
          style: TextStyle(
            fontFamily: "GothamPro",
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Here are the terms and conditions. "
              "You can replace this text with your actual content.",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "GothamPro",
          ),
        ),
      ),
    );
  }
}
