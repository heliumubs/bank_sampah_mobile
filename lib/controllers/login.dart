import 'dart:convert';
import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/login/login_screen.dart';
import 'package:bkash_ui/pages/pengguna/pengguna.dart';
import 'package:bkash_ui/pages/pengguna/tambah_pengguna.dart';
import 'package:bkash_ui/pages/pin_page.dart';
import 'package:bkash_ui/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> loginAndSaveData(
    Map<String, dynamic> data, BuildContext context) async {
  try {
    // URL API
    String url = urllokal + 'login';

    print("$url, $data");

    // Melakukan permintaan POST ke API
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    print(response.body);

    // Memeriksa jika respons sukses
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Mendapatkan data dari respons
      var responseData = jsonDecode(response.body);

      // Menyimpan data ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonEncode(responseData));

      print('Data berhasil disimpan ke SharedPreferences');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigation()),
      );
    } else if (response.statusCode == 422) {
      var responseData = jsonDecode(response.body);
      print('Data tidak valid: ${responseData['errors']}');
    } else {
      print('Gagal mendaftar: ${response.statusCode}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}

Future<void> registerAndSaveData(
    Map<String, dynamic> data, BuildContext context) async {
  try {
    // URL API
    String url = urllokal + 'register';

    print("$url, $data");

    // Melakukan permintaan POST ke API
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    print(response.body);

    // Memeriksa jika respons sukses
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Mendapatkan data dari respons
      var responseData = jsonDecode(response.body);

      // Menyimpan data ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonEncode(responseData));

      print('Data berhasil disimpan ke SharedPreferences');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AddUserPage()),
      );
    } else if (response.statusCode == 422) {
      var responseData = jsonDecode(response.body);
      print('Data tidak valid: ${responseData['errors']}');
    } else {
      print('Gagal mendaftar: ${response.statusCode}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userData'); // Menghapus data pengguna

  // Navigasi ke halaman login dan hapus semua halaman sebelumnya
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (Route<dynamic> route) => false,
  );
}
