import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/helpers_model.dart';
import 'package:pupr/ui/screens/surat_masuk/surat_tugas_create_1.dart';
import 'package:http/http.dart' as http;

class SuratTugasCreatePage extends StatefulWidget {
  final String dispSuratId;
  final String suratMasukId;
  final String suratMasusDispDetTujuanId;

  const SuratTugasCreatePage(
      {Key key, this.dispSuratId, this.suratMasusDispDetTujuanId, this.suratMasukId})
      : super(key: key);

  @override
  _SuratTugasCreatePageState createState() => _SuratTugasCreatePageState();
}

class _SuratTugasCreatePageState extends State<SuratTugasCreatePage> {
  DispPerintah dispPerintahValue = DispPerintah();
  List<DispPerintah> dispPerintahList = [];
  Tujuan tujuanValue;
  String catatan = '';

  bool isBerkas = false;

  @override
  void initState() {
    super.initState();

    getDataTujuanNPerintah();
  }

  void _submitDisposisi() async {
    //surat-tugas/'.$this->uri->segment(2).'/'.$this->uri->segment(3).'/insert
    // final result = await http.post('$url_api',
    //   headers: {
    //     HttpHeaders.authorizationHeader = 
    //   }
    // );
  }

  void getDataTujuanNPerintah() async {
    final result = await http.get(
        '$url_api/disposisi/${widget.dispSuratId}/${widget.suratMasusDispDetTujuanId}/add',
        headers: {HttpHeaders.acceptHeader: 'applications/json'});

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body)['data'];
      TujuanNPerintah tnp = TujuanNPerintah.fromJson(json);

      setState(() {
        dispPerintahValue = tnp.dispPerintah[0];
        dispPerintahList = tnp.dispPerintah;
        tujuanValue = tnp.tujuan;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Surat Laporan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Di Teruskan Kepada Sdr: ${tujuanValue !=null ? tujuanValue.namaLengkap: ''}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Dengan Hormat Harap :',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        DropdownButton<DispPerintah>(
                          isExpanded: true,
                          value: dispPerintahValue,
                          icon: Icon(null),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.green[900]),
                          underline: Container(
                            height: 2,
                            color: Colors.green,
                          ),
                          onChanged: (DispPerintah newValue) {
                            setState(() {
                              dispPerintahValue = newValue;
                            });
                          },
                          items: dispPerintahList.map((e) {
                            return DropdownMenuItem<DispPerintah>(
                              value: e,
                              child: Text('${e.isiPerintah}'),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              catatan = text;
                            });
                          },
                          maxLines: 8,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              hintText: "Masukan Catatan"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isBerkas = !isBerkas;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        isBerkas ? Colors.green : Colors.white,
                                    border: Border.all(
                                        width: 1.5, color: Colors.green)),
                                height: 15,
                                width: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Berkas Sesuai')
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            RaisedButton(
                              color: Colors.green,
                              onPressed: () {
                                if (isBerkas) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              SuratTugasCreate1Page(
                                                dispSuratId: widget.dispSuratId,
                                                suratMasusDispDetTujuanId: widget.suratMasusDispDetTujuanId,
                                                dispPerintahValue: dispPerintahValue,
                                                tujuanValue: tujuanValue,
                                                isBerkas: isBerkas,
                                                catatan: catatan,
                                                suratMasukId: widget.suratMasukId,
                                              )));
                                } else {
                                  _submitDisposisi();
                                }
                              },
                              child: Text(
                                '${isBerkas ? 'Selanjutnya' : 'Submit'}',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
