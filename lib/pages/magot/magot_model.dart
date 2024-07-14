// Model untuk Magot
class Magot {
  final int id;
  final String nama;
  final String jenis;
  final String deskripsi;
  final DateTime updatedAt;
  final DateTime createdAt;

  Magot({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.deskripsi,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Magot.fromJson(Map<String, dynamic> json) {
    return Magot(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
      deskripsi: json['deskripsi'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
