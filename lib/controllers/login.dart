import 'dart:convert';
import 'package:bkash_ui/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> registerAndSaveData(Map<String, dynamic> data) async {
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
    if (response.statusCode == 201) {
      // Mendapatkan data dari respons
      var responseData = jsonDecode(response.body);

      // Menyimpan data ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', responseData.toString());

      print('Data berhasil disimpan ke SharedPreferences');
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
