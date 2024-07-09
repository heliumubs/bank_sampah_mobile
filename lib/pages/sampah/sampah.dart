import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  final List<Sampah> sampahList = [
    Sampah(
      namaSampah: 'Plastik',
      keterangan: 'Sampah plastik seperti botol, kantong plastik, dll.',
      jenis: 'Anorganik',
      harga: 500.0,
    ),
    Sampah(
      namaSampah: 'Kertas',
      keterangan: 'Sampah kertas seperti koran, buku bekas, dll.',
      jenis: 'Anorganik',
      harga: 300.0,
    ),
    Sampah(
      namaSampah: 'Sisa Makanan',
      keterangan: 'Sisa makanan yang tidak habis dikonsumsi.',
      jenis: 'Organik',
      harga: 200.0,
    ),
    Sampah(
      namaSampah: 'Botol Kaca',
      keterangan: 'Sampah botol kaca seperti botol minuman, dll.',
      jenis: 'Anorganik',
      harga: 400.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Sampah'),
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
                        'Harga: Rp ${sampahList[index].harga.toStringAsFixed(2)}'),
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
