import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/magot/magot_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MagotScreen extends StatefulWidget {
  // MagotScreen({});

  @override
  _MagotScreenState createState() => _MagotScreenState();
}

class _MagotScreenState extends State<MagotScreen> {
  final Dio _dio = Dio();
  late List<Magot> magot = [];
  String? role = '';
  int? id = 0;

  @override
  void initState() {
    super.initState();
    _fetchMagot();
    _loadRole();
  }

  Future<void> _fetchMagot() async {
    try {
      final response = await _dio.get('${urllokal}magots');
      if (response.statusCode == 200) {
        // Konversi respons JSON menjadi List<Magot>
        List<dynamic> magotDataList = response.data;
        setState(() {
          magot = magotDataList.map((data) => Magot.fromJson(data)).toList();
        });
      } else {
        print('Gagal mengambil data Magots');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Daftar Magot'),
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
      body: magot == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: magot.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(magot[index].nama),
                  subtitle: Text(magot[index].jenis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MagotDetailsScreen(magot: magot[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

// Screen untuk menampilkan detail Magot
class MagotDetailsScreen extends StatelessWidget {
  final Magot magot;

  MagotDetailsScreen({required this.magot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Magot Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image.network(magot.foto),
            SizedBox(height: 16.0),
            Text(
              'Nama: ${magot.nama}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Jenis: ${magot.jenis}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Deskripsi: ${magot.deskripsi}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Updated At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(magot.updatedAt)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            Text(
              'Created At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(magot.createdAt)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
