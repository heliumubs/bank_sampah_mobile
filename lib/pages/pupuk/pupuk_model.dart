// Ganti dengan model PupukModel yang sesuai dengan struktur data dari API
class PupukModel {
  final int id;
  final String nama;
  final String jenis;
  final String deskripsi;
  final String fungsi;
  final DateTime updatedAt;
  final DateTime createdAt;

  PupukModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.deskripsi,
    required this.fungsi,
    required this.updatedAt,
    required this.createdAt,
  });

  factory PupukModel.fromJson(Map<String, dynamic> json) {
    return PupukModel(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
      deskripsi: json['deskripsi'],
      fungsi: json['fungsi'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
