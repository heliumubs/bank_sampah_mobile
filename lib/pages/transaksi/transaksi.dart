import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  final List<Transaksi> transaksiList = [
    Transaksi(
      penggunaId: 1,
      sampahId: 1,
      kuantitas: 2.5,
      nilai: 1250.0,
      createdAt: DateTime.parse("2024-06-27T13:57:04.000000Z"),
      updatedAt: DateTime.parse("2024-06-27T13:57:04.000000Z"),
    ),
    Transaksi(
      penggunaId: 2,
      sampahId: 3,
      kuantitas: 1.0,
      nilai: 500.0,
      createdAt: DateTime.parse("2024-06-28T14:30:00.000000Z"),
      updatedAt: DateTime.parse("2024-06-28T14:30:00.000000Z"),
    ),
    Transaksi(
      penggunaId: 3,
      sampahId: 2,
      kuantitas: 3.0,
      nilai: 900.0,
      createdAt: DateTime.parse("2024-06-29T08:45:00.000000Z"),
      updatedAt: DateTime.parse("2024-06-29T08:45:00.000000Z"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Transaksi'),
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
                        'Kuantitas: ${transaksiList[index].kuantitas.toStringAsFixed(2)} kg'),
                    Text(
                        'Nilai: Rp ${transaksiList[index].nilai.toStringAsFixed(2)}'),
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
}
