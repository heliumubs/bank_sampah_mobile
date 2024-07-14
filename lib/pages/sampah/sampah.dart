import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/sampah/sampah_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// void main() => runApp(SampahPage());

class Sampah {
  final String namaSampah;
  final String keterangan;
  final String jenis;
  final double harga;

  Sampah({
    required this.namaSampah,
    required this.keterangan,
    required this.jenis,
    required this.harga,
  });
}

class SampahPage extends StatefulWidget {
  @override
  State<SampahPage> createState() => _SampahPageState();
}

class _SampahPageState extends State<SampahPage> {
  List<SampahModel> sampahList = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchSampahs();
  }

  Future<void> _fetchSampahs() async {
    try {
      final response = await _dio.get('${urllokal}sampahs');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          sampahList = data.map((json) => SampahModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil daftar sampah');
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
          title: Text('Daftar Sampah'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            },
          ),
        ),
        body: ListView.builder(
          itemCount: sampahList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Nama Sampah: ${sampahList[index].namaSampah}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Keterangan: ${sampahList[index].keterangan}'),
                    Text('Jenis: ${sampahList[index].jenis}'),
                    Text(
                      'Harga: Rp ${sampahList[index].harga}',
                    ),
                  ],
                ),
                leading: Icon(Icons.delete),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print('Tapped Sampah: ${sampahList[index].namaSampah}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
