import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/jenis_sampah/jenis_sampah_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(JenisSampah());

class TrashType {
  final String name;
  final String description;

  TrashType({
    required this.name,
    required this.description,
  });
}

class JenisSampah extends StatefulWidget {
  @override
  State<JenisSampah> createState() => _JenisSampahState();
}

class _JenisSampahState extends State<JenisSampah> {
  List<JenisSampahModel> trashTypes = [];
  final Dio _dio = Dio();
  String? role = '';
  int? id = 0;

  @override
  void initState() {
    super.initState();
    _fetchTrashTypes();
    _loadRole();
  }

  Future<void> _fetchTrashTypes() async {
    try {
      final response = await _dio.get('${urllokal}jenis-sampahs');
      print("====================");
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          trashTypes =
              data.map((json) => JenisSampahModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil jenis sampah');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _loadRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? userDataString = prefs.getString('userData');
      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          role = userData['data']['role'];
          id = userData['data']['id'];
        });
      } else {
        role = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Color.fromARGB(255, 33, 243, 44), // Warna background AppBar
          title: Text('Jenis Sampah'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            },
          ),
          actions:
              role != 'User' // Menampilkan tombol aksi hanya jika isAdmin true
                  ? [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // _showAddTransactionDialog(context);
                        },
                      ),
                    ]
                  : [],
        ),
        body: ListView.builder(
          itemCount: trashTypes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(trashTypes[index].name),
              subtitle: Text(trashTypes[index].description),
              leading: Icon(Icons.delete), // Ganti dengan ikon yang sesuai
              onTap: () {
                // Tambahkan logika untuk menangani ketika item list ditekan
                print('Tapped ${trashTypes[index].name}');
              },
            );
          },
        ),
      ),
    );
  }
}
