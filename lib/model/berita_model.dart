class Koin {
  final int id;
  final int penggunaId;
  final String status;
  final String tglIn;
  final String jumlah;
  final String createdAt;
  final String updatedAt;

  Koin({
    required this.id,
    required this.penggunaId,
    required this.status,
    required this.tglIn,
    required this.jumlah,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Koin.fromJson(Map<String, dynamic> json) {
    return Koin(
      id: json['id'] ?? "",
      penggunaId: json['pengguna_id'] ?? "",
      status: json['status'] ?? "",
      tglIn: json['tgl_in'] ?? "",
      jumlah: json['jumlah'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
