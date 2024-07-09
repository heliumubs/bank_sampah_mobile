import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  final List<Location> locations = [
    Location(
      namaLokasi: 'Taman Kota',
      alamat: 'Jl. Kebun Raya No.1',
      latitude: -6.8957643,
      longitude: 107.6338462,
      kontak: '081234567890',
    ),
    Location(
      namaLokasi: 'Pusat Daur Ulang',
      alamat: 'Jl. Merdeka No.2',
      latitude: -6.914744,
      longitude: 107.609810,
      kontak: '081987654321',
    ),
    Location(
      namaLokasi: 'Bank Sampah',
      alamat: 'Jl. Lingkar Selatan No.3',
      latitude: -6.90389,
      longitude: 107.61861,
      kontak: '082123456789',
    ),
    Location(
      namaLokasi: 'Tempat Pembuangan Akhir',
      alamat: 'Jl. Ciparay No.4',
      latitude: -6.931944,
      longitude: 107.634167,
      kontak: '082198765432',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Lokasi'),
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
