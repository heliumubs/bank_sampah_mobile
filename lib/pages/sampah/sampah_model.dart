// Model untuk SampahModel
class SampahModel {
  final String namaSampah;
  final String keterangan;
  final String jenis;
  final String harga;

  SampahModel({
    required this.namaSampah,
    required this.keterangan,
    required this.jenis,
    required this.harga,
  });

  factory SampahModel.fromJson(Map<String, dynamic> json) {
    return SampahModel(
      namaSampah: json['nama_sampah'],
      keterangan: json['keterangan'],
      jenis: json['jenis'],
      harga: json['harga'],
    );
  }
}
