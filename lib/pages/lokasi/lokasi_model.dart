// Model untuk Lokasi
class LokasiModel {
  final String namaLokasi;
  final String alamat;
  final double latitude;
  final double longitude;
  final String kontak;

  LokasiModel({
    required this.namaLokasi,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.kontak,
  });

  factory LokasiModel.fromJson(Map<String, dynamic> json) {
    return LokasiModel(
      namaLokasi: json['nama_lokasi'],
      alamat: json['alamat'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      kontak: json['kontak'],
    );
  }
}
