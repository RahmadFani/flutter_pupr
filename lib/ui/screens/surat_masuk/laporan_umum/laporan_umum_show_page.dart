import 'package:flutter/material.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';

import '../st_laporan_view.dart';
import 'laporan_umum_add_page.dart';

class LaporanUmuShowPage extends StatelessWidget {
  final SuratMasuk suratMasuk;

  const LaporanUmuShowPage({Key key, this.suratMasuk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Umum'),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(_) =>  LaporanUmumAddPage(isEdit: true, suratMasuk: suratMasuk)));
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keterangan.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${suratMasuk.keteranganLaporan}'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Foto Lapangan.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: List.generate(
                  suratMasuk.fotoLaporanCount,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ImgZoomWidgetPage(
                                      tag: 'lapangan-$index',
                                      urlImg:
                                          '$web_url/uploads/surat_laporan/${suratMasuk.fotoLaporan[index].file}',
                                    )));
                    },
                                      child: Hero(
                                        tag: 'lapangan-$index',
                                                                              child: Image.network(
                        '$web_url/uploads/surat_laporan/${suratMasuk.fotoLaporan[index].file}'),
                                      ),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
