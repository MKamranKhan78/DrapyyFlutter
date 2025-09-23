// Method to check if the device is connected to the internet


import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

/*class NoInternetUtils {
  static Future<bool> checkInternetConnection() async {
    try {
      // Attempt to make an HTTP request to a reliable source
      print("CHECK INTER CONNECTION IN UTILS ----->11");
      final response = await http.get(Uri.parse('https://www.google.com/')).timeout(Duration(seconds: 1));
      // If the request succeeds, it means there's internet access
      if (response.statusCode == 200) {
        print("CHECK INTER CONNECTION IN UTILS ----->22");
        return true;
      }
    } on SocketException catch (_) {
      print("CHECK INTER CONNECTION IN UTILS ----->33");
      // Network connection issue
      return false;
    } on TimeoutException catch (_) {
      print("CHECK INTER CONNECTION IN UTILS ----->44");
      // Timeout, likely no internet
      return false;
    } catch (e) {
      print("CHECK INTER CONNECTION IN UTILS ----->55");
      // Catch other possible exceptions
      return false;
    }
    print("CHECK INTER CONNECTION IN UTILS ----->LAST");
    return false; // Default fallback if the response is not 200
  }
}*/

class NoInternetUtils{
  static Future<bool> checkInternetConnection() async {
  try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;


  }
}