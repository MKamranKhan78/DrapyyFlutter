
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacypolicyscreen extends StatefulWidget {
  const Privacypolicyscreen({super.key});

  @override
  State<Privacypolicyscreen> createState() => _PrivacypolicyscreenState();
}

class _PrivacypolicyscreenState extends State<Privacypolicyscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // go back
          },
        ),
        title: const Text(
          "Privacy Policy",
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
          "Here are the privacy policy. "
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
