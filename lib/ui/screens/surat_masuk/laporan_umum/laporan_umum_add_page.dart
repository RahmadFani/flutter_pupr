
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pupr/blocs/surat_masuk/surat_masuk_bloc.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LaporanUmumAddPage extends StatefulWidget {
  final bool isEdit;
  final SuratMasuk suratMasuk;

  const LaporanUmumAddPage({Key key, this.isEdit, this.suratMasuk}) : super(key: key);

  @override
  _LaporanUmumAddPageState createState() => _LaporanUmumAddPageState();
}

class _LaporanUmumAddPageState extends State<LaporanUmumAddPage> {

  TextEditingController textEditingController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
    @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController(
      text: widget.suratMasuk.keteranganLaporan
    );
  }

  void _onSubmit() async {
    try {
      // final result = await http.post('$url_api/laporan_umum', body: {
      //   'id': widget.suratMasuk.idDispDetailTujuan,
      //   'keterangan': textEditingController.text,
      //   'is_edit': widget.isEdit ? '1': '0'
      // });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      var uri = Uri.parse('$url_api/laporan_umum');
      var request = http.MultipartRequest('POST', uri)
        ..fields['id'] = widget.suratMasuk.idDispDetailTujuan
        ..fields['keterangan'] = textEditingController.text
        ..fields['is_edit'] = widget.isEdit ? '1':'0';
      for (var file in fotoLaporan) {
        request.files.add(await http.MultipartFile.fromPath('foto_laporan[]', file.path));
      }

      request.headers.addAll(
        {
          HttpHeaders.acceptHeader: 'applications/json',
          HttpHeaders.authorizationHeader: token
        }
      );

      final result = await request.send();

      if (result.statusCode == 200) {
        result.stream.transform(utf8.decoder).listen((event) {
            print(event);
            BlocProvider.of<SuratMasukBloc>(context).add(LoadSuratMasuk());
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      log(e.toString());
       _scaffold.currentState.showSnackBar(
              SnackBar(
                  behavior: SnackBarBehavior.floating,
                content:Text( 'Gagal Menambahkan Data..'),
              action: SnackBarAction(label: 'close', onPressed: () {
                _scaffold.currentState.hideCurrentSnackBar();
              }),)
            );
    }
  }

  List<File> fotoLaporan = [];

  void _onPilihFoto() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('${widget.isEdit ? 'Edit': 'Buat'} Laporan Umum'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor
                    )
                  ),
                  alignLabelWithHint: true,
                  labelText: 'Laporan Kegiatan',
                  hintText: 'Masukan Laporan Kegiatan Anda'
                ),
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                
                height: 50,
                              child: RaisedButton(
                                
                                color: Colors.teal,
                  onPressed: _onPilihFoto,
                  child: Text('Pilih Foto', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              fotoLaporan.length > 0 ? Text('Terpilih ${fotoLaporan.length} File') :SizedBox(),
              SizedBox(
                height: 10,
              ),
              Text('Maks. 2', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              
              SizedBox(
                width: double.infinity,
                
                height: 50,
                              child: RaisedButton(
                                
                                color: Theme.of(context).primaryColor,
                  onPressed: _onSubmit,
                  child: Text('${widget.isEdit ? 'Ubah': 'Tambah'}', style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),);
  }
}