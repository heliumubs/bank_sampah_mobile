import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/transaksi/transaksi_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(TransaksiPage());

class Transaksi {
  final int penggunaId;
  final int sampahId;
  final double kuantitas;
  final double nilai;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaksi({
    required this.penggunaId,
    required this.sampahId,
    required this.kuantitas,
    required this.nilai,
    required this.createdAt,
    required this.updatedAt,
  });
}

class TransaksiPage extends StatefulWidget {
  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TextEditingController _penggunaIdController = TextEditingController();
  final TextEditingController _sampahIdController = TextEditingController();
  final TextEditingController _kuantitasController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();
  final Dio _dio = Dio();
  String? role = '';
  int? id = 0;
  List<TransaksiModel> transaksiList = [];
  @override
  void initState() {
    super.initState();
    _fetchTransaksi();
    _loadRole();
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

  Future<void> _fetchTransaksi() async {
    try {
      final response = await _dio.get('${urllokal}transaksis');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("=================================");
        print(response.data);
        setState(() {
          transaksiList =
              data.map((json) => TransaksiModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil data transaksi');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green, // Ubah warna header menjadi hijau
          title: Text('Daftar Transaksi'),
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
                          _showAddTransactionDialog(context);
                        },
                      ),
                    ]
                  : [], // Jika bukan admin, actions kosong
        ),
        body: ListView.builder(
          itemCount: transaksiList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Pengguna ID: ${transaksiList[index].penggunaId}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sampah ID: ${transaksiList[index].sampahId}'),
                    Text(
                      'Kuantitas: ${transaksiList[index].kuantitas.toStringAsFixed(2)} kg',
                    ),
                    Text(
                      'Nilai: Rp ${transaksiList[index].nilai.toStringAsFixed(2)}',
                    ),
                    Text('Dibuat pada: ${transaksiList[index].createdAt}'),
                    Text('Diperbarui pada: ${transaksiList[index].updatedAt}'),
                  ],
                ),
                leading: Icon(Icons.receipt),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print(
                      'Tapped Transaksi ID: ${transaksiList[index].penggunaId}');
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Transaksi Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _penggunaIdController,
                decoration: InputDecoration(labelText: 'Pengguna ID'),
              ),
              TextField(
                controller: _sampahIdController,
                decoration: InputDecoration(labelText: 'Sampah ID'),
              ),
              TextField(
                controller: _kuantitasController,
                decoration: InputDecoration(labelText: 'Kuantitas'),
              ),
              TextField(
                controller: _nilaiController,
                decoration: InputDecoration(labelText: 'Nilai'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                _saveTransaction();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveTransaction() async {
    final int penggunaId = int.parse(_penggunaIdController.text);
    final int sampahId = int.parse(_sampahIdController.text);
    final double kuantitas = double.parse(_kuantitasController.text);
    final double nilai = double.parse(_nilaiController.text);

    final data = {
      'pengguna_id': penggunaId,
      'sampah_id': sampahId,
      'kuantitas': kuantitas,
      'nilai': nilai,
    };

    try {
      final response = await _dio.post('${urllokal}transaksis', data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Transaksi berhasil disimpan');
        setState(() {
          _fetchTransaksi();
        });
        _showExchangeDialog(context);
        // Tambahkan logika untuk menambahkan data baru ke dalam transaksiList
        // setState atau metode lain untuk memperbarui UI
      } else {
        print('Gagal menyimpan transaksi');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showExchangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tukar Transaksi'),
          content: Text(
              'Apakah Anda ingin menukarkan transaksi sebagai koin atau rupiah?'),
          actions: [
            TextButton(
              child: Text('Koin'),
              onPressed: () {
                // Logika untuk menukar sebagai koin
                Navigator.of(context).pop();
                _saveAsKoin();
              },
            ),
            TextButton(
              child: Text('Rupiah'),
              onPressed: () {
                // Logika untuk menukar sebagai rupiah
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAsKoin() async {
    final int penggunaId = int.parse(_penggunaIdController.text);
    final double jumlah = double.parse(
        _nilaiController.text); // Anggap nilai digunakan untuk jumlah koin

    final dataKoin = {
      'pengguna_id': penggunaId,
      'jumlah': jumlah,
      'status': 'masuk',
      'tgl_in': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
    };

    try {
      final responseKoin = await _dio.post('${urllokal}koins', data: dataKoin);
      if (responseKoin.statusCode == 200 || responseKoin.statusCode == 201) {
        print('Data koin berhasil disimpan');
        // Tambahkan logika tambahan jika diperlukan setelah menyimpan koin
      } else {
        print('Gagal menyimpan data koin');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
