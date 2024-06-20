import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerAndSaveData(String url, Map<String, dynamic> data) async {
  try {
    // Membuat instance Dio
    var dio = Dio();

    print("$url, $data");
    // Melakukan permintaan POST ke API
    Response response = await dio.post(url, data: data);

    print(response.data);
    // Memeriksa jika respons sukses
    if (response.statusCode == 200) {
      // Mendapatkan data dari respons
      var responseData = response.data;

      // Menyimpan data ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', responseData.toString());

      print('Data berhasil disimpan ke SharedPreferences');
    } else {
      print('Gagal mendaftar: ${response.statusCode}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
