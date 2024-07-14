// Model untuk jenis sampah
class JenisSampahModel {
  final String name;
  final String description;

  JenisSampahModel({
    required this.name,
    required this.description,
  });

  factory JenisSampahModel.fromJson(Map<String, dynamic> json) {
    return JenisSampahModel(
      name: json['nama'],
      description: json['deskripsi'],
    );
  }
}
