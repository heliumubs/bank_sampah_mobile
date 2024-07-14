import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/lokasi/lokasi_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(LokasiPage());

class Location {
  final String namaLokasi;
  final String alamat;
  final double latitude;
  final double longitude;
  final String kontak;

  Location({
    required this.namaLokasi,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.kontak,
  });
}

class LokasiPage extends StatefulWidget {
  @override
  State<LokasiPage> createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  List<LokasiModel> locations = [];
  final Dio _dio = Dio();
  String? role = '';
  int? id = 0;

  @override
  void initState() {
    super.initState();
    _fetchLocations();
    _loadRole();
  }

  Future<void> _fetchLocations() async {
    try {
      final response = await _dio.get('${urllokal}lokasis');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          locations = data.map((json) => LokasiModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil daftar lokasi');
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
          backgroundColor: Colors.green, // Ubah warna header menjadi hijau
          title: Text('Daftar Lokasi'),
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
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(locations[index].namaLokasi),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alamat: ${locations[index].alamat}'),
                    Text('Latitude: ${locations[index].latitude}'),
                    Text('Longitude: ${locations[index].longitude}'),
                    Text('Kontak: ${locations[index].kontak}'),
                  ],
                ),
                leading: Icon(Icons.location_on),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print('Tapped ${locations[index].namaLokasi}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
