import 'dart:convert';

class Sampah {
  int id;
  String namaSampah;
  String keterangan;
  String jenis;
  String harga;
  DateTime createdAt;
  DateTime updatedAt;

  Sampah({
    required this.id,
    required this.namaSampah,
    required this.keterangan,
    required this.jenis,
    required this.harga,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Sampah object from JSON data
  factory Sampah.fromJson(Map<String, dynamic> json) {
    return Sampah(
      id: json['id'],
      namaSampah: json['nama_sampah'],
      keterangan: json['keterangan'],
      jenis: json['jenis'],
      harga: json['harga'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a Sampah object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_sampah': namaSampah,
      'keterangan': keterangan,
      'jenis': jenis,
      'harga': harga,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Method to create a list of Sampah objects from JSON data
  static List<Sampah> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Sampah.fromJson(json)).toList();
  }

  // Method to convert a list of Sampah objects to JSON data
  static List<Map<String, dynamic>> listToJson(List<Sampah> sampahs) {
    return sampahs.map((sampah) => sampah.toJson()).toList();
  }
}
