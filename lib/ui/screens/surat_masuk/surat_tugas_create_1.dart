import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pupr/blocs/authentication/authentication_bloc.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/helpers_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SuratTugasCreate1Page extends StatefulWidget {
  final String suratMasukId;
  final String dispSuratId;
  final String suratMasusDispDetTujuanId;
  final DispPerintah dispPerintahValue;
  final Tujuan tujuanValue;
  final bool isBerkas;
  final String catatan;

  const SuratTugasCreate1Page(
      {Key key,
      this.dispSuratId,
      this.suratMasusDispDetTujuanId,
      this.dispPerintahValue,
      this.tujuanValue,
      this.isBerkas, this.suratMasukId, this.catatan})
      : super(key: key);

  @override
  _SuratTugasCreate1PageState createState() => _SuratTugasCreate1PageState();
}

class _SuratTugasCreate1PageState extends State<SuratTugasCreate1Page> {
  String dropdownValue = 'imb baru';

  String fungsiBangunan = '';
  String guanBangunan = '';
  String fungsiJalan = '';
  String zonasi = '';
  String jenisBangunan = '';
  String bangunan_1_2 = '';
  String teras_1_2 = '';
  String jalanMasuk = '';
  String pagardsb = '';
  String kemajuanFisikBangunan = '';
  String luasTanahDimaksud = '';
  String luasTanahTerpotongGsp = '';
  String sisaLuasTanah = '';

  bool isLoading = false;

  void _onSubmit() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final user = (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated );
    try {

      List<String> tujuans = [
        '${widget.tujuanValue.idUser}'
      ];

      List<String> perintahs = [
        '${widget.dispPerintahValue.idDispPerintah}'
      ];

     final String jsonData = json.encode(
        {
        'tipe_imb': dropdownValue,
        'fungsi_bangunan': fungsiBangunan,
        'guna_bangunan': guanBangunan,
        'fungsi_jalan': fungsiJalan,
        'zonasi' : zonasi,
        'jenis_bangunan': jenisBangunan,
        'bangunan_1_2' : bangunan_1_2,
        'teras_1_2': teras_1_2,
        'jalan_masuk': jalanMasuk,
        'pagar_d_s_b': pagardsb,
        'pegawai_id': '',
        'id_surat_masuk': widget.suratMasukId,
        'k_f_bangunan': kemajuanFisikBangunan,
        'lt_dimaksud' : luasTanahDimaksud,
        'lt_terpotong_gsp' : luasTanahTerpotongGsp,
        'sisa_luas_tanah': sisaLuasTanah,
        'tujuan': tujuans,
        'berkas_sesuai': '1',
        'id_disp_detail_tujuan': widget.suratMasusDispDetTujuanId,
        'user_id': '${user.user.idUser}',
        'input_teruskan': '1',
        'catatan': widget.catatan,
        'id_surat_in': widget.suratMasukId,
        'perintah': perintahs
        }
      );



    final result = await http.post('$url_api/disposisi/${widget.dispSuratId}/${widget.suratMasusDispDetTujuanId}/add',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',

      },
      body:  jsonData
    );

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      log(json.toString());
    } else {
       final json = jsonDecode(result.body);
      print(json.toString());
    }
    } catch (e) {
      log(e.toString());
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
        title: Text('Buat Surat Laporan BAPL'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Tipe IMB*',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: null,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.green[900]),
                    underline: Container(
                      height: 2,
                      color: Colors.green,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'imb baru',
                      'imb lama',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        fungsiBangunan = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Fungsi Bangunan',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        guanBangunan = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Guna Bangunan',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        fungsiJalan = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Fungsi Jalan',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        zonasi = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Zonasi',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        jenisBangunan = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Jenis Bangunan',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        bangunan_1_2 = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Bangunan(1+2)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        teras_1_2 = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Teras(1+2)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        jalanMasuk = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Jalan Masuk',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        pagardsb = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Pagar (D+S+B)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        kemajuanFisikBangunan = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Kemajuan Fisik Bangunan',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        luasTanahDimaksud = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Luas Tanah Dimaksud',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        luasTanahTerpotongGsp = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Luas Tanah Terpotong gsp',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      setState(() {
                        sisaLuasTanah = text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Sisa Luas Tanah',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: _onSubmit,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
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
