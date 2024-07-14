import 'package:bkash_ui/pages/pengguna/pengguna_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// void main() => runApp(Pengguna_page());

class Pengguna {
  final int idUser;
  final String alamat;
  final String telepon;
  final String nomorIdentifikasi;
  final String jenisPengguna;

  Pengguna({
    required this.idUser,
    required this.alamat,
    required this.telepon,
    required this.nomorIdentifikasi,
    required this.jenisPengguna,
  });
}

class Pengguna_page extends StatefulWidget {
  @override
  State<Pengguna_page> createState() => _Pengguna_pageState();
}

class _Pengguna_pageState extends State<Pengguna_page> {
  final Dio _dio = Dio();
  List<UserModel> penggunaList = [];
  Future<void> _fetchPengguna() async {
    try {
      final response = await _dio.get('http://localhost:8000/api/penggunas');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          penggunaList = data.map((json) => UserModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil data Pengguna');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPengguna();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Pengguna'),
        ),
        body: ListView.builder(
          itemCount: penggunaList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('ID User: ${penggunaList[index].idUser}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alamat: ${penggunaList[index].alamat}'),
                    Text('Telepon: ${penggunaList[index].telepon}'),
                    Text(
                        'Nomor Identifikasi: ${penggunaList[index].nomorIdentifikasi}'),
                    Text(
                        'Jenis Pengguna: ${penggunaList[index].jenisPengguna}'),
                  ],
                ),
                leading: Icon(Icons.person),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print('Tapped User ID: ${penggunaList[index].idUser}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
