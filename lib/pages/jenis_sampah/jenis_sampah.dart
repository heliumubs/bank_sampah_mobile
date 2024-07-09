import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class TrashType {
  final String name;
  final String description;

  TrashType({
    required this.name,
    required this.description,
  });
}

class MyApp extends StatelessWidget {
  final List<TrashType> trashTypes = [
    TrashType(
      name: 'Plastik',
      description: 'Contoh: Botol plastik, kantong plastik',
    ),
    TrashType(
      name: 'Kertas',
      description: 'Contoh: Koran, kertas bekas',
    ),
    TrashType(
      name: 'Logam',
      description: 'Contoh: Kaleng, tutup botol',
    ),
    TrashType(
      name: 'Kaca',
      description: 'Contoh: Botol kaca, pecahan kaca',
    ),
    TrashType(
      name: 'Organik',
      description: 'Contoh: Sisa makanan, daun kering',
    ),
    TrashType(
      name: 'Elektronik',
      description: 'Contoh: Handphone rusak, komputer tua',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jenis Sampah'),
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
