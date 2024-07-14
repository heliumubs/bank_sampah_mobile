import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/edukasi_sampah/detail_edukasi_sampah.dart';
import 'package:bkash_ui/pages/edukasi_sampah/edukasi_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdukasiSampah extends StatefulWidget {
  @override
  _EdukasiSampahPageState createState() => _EdukasiSampahPageState();
}

class _EdukasiSampahPageState extends State<EdukasiSampah> {
  List<EdukasiSampahModel> contents = [];
  Dio dio = Dio();
  String? role = '';
  int? id = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    _loadRole();
  }

  Future<void> fetchData() async {
    try {
      final response = await dio.get('${urllokal}edukasi-sampahs');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          contents =
              data.map((item) => EdukasiSampahModel.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
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
          title: Text('Edukasi Sampah'),
          backgroundColor:
              Colors.green, // Ubah warna latar belakang appbar sesuai kebutuhan
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
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
                  : [], // Jika bukan admin, actions kosong
        ),
        body: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(contents[index].judul),
              subtitle: Text(
                  '${contents[index].kategori} oleh ${contents[index].penulis}'),
              onTap: () {
                // Tambahkan logika untuk menangani ketika item list ditekan
                // Contohnya bisa menampilkan detail konten atau navigasi ke halaman lain.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailContentPage(
                      content: contents[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
