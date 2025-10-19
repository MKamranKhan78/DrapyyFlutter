
import 'package:flutter/material.dart';

import '../helper/FontsConstants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
        title: Text(
          "CONTACT US",
          style: TextStyle(
            fontFamily: FontConstants.gothamPro,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Chat Icon
            const Icon(Icons.chat_outlined, size: 50, color: Colors.black),

            const SizedBox(height: 15),

            // Small description
            Text(
              "Need an ASAP answer? Contact us via chat, 24/7! For existing furniture orders, please call us.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // Chat Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: Text(
                  "CHAT WITH US",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Mail Icon
            const Icon(Icons.mail_outline, size: 50, color: Colors.black),

            const SizedBox(height: 15),

            // Text description
            Text(
              "You can text us at 800-309-2622 – or click on the “text us” link below on your mobile device. Please allow the system to acknowledge a simple greeting (even “Hi” will do!) before providing your question/order details. Consent is not required for any purchase. Message and data rates may apply. Text messaging may not be available via all carriers.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontConstants.gothamPro,
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // Text Us Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: Text(
                  "TEXT US",
                  style: TextStyle(
                    fontFamily: FontConstants.gothamPro,
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
