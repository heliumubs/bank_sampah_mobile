import 'package:bkash_ui/pages/edukasi_sampah/edukasi_sampah.dart';

class EdukasiSampahModel {
  final int id;
  final String judul;
  final String konten;
  final String kategori;
  final String penulis;
  final String createdAt;
  final String updatedAt;

  EdukasiSampahModel({
    required this.id,
    required this.judul,
    required this.konten,
    required this.kategori,
    required this.penulis,
    required this.createdAt,
    required this.updatedAt,
  });
  factory EdukasiSampahModel.fromJson(Map<String, dynamic> json) {
    return EdukasiSampahModel(
      id: json['id'],
      judul: json['judul'],
      konten: json['konten'],
      kategori: json['kategori'],
      penulis: json['penulis'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
