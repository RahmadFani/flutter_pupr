import 'package:flutter/material.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:pupr/ui/screens/surat_masuk/st_laporan_add.dart';
import 'package:url_launcher/url_launcher.dart';

class STLaporanViewPage extends StatelessWidget {
  final SuratMasuk suratMasuk;

  const STLaporanViewPage({Key key, this.suratMasuk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No. ${suratMasuk.noSurat}'),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit Laporan',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => STLaporanAdd(
                              suratMasuk: suratMasuk,
                            )));
              })
        ],
      ),
      body: SizedBox.expand(
          child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Text(
                'Nama : ${suratMasuk.nama}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Alamat : ${suratMasuk.alamat}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Progres : ${suratMasuk.progres}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'BAPL.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: suratMasuk.baplId != null && suratMasuk.baplId != '0'
                    ? () async {
                        final url =
                            '$web_url/uploads/surat_bapl/${suratMasuk.baplId}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    : null,
                child: Container(
                  child: Text(
                    '${suratMasuk.baplId != null && suratMasuk.baplId != '0' ? suratMasuk.baplId : 'Tidak Ada BAPL.'}',
                    style: TextStyle(
                        fontSize: 15,
                        color: suratMasuk.baplId != null &&
                                suratMasuk.baplId != '0'
                            ? Colors.blue
                            : Colors.grey,
                        fontWeight: suratMasuk.baplId != null &&
                                suratMasuk.baplId != '0'
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
               suratMasuk.sesuai == '0' ?
                Column(
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
                  ],
                ) : SizedBox(),
                SizedBox(height:10),
              Text(
                'Foto Laporan.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              suratMasuk.fotoLaporanCount > 0
                  ? SizedBox.shrink()
                  : Text(
                      'Tidak Ada Foto',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
             
              
            ]),),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
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
                          '$web_url/uploads/surat_laporan/${suratMasuk.fotoLaporan[index].file}',
                          fit: BoxFit.cover,
                        ),
                      ));
                },
                childCount: suratMasuk.fotoLaporanCount,
              ),
            ),
          )
        ],
      )),
    );
  }
}

class ImgZoomWidgetPage extends StatelessWidget {
  final String tag;
  final String urlImg;

  const ImgZoomWidgetPage({Key key, this.tag, this.urlImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Hero(
            tag: tag,
            child: InteractiveViewer(
              constrained: true,
              child: Image.network(
                '$urlImg',
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}
