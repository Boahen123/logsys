// manage tokens locally

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // store the token
  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    log('stored token successfully');
  }

  // get the token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    log('retrieved token successfully');
    return prefs.getString('token');
  }

  // remove the token
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    bool cleared = await prefs.clear();
    log(cleared ? 'removed token successfully' : 'error removing token');
  }
}
