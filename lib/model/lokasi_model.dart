import 'dart:convert';

class Lokasi {
  int id;
  String namaLokasi;
  String alamat;
  double latitude;
  double longitude;
  String kontak;
  DateTime createdAt;
  DateTime updatedAt;

  Lokasi({
    required this.id,
    required this.namaLokasi,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.kontak,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Lokasi object from JSON data
  factory Lokasi.fromJson(Map<String, dynamic> json) {
    return Lokasi(
      id: json['id'],
      namaLokasi: json['nama_lokasi'],
      alamat: json['alamat'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      kontak: json['kontak'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a Lokasi object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_lokasi': namaLokasi,
      'alamat': alamat,
      'latitude': latitude,
      'longitude': longitude,
      'kontak': kontak,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Method to create a list of Lokasi objects from JSON data
  static List<Lokasi> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Lokasi.fromJson(json)).toList();
  }

  // Method to convert a list of Lokasi objects to JSON data
  static List<Map<String, dynamic>> listToJson(List<Lokasi> lokasis) {
    return lokasis.map((lokasi) => lokasi.toJson()).toList();
  }
}
