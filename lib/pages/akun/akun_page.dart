import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/model/pengguna_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserDataPage extends StatefulWidget {
  final String userData;

  UserDataPage({required this.userData});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  PenggunaModel? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    Dio dio = Dio();
    try {
      final response = await dio.get('${urllokal}penggunas/${widget.userData}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        // Check if responseData is a list and handle accordingly
        if (responseData is List) {
          // Assuming the API returns a list with one object
          final firstItem = responseData.first;
          setState(() {
            userData = PenggunaModel.fromJson(firstItem);
          });
        } else if (responseData is Map<String, dynamic>) {
          // If responseData is directly an object
          setState(() {
            userData = PenggunaModel.fromJson(responseData);
          });
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ListTile(
                    title: Text('ID User'),
                    subtitle: Text(userData!.idUser.toString()),
                  ),
                  ListTile(
                    title: Text('Alamat'),
                    subtitle: Text(userData!.alamat),
                  ),
                  ListTile(
                    title: Text('Telepon'),
                    subtitle: Text(userData!.telepon),
                  ),
                  ListTile(
                    title: Text('Nomor Identifikasi'),
                    subtitle: Text(userData!.nomorIdentifikasi),
                  ),
                  ListTile(
                    title: Text('Jenis Pengguna'),
                    subtitle: Text(userData!.jenisPengguna),
                  ),
                  ListTile(
                    title: Text('Dibuat Pada'),
                    subtitle: Text(userData!.createdAt),
                  ),
                  ListTile(
                    title: Text('Diperbarui Pada'),
                    subtitle: Text(userData!.updatedAt),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk menangani tombol edit di sini
                      // Navigasi ke halaman edit atau tampilkan dialog edit
                      // Misalnya:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditUserDataPage(userData: userData!),
                        ),
                      );
                    },
                    child: Text('Edit Data Akun'),
                  ),
                ],
              ),
      ),
    );
  }
}

class EditUserDataPage extends StatefulWidget {
  final PenggunaModel? userData;

  EditUserDataPage({required this.userData});

  @override
  _EditUserDataPageState createState() => _EditUserDataPageState();
}

class _EditUserDataPageState extends State<EditUserDataPage> {
  late TextEditingController alamatController;
  late TextEditingController teleponController;
  // Add more controllers for other fields if needed

  @override
  void initState() {
    super.initState();
    alamatController = TextEditingController(text: widget.userData!.alamat);
    teleponController = TextEditingController(text: widget.userData!.telepon);
    // Initialize other controllers with current data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            TextFormField(
              controller: teleponController,
              decoration: InputDecoration(labelText: 'Telepon'),
            ),
            // Add more TextFormField for other fields if needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan perubahan data
                // Misalnya, mengirim perubahan data ke API
                // Setelah berhasil, kembali ke halaman sebelumnya
                // Contoh sederhana:
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    alamatController.dispose();
    teleponController.dispose();
    // Dispose other controllers if added
    super.dispose();
  }
}
