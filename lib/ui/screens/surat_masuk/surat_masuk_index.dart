import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pupr/blocs/surat_masuk/surat_masuk_bloc.dart';
import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:pupr/ui/screens/surat_masuk/laporan_umum/laporan_umum_add_page.dart';
import 'package:pupr/ui/screens/surat_masuk/laporan_umum/laporan_umum_show_page.dart';
import 'package:pupr/ui/screens/surat_masuk/st_laporan_add.dart';
import 'package:pupr/ui/screens/surat_masuk/st_laporan_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SuratMasukIndexPage extends StatefulWidget {
  @override
  _SuratMasukIndexPageState createState() => _SuratMasukIndexPageState();
}

class _SuratMasukIndexPageState extends State<SuratMasukIndexPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _launchFileURL(String fileName) async {
    final url = '$web_url/uploads/surat_masuk/$fileName';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchSuratTugas(String id) async {
    final url = '$web_url/surat-tugas/$id/surat-tugas-doc';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onRefresh(context) async {
    BlocProvider.of<SuratMasukBloc>(context).add(LoadSuratMasuk());
  }

  void initial(context) {
    final state = BlocProvider.of<SuratMasukBloc>(context).state;
    if (state is SuratMasukInitial) {
      BlocProvider.of<SuratMasukBloc>(context).add(LoadSuratMasuk());
    }
  }

  @override
  Widget build(BuildContext context) {
    initial(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Surat Masuk'),
        ),
        body:
            BlocConsumer<SuratMasukBloc, SuratMasukState>(
                listener: (_, state) {
                  if (state is SuratMasukLoaded) {
                    _refreshController.refreshCompleted();
                  }
                },
              builder: (ctx, state) {
          if (state is SuratMasukLoaded) {
            return SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: () => _onRefresh(context),
                          child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.listSuratMasuk.total,
                itemBuilder: (_, index) {
                  SuratMasuk suratMasuk = state.listSuratMasuk.list[index];

                  return Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No.Surat : ${suratMasuk.noSurat}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Pengirim : ${suratMasuk.pengirim}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Perihal : ${suratMasuk.perihal}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Isi Ringkas: ${suratMasuk.isiRingkas}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  'File : ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                suratMasuk.fileSurat == ''
                                    ? Text('-')
                                    : InkWell(
                                        onTap: () =>
                                            _launchFileURL(suratMasuk.fileSurat),
                                        child: Container(
                                          child: Text(
                                            'Open File',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            suratMasuk.disposSurat != null &&
                                    int.parse(suratMasuk.disposSurat.status) >=
                                        1 &&
                                    suratMasuk.disposSurat.file1 != null &&
                                    suratMasuk.disposSurat.file2 != null
                                ? Wrap(
                                    spacing: 5,
                                    children: [
                                      RaisedButton(
                                        onPressed: () => _launchSuratTugas(
                                            suratMasuk.disposSurat.id),
                                        color: Colors.green,
                                        child: Text(
                                          'Lihat Surat Tugas',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      suratMasuk.namaKategori != 'UMUM'
                                          ? suratMasuk.statusLaporan == '0'
                                              ? RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                STLaporanAdd(
                                                                  suratMasuk:
                                                                      suratMasuk,
                                                                )));
                                                  },
                                                  color: Colors.redAccent,
                                                  child: Text(
                                                    'Buat Laporan',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                STLaporanViewPage(
                                                                  suratMasuk:
                                                                      suratMasuk,
                                                                )));
                                                  },
                                                  color: Colors.blueGrey,
                                                  child: Text(
                                                    'Lihat Laporan',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                          : SizedBox(),
                                    ],
                                  )
                                : suratMasuk.statusLaporan == '0'
                                    ? RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LaporanUmumAddPage(
                                                        isEdit: false,
                                                        suratMasuk: suratMasuk
                                                      )));
                                        },
                                        color: Colors.brown,
                                        child: Text(
                                          'Buat Laporan Umum',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                    : RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LaporanUmuShowPage(
                                                        suratMasuk: suratMasuk
                                                      )));
                                        },
                                        color: Colors.brown,
                                        child: Text(
                                          'Lihat Laporan Umum',
                                          style: TextStyle(color: Colors.white),
                                        ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SpinKitRing(color: Colors.green),
            ),
          );
        }));
  }
}
