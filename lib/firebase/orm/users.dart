class Users {
  String? email;
  String? fullName;
  String? role;
}

class Petugas extends Users {
  String? alamat;
  String? jenisKelamin;
  String? nik;
  String? noHp;
  String? pengungsian;
  DateTime? tglLahir;

  Petugas(this.alamat, this.jenisKelamin, this.nik, this.noHp, this.pengungsian,
      this.tglLahir);
}

class Warga extends Users {
  String? alamat;
  String? id;
  String? jenisKelamin;
  int? keluarga;
  String? nik;
  String? noHp;
  String? occupied;
  bool? pulang;
  String? reserve;
  DateTime? tglLahir;

  Warga(this.alamat, this.id, this.jenisKelamin, this.keluarga, this.nik,
      this.noHp, this.occupied, this.pulang, this.reserve, this.tglLahir);
}
