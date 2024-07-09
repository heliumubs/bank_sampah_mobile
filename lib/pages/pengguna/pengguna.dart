import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Pengguna {
  final int idUser;
  final String alamat;
  final String telepon;
  final String nomorIdentifikasi;
  final String jenisPengguna;

  Pengguna({
    required this.idUser,
    required this.alamat,
    required this.telepon,
    required this.nomorIdentifikasi,
    required this.jenisPengguna,
  });
}

class MyApp extends StatelessWidget {
  final List<Pengguna> penggunaList = [
    Pengguna(
      idUser: 1,
      alamat: 'Jl. Kebon Jeruk No.1',
      telepon: '081234567890',
      nomorIdentifikasi: 'ID123456',
      jenisPengguna: 'Admin',
    ),
    Pengguna(
      idUser: 2,
      alamat: 'Jl. Sudirman No.2',
      telepon: '081987654321',
      nomorIdentifikasi: 'ID654321',
      jenisPengguna: 'User',
    ),
    Pengguna(
      idUser: 3,
      alamat: 'Jl. Thamrin No.3',
      telepon: '082123456789',
      nomorIdentifikasi: 'ID789123',
      jenisPengguna: 'User',
    ),
    Pengguna(
      idUser: 4,
      alamat: 'Jl. Gatot Subroto No.4',
      telepon: '082198765432',
      nomorIdentifikasi: 'ID321987',
      jenisPengguna: 'Admin',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Pengguna'),
        ),
        body: ListView.builder(
          itemCount: penggunaList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('ID User: ${penggunaList[index].idUser}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alamat: ${penggunaList[index].alamat}'),
                    Text('Telepon: ${penggunaList[index].telepon}'),
                    Text(
                        'Nomor Identifikasi: ${penggunaList[index].nomorIdentifikasi}'),
                    Text(
                        'Jenis Pengguna: ${penggunaList[index].jenisPengguna}'),
                  ],
                ),
                leading: Icon(Icons.person),
                onTap: () {
                  // Tambahkan logika untuk menangani ketika item list ditekan
                  print('Tapped User ID: ${penggunaList[index].idUser}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
