class ListSuratMasuk {
  int total;
  List<SuratMasuk> list;

  ListSuratMasuk({this.total, this.list});

  ListSuratMasuk.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<SuratMasuk>();
      json['list'].forEach((v) {
        list.add(new SuratMasuk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuratMasuk {
  String idDisposisi;
  String inputTeruskan;
  String catatan;
  String idSuratIn;
  String userInput;
  String noAgenda;
  String kategori;
  String inputPengirim;
  String pengirim;
  String noSurat;
  String tglSurat;
  String keteranganLaporan;
  String perihal;
  String isiRingkas;
  String fileSurat;
  String sifatSurat;
  String keterangan;
  String tglCatat;
  String idKategori;
  String kodeKategori;
  String namaKategori;
  String uraian;
  String idDispDetailTujuan;
  String idJabatan;
  String idUser;
  String statusLaporan;
  String baplId;
  String progres;
  String nama;
  String alamat;
  Null parent;
  String statusBaca;
  String statusSelesai;
  DisposSurat disposSurat;
  List<Skbapl> skbapl;
  List<FotoLaporan> fotoLaporan;
  int fotoLaporanCount;
  String sesuai;

  SuratMasuk(
      {this.idDisposisi,
      this.inputTeruskan,
      this.catatan,
      this.idSuratIn,
      this.userInput,
      this.noAgenda,
      this.kategori,
      this.inputPengirim,
      this.pengirim,
      this.noSurat,
      this.tglSurat,
      this.perihal,
      this.isiRingkas,
      this.fileSurat,
      this.sifatSurat,
      this.keterangan,
      this.tglCatat,
      this.idKategori,
      this.kodeKategori,
      this.namaKategori,
      this.uraian,
      this.idDispDetailTujuan,
      this.idJabatan,
      this.idUser,
      this.statusLaporan,
      this.baplId,
      this.progres,
      this.nama,
      this.alamat,
      this.parent,
      this.statusBaca,
      this.statusSelesai,
      this.keteranganLaporan,
      this.disposSurat,
      this.sesuai,
      this.skbapl,
      this.fotoLaporan,
      this.fotoLaporanCount});

  SuratMasuk.fromJson(Map<String, dynamic> json) {
    idDisposisi = json['id_disposisi'];
    inputTeruskan = json['input_teruskan'];
    sesuai = json['sesuai'];
    keteranganLaporan = json['keterangan_laporan'];
    catatan = json['catatan'];
    idSuratIn = json['id_surat_in'];
    userInput = json['user_input'];
    noAgenda = json['no_agenda'];
    kategori = json['kategori'];
    inputPengirim = json['input_pengirim'];
    pengirim = json['pengirim'];
    noSurat = json['no_surat'];
    tglSurat = json['tgl_surat'];
    perihal = json['perihal'];
    isiRingkas = json['isi_ringkas'];
    fileSurat = json['file_surat'];
    sifatSurat = json['sifat_surat'];
    keterangan = json['keterangan'];
    tglCatat = json['tgl_catat'];
    idKategori = json['id_kategori'];
    kodeKategori = json['kode_kategori'];
    namaKategori = json['nama_kategori'];
    uraian = json['uraian'];
    idDispDetailTujuan = json['id_disp_detail_tujuan'] ?? '';
    idJabatan = json['id_jabatan'];
    idUser = json['id_user'];
    statusLaporan = json['status_laporan'];
    baplId = json['bapl_id'] ?? '';
    progres = json['progres'];
    nama = json['nama'];
    alamat = json['alamat'];
    parent = json['parent'];
    statusBaca = json['status_baca'];
    statusSelesai = json['status_selesai'];
    disposSurat = json['dispos_surat'] != null
        ? new DisposSurat.fromJson(json['dispos_surat'])
        : null;
    if (json['skbapl'] != null) {
      skbapl = new List<Skbapl>();
      json['skbapl'].forEach((v) {
        skbapl.add(new Skbapl.fromJson(v));
      });
    }
    if (json['foto_laporan'] != null) {
      fotoLaporan = new List<FotoLaporan>();
      json['foto_laporan'].forEach((v) {
        fotoLaporan.add(new FotoLaporan.fromJson(v));
      });
    }
    fotoLaporanCount = json['foto_laporan_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_disposisi'] = this.idDisposisi;
    data['input_teruskan'] = this.inputTeruskan;
    data['catatan'] = this.catatan;
    data['id_surat_in'] = this.idSuratIn;
    data['user_input'] = this.userInput;
    data['no_agenda'] = this.noAgenda;
    data['kategori'] = this.kategori;
    data['input_pengirim'] = this.inputPengirim;
    data['pengirim'] = this.pengirim;
    data['no_surat'] = this.noSurat;
    data['tgl_surat'] = this.tglSurat;
    data['perihal'] = this.perihal;
    data['isi_ringkas'] = this.isiRingkas;
    data['file_surat'] = this.fileSurat;
    data['sifat_surat'] = this.sifatSurat;
    data['keterangan'] = this.keterangan;
    data['tgl_catat'] = this.tglCatat;
    data['id_kategori'] = this.idKategori;
    data['kode_kategori'] = this.kodeKategori;
    data['nama_kategori'] = this.namaKategori;
    data['uraian'] = this.uraian;
    data['id_disp_detail_tujuan'] = this.idDispDetailTujuan;
    data['id_jabatan'] = this.idJabatan;
    data['id_user'] = this.idUser;
    data['status_laporan'] = this.statusLaporan;
    data['bapl_id'] = this.baplId;
    data['progres'] = this.progres;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['parent'] = this.parent;
    data['status_baca'] = this.statusBaca;
    data['status_selesai'] = this.statusSelesai;
    if (this.disposSurat != null) {
      data['dispos_surat'] = this.disposSurat.toJson();
    }
    if (this.skbapl != null) {
      data['skbapl'] = this.skbapl.map((v) => v.toJson()).toList();
    }
    if (this.fotoLaporan != null) {
      data['foto_laporan'] = this.fotoLaporan.map((v) => v.toJson()).toList();
    }
    data['foto_laporan_count'] = this.fotoLaporanCount;
    return data;
  }
}

class DisposSurat {
  String idDisposisi;
  String inputTeruskan;
  String catatan;
  String idSuratIn;
  String userInput;
  String idUser;
  String tandaTangan;
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
  String noAgenda;
  String kategori;
  String inputPengirim;
  String pengirim;
  String noSurat;
  String tglSurat;
  String perihal;
  String isiRingkas;
  String fileSurat;
  String sifatSurat;
  String keterangan;
  String tglCatat;
  String id;
  String disposisiId;
  String pegawaiId;
  String status;
  String dataPemohonId;
  String file1;
  String file2;
  String tanggal;
  String tanggalAkhir;

  DisposSurat(
      {this.idDisposisi,
      this.inputTeruskan,
      this.catatan,
      this.idSuratIn,
      this.userInput,
      this.idUser,
      this.tandaTangan,
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
      this.noAgenda,
      this.kategori,
      this.inputPengirim,
      this.pengirim,
      this.noSurat,
      this.tglSurat,
      this.perihal,
      this.isiRingkas,
      this.fileSurat,
      this.sifatSurat,
      this.keterangan,
      this.tglCatat,
      this.id,
      this.disposisiId,
      this.pegawaiId,
      this.status,
      this.dataPemohonId,
      this.file1,
      this.file2,
      this.tanggal,
      this.tanggalAkhir});

  DisposSurat.fromJson(Map<String, dynamic> json) {
    idDisposisi = json['id_disposisi'];
    inputTeruskan = json['input_teruskan'];
    catatan = json['catatan'];
    idSuratIn = json['id_surat_in'];
    userInput = json['user_input'];
    idUser = json['id_user'];
    tandaTangan = json['tanda_tangan'];
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
    noAgenda = json['no_agenda'];
    kategori = json['kategori'];
    inputPengirim = json['input_pengirim'];
    pengirim = json['pengirim'];
    noSurat = json['no_surat'];
    tglSurat = json['tgl_surat'];
    perihal = json['perihal'];
    isiRingkas = json['isi_ringkas'];
    fileSurat = json['file_surat'];
    sifatSurat = json['sifat_surat'];
    keterangan = json['keterangan'];
    tglCatat = json['tgl_catat'];
    id = json['id'];
    disposisiId = json['disposisi_id'];
    pegawaiId = json['pegawai_id'];
    status = json['status'];
    dataPemohonId = json['data_pemohon_id'];
    file1 = json['file_1'];
    file2 = json['file_2'];
    tanggal = json['tanggal'];
    tanggalAkhir = json['tanggal_akhir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_disposisi'] = this.idDisposisi;
    data['input_teruskan'] = this.inputTeruskan;
    data['catatan'] = this.catatan;
    data['id_surat_in'] = this.idSuratIn;
    data['user_input'] = this.userInput;
    data['id_user'] = this.idUser;
    data['tanda_tangan'] = this.tandaTangan;
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
    data['no_agenda'] = this.noAgenda;
    data['kategori'] = this.kategori;
    data['input_pengirim'] = this.inputPengirim;
    data['pengirim'] = this.pengirim;
    data['no_surat'] = this.noSurat;
    data['tgl_surat'] = this.tglSurat;
    data['perihal'] = this.perihal;
    data['isi_ringkas'] = this.isiRingkas;
    data['file_surat'] = this.fileSurat;
    data['sifat_surat'] = this.sifatSurat;
    data['keterangan'] = this.keterangan;
    data['tgl_catat'] = this.tglCatat;
    data['id'] = this.id;
    data['disposisi_id'] = this.disposisiId;
    data['pegawai_id'] = this.pegawaiId;
    data['status'] = this.status;
    data['data_pemohon_id'] = this.dataPemohonId;
    data['file_1'] = this.file1;
    data['file_2'] = this.file2;
    data['tanggal'] = this.tanggal;
    data['tanggal_akhir'] = this.tanggalAkhir;
    return data;
  }
}

class Skbapl {
  String id;
  String dispDetailId;
  String file;

  Skbapl({this.id, this.dispDetailId, this.file});

  Skbapl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dispDetailId = json['disp_detail_id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['disp_detail_id'] = this.dispDetailId;
    data['file'] = this.file;
    return data;
  }
}

class FotoLaporan {
  String id;
  String dispDetailId;
  String file;

  FotoLaporan({this.id, this.dispDetailId, this.file});

  FotoLaporan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dispDetailId = json['disp_detail_id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['disp_detail_id'] = this.dispDetailId;
    data['file'] = this.file;
    return data;
  }
}