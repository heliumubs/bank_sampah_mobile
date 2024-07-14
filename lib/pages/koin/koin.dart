import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/koin/koin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// void main() => runApp(KoinPage());

class Coin {
  final int penggunaId;
  final int jumlah;
  final String status;
  final DateTime tglIn;

  Coin({
    required this.penggunaId,
    required this.jumlah,
    required this.status,
    required this.tglIn,
  });
}

class KoinPage extends StatefulWidget {
  @override
  State<KoinPage> createState() => _KoinPageState();
}

class _KoinPageState extends State<KoinPage> {
  final Dio _dio = Dio();

  List<KoinModel> coins = [];
  @override
  void initState() {
    super.initState();
    _fetchCoins();
  }

  Future<void> _fetchCoins() async {
    try {
      final response = await _dio.get('${urllokal}koins');
      print("=====================koin=========");
      print(response.data);
      if (response.statusCode == 200) {
        // Konversi respons JSON menjadi List<Coin>
        List<dynamic> coinList = response.data;
        setState(() {
          coins = coinList.map((json) => KoinModel.fromJson(json)).toList();
        });
      } else {
        print('Gagal mengambil data koin');
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
          title: Text('Daftar Koin'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            },
          ),
        ),
        body: ListView.builder(
          itemCount: coins.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Pengguna ID: ${coins[index].penggunaId}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jumlah: ${coins[index].jumlah}'),
                    Text('Status: ${coins[index].status}'),
                    Text(
                      'Tanggal Masuk: ${coins[index].tglIn}',
                    ),
                  ],
                ),
                leading: Icon(Icons.monetization_on),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print('Tapped Pengguna ID: ${coins[index].penggunaId}');
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Tambahkan logika untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.green, // Warna hijau pada button kembali
        ),
      ),
    );
  }
}
