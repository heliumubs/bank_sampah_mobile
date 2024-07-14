import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Model untuk Pengguna
class User {
  final int id;
  final String idUser;
  final String alamat;
  final String telepon;
  final String nomorIdentifikasi;
  final String jenisPengguna;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.idUser,
    required this.alamat,
    required this.telepon,
    required this.nomorIdentifikasi,
    required this.jenisPengguna,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      idUser: json['id_user'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      nomorIdentifikasi: json['nomor_identifikasi'],
      jenisPengguna: json['jenis_pengguna'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final Dio _dio = Dio();

  final TextEditingController _idUserController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _nomorIdentifikasiController =
      TextEditingController();
  final TextEditingController _jenisPenggunaController =
      TextEditingController();
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? userDataString = prefs.getString('userData');
      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          _idUserController.text = userData['data']['id'].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengguna'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _idUserController,
              decoration: InputDecoration(labelText: 'ID User'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _teleponController,
              decoration: InputDecoration(labelText: 'Telepon'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _nomorIdentifikasiController,
              decoration: InputDecoration(labelText: 'Nomor Identifikasi'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _jenisPenggunaController,
              decoration: InputDecoration(labelText: 'Jenis Pengguna'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _saveUser();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveUser() async {
    final data = {
      'id_user': _idUserController.text,
      'alamat': _alamatController.text,
      'telepon': _teleponController.text,
      'nomor_identifikasi': _nomorIdentifikasiController.text,
      'jenis_pengguna': "pembeli",
    };

    try {
      final response = await _dio.post('${urllokal}penggunas', data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Pengguna berhasil disimpan');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomNavigation()),
        ); // Kembali ke halaman sebelumnya setelah berhasil disimpan
      } else {
        print('Gagal menyimpan pengguna');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
