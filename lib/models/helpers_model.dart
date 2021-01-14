
/*
 * Class Tujuan Dan Perintah Models Helper ----------------------------------------
 */
class TujuanNPerintah {
  List<DispPerintah> dispPerintah;
  Tujuan tujuan;

  TujuanNPerintah({this.dispPerintah, this.tujuan});

  TujuanNPerintah.fromJson(Map<String, dynamic> json) {
    if (json['disp_perintah'] != null) {
      dispPerintah = new List<DispPerintah>();
      json['disp_perintah'].forEach((v) {
        dispPerintah.add(new DispPerintah.fromJson(v));
      });
    }
    tujuan =
        json['tujuan'] != null ? new Tujuan.fromJson(json['tujuan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dispPerintah != null) {
      data['disp_perintah'] = this.dispPerintah.map((v) => v.toJson()).toList();
    }
    if (this.tujuan != null) {
      data['tujuan'] = this.tujuan.toJson();
    }
    return data;
  }
}

class DispPerintah {
  String idDispPerintah;
  String isiPerintah;
  String ket;

  DispPerintah({this.idDispPerintah, this.isiPerintah, this.ket});

  DispPerintah.fromJson(Map<String, dynamic> json) {
    idDispPerintah = json['id_disp_perintah'];
    isiPerintah = json['isi_perintah'];
    ket = json['ket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_disp_perintah'] = this.idDispPerintah;
    data['isi_perintah'] = this.isiPerintah;
    data['ket'] = this.ket;
    return data;
  }
}

class Tujuan {
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
  String idJabatan;
  String namaJabatan;
  String uraian;
  String kodeSurat;
  String levelJabatan;
  String parentJabatan;
  String idGol;
  String kodeGol;
  String namaGol;

  Tujuan(
      {this.idUser,
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
      this.idJabatan,
      this.namaJabatan,
      this.uraian,
      this.kodeSurat,
      this.levelJabatan,
      this.parentJabatan,
      this.idGol,
      this.kodeGol,
      this.namaGol});

  Tujuan.fromJson(Map<String, dynamic> json) {
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
    idJabatan = json['id_jabatan'];
    namaJabatan = json['nama_jabatan'];
    uraian = json['uraian'];
    kodeSurat = json['kode_surat'];
    levelJabatan = json['level_jabatan'];
    parentJabatan = json['parent_jabatan'];
    idGol = json['id_gol'];
    kodeGol = json['kode_gol'];
    namaGol = json['nama_gol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['id_jabatan'] = this.idJabatan;
    data['nama_jabatan'] = this.namaJabatan;
    data['uraian'] = this.uraian;
    data['kode_surat'] = this.kodeSurat;
    data['level_jabatan'] = this.levelJabatan;
    data['parent_jabatan'] = this.parentJabatan;
    data['id_gol'] = this.idGol;
    data['kode_gol'] = this.kodeGol;
    data['nama_gol'] = this.namaGol;
    return data;
  }
}

/*
 * Class Tujuan Dan Perintah Models Helper (ENDING) ----------------------------------------
 */