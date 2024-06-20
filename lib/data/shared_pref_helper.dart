import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefHelper {
  static const String _userDataKey = 'userData';

  // Menyimpan data pengguna ke SharedPreferences
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    String userDataString = jsonEncode(userData);
    await prefs.setString(_userDataKey, userDataString);
  }

  // Mengambil data pengguna dari SharedPreferences
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  // Menghapus data pengguna dari SharedPreferences
  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }
}
