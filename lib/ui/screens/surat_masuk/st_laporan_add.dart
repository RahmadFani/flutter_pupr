import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pupr/blocs/surat_masuk/surat_masuk_bloc.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:http/http.dart' as http;

class STLaporanAdd extends StatefulWidget {
  final SuratMasuk suratMasuk;

  const STLaporanAdd({Key key, @required this.suratMasuk}) : super(key: key);
  @override
  _STLaporanCreateState createState() => _STLaporanCreateState();
}

class _STLaporanCreateState extends State<STLaporanAdd> {
  bool isEdit = false;
  bool isLoading = false;
  List<File> fotoLaporan = [];
  File bapl;

  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController progres = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkingInitial();
  }

  @override
  void dispose() {
    nama.dispose();
    alamat.dispose();
    progres.dispose();
    super.dispose();
  }

  void checkingInitial() {
    if (widget.suratMasuk.statusLaporan == '1') {
      setState(() {
        isEdit = true;
        nama.text = widget.suratMasuk.nama;
        alamat.text = widget.suratMasuk.alamat;
        progres.text = widget.suratMasuk.progres;
      });
    }
  }

  void _pickBapl() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);

    if (result != null) {
      File file = File(result.files.single.path);
      setState(() {
        bapl = file;
      });
    } else {
      // User canceled the picker
    }
  }

  void _pickImgLaporan() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowCompression: true, type: FileType.image, allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      setState(() {
        fotoLaporan = files.take(2).toList();
      });
    } else {
      // User canceled the picker
    }
  }

  void _simpanLaporan() async {
    setState(() {
      isLoading = true;
    });
    try {
      var uri = Uri.parse('$url_api/laporan');
      var request = http.MultipartRequest('POST', uri)
        ..fields['bapl_id'] = widget.suratMasuk.baplId
        ..fields['id'] = widget.suratMasuk.idDispDetailTujuan
        ..fields['nama'] = nama.text
        ..fields['alamat'] = alamat.text
        ..fields['progres'] = progres.text
        ..fields['is_edit'] = isEdit ? '1' : '0';
      if (bapl != null) {
        request.files.add(await http.MultipartFile.fromPath('bapl', bapl.path));
      }

      for (var file in fotoLaporan) {
        request.files.add(
            await http.MultipartFile.fromPath('foto_lapangan[]', file.path));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((event) {
          print(event);
          BlocProvider.of<SuratMasukBloc>(context).add(LoadSuratMasuk());
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${isEdit ? 'Edit' : 'Buat'} Laporan'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Simpan',
              onPressed: _simpanLaporan),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nama,
                        decoration: InputDecoration(
                            labelText: 'Nama',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                            hintText: 'Masukan Nama'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: alamat,
                        decoration: InputDecoration(
                            labelText: 'Alamat',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                            hintText: 'Masukan Alamat'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: progres,
                        decoration: InputDecoration(
                            labelText: 'Progres',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                            hintText: 'Masukan Progres'),
                      ),
                      fotoLaporan.length > 0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 120,
                                  child: GridView.count(
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2,
                                      children: List.generate(
                                          fotoLaporan.length, (index) {
                                        return Container(
                                          height: 100,
                                          child: Image.file(
                                            fotoLaporan[index],
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      })),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: _pickImgLaporan,
                          child: Text(
                            'Pilih Foto Laporan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '* maks.2',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      bapl != null
                          ? Column(
                              children: [
                                Text(
                                  'File BAPL : ${bapl.path}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: _pickBapl,
                          child: Text(
                            'Pilih BAPL',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '* Type Document',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: SpinKitDualRing(color: Colors.green),
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
