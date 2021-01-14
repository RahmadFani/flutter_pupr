
class UserModel {
  String token;
  String idUser;
  String nip;
  String namaLengkap;
  String golongan;
  String jabatan;
  String alamat;
  String noTelp;
  String email;
  String username;
  String password;
  String levelUser;
  String levelJabatan;

  UserModel(
      {this.token,
      this.idUser,
      this.nip,
      this.namaLengkap,
      this.golongan,
      this.jabatan,
      this.alamat,
      this.noTelp,
      this.email,
      this.username,
      this.password,
      this.levelUser,
      this.levelJabatan});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    idUser = json['id_user'];
    nip = json['nip'];
    namaLengkap = json['nama_lengkap'];
    golongan = json['golongan'];
    jabatan = json['jabatan'];
    alamat = json['alamat'];
    noTelp = json['no_telp'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    levelUser = json['level_user'];
    levelJabatan = json['level_jabatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id_user'] = this.idUser;
    data['nip'] = this.nip;
    data['nama_lengkap'] = this.namaLengkap;
    data['golongan'] = this.golongan;
    data['jabatan'] = this.jabatan;
    data['alamat'] = this.alamat;
    data['no_telp'] = this.noTelp;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['level_user'] = this.levelUser;
    data['level_jabatan'] = this.levelJabatan;
    return data;
  }
}