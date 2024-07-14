import 'package:bkash_ui/pages/edukasi_sampah/edukasi_model.dart';
import 'package:flutter/material.dart';

class DetailContentPage extends StatelessWidget {
  final EdukasiSampahModel content;

  DetailContentPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content.judul),
        backgroundColor:
            Colors.green, // Ubah warna latar belakang appbar sesuai kebutuhan
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori: ${content.kategori}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Penulis: ${content.penulis}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Dibuat pada: ${content.createdAt}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              content.konten,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
