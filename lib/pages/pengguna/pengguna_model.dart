// Model untuk Pengguna
class UserModel {
  final int id;
  final String idUser;
  final String alamat;
  final String telepon;
  final String nomorIdentifikasi;
  final String jenisPengguna;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.idUser,
    required this.alamat,
    required this.telepon,
    required this.nomorIdentifikasi,
    required this.jenisPengguna,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      idUser: json['id_user'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      nomorIdentifikasi: json['nomor_identifikasi'],
      jenisPengguna: json['jenis_pengguna'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
