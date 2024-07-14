// Model untuk Koin
class KoinModel {
  final int id;
  final int penggunaId;
  final String jumlah;
  final String status;
  final String tglIn;

  KoinModel({
    required this.id,
    required this.penggunaId,
    required this.jumlah,
    required this.status,
    required this.tglIn,
  });

  factory KoinModel.fromJson(Map<String, dynamic> json) {
    return KoinModel(
      id: json['id'],
      penggunaId: json['pengguna_id'],
      jumlah: json['jumlah'],
      status: json['status'],
      tglIn: json['tgl_in'],
    );
  }
}
