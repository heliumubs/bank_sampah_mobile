import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  final List<Coin> coins = [
    Coin(
        penggunaId: 1,
        jumlah: 100,
        status: 'Aktif',
        tglIn: DateTime.parse('2024-07-01')),
    Coin(
        penggunaId: 2,
        jumlah: 200,
        status: 'Tidak Aktif',
        tglIn: DateTime.parse('2024-06-30')),
    Coin(
        penggunaId: 3,
        jumlah: 150,
        status: 'Aktif',
        tglIn: DateTime.parse('2024-06-29')),
    Coin(
        penggunaId: 4,
        jumlah: 300,
        status: 'Aktif',
        tglIn: DateTime.parse('2024-06-28')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Koin'),
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
                        'Tanggal Masuk: ${DateFormat('yyyy-MM-dd').format(coins[index].tglIn)}'),
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
      ),
    );
  }
}
