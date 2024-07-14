class TransaksiModel {
  final int penggunaId;
  final int sampahId;
  final double kuantitas;
  final double nilai;
  final String createdAt;
  final String updatedAt;

  TransaksiModel({
    required this.penggunaId,
    required this.sampahId,
    required this.kuantitas,
    required this.nilai,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
      penggunaId: json['pengguna_id'] ?? "",
      sampahId: json['sampah_id'] ?? "",
      kuantitas: double.parse(json['kuantitas'] ?? "0"),
      nilai: double.parse(json['nilai'] ?? "0"),
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
