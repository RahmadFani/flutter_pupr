// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pupr/blocs/surat_masuk/surat_masuk_bloc.dart';
// import 'package:pupr/helpers/api.dart';
// import 'package:pupr/models/surat_masuk.dart';
// import 'package:pupr/ui/screens/surat_masuk/surat_tugas_create.dart';
// import 'package:url_launcher/url_launcher.dart';

// class OLDSuratMasukIndexPage extends StatelessWidget {

//   void _launchFileURL(String fileName) async {
//     final url = '$web_url/uploads/surat_masuk/$fileName';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void _launchSuratTugas(String id) async {
//     final url = '$web_url/surat-tugas/$id/surat-tugas-doc';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void _launchSuratSkBapl(String id1, String id2) async {
//     final url = '$web_url/surat-tugas/$id1/$id2/laporan-sk-bapl';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Surat Masuk'),
//         ),
//         body:
//             BlocBuilder<SuratMasukBloc, SuratMasukState>(builder: (ctx, state) {
//           if (state is SuratMasukLoaded) {
//             return ListView.builder(
//               padding: EdgeInsets.all(10),
//               itemCount: state.listSuratMasuk.total,
//               itemBuilder: (_, index) {
//                 SuratMasuk suratMasuk = state.listSuratMasuk.list[index];
//                 return Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 5,
//                         child: Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'No.Surat : ${suratMasuk.noSurat}',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 'Pengirim : ${suratMasuk.pengirim}',
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Perihal : ${suratMasuk.perihal}',
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Isi Ringkas: ${suratMasuk.isiRingkas}',
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'File : ',
//                                     style: TextStyle(fontWeight: FontWeight.w600),
//                                   ),
//                                   suratMasuk.fileSurat == '' ? Text('-') :
//                                   InkWell(
//                                     onTap: () => _launchFileURL(suratMasuk.fileSurat),
//                                     child: Container(
//                                       child: Text('Open File', style: TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold
//                                       ),),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Divider(),
//                               Wrap(
//                                 spacing: 5,
//                                 children: [
//                                   suratMasuk.disposSurat != null && suratMasuk.disposSurat.file1 != '' && suratMasuk.disposSurat.file2 != null ?
//                                   RaisedButton(
//                                     elevation: 4,
//                                     onPressed: () => _launchSuratTugas(suratMasuk.disposSurat.id),
//                                     color: Colors.green,
//                                     child: Text(
//                                       'Lihat Surat Tugas',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ) : SizedBox.shrink(),

//                                   suratMasuk.skbapl != null && suratMasuk.skbapl.statusLaporan != '0' ? RaisedButton(
//                                     elevation: 4,
//                                     onPressed: () => _launchSuratSkBapl(suratMasuk.skbapl.idSuratIn, suratMasuk.skbapl.idDispDetailTujuan),
//                                     color: Colors.blue,
//                                     child: Text(
//                                       'Lihat SK&BAPL',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ) : suratMasuk.disposSurat != null ? RaisedButton(
//                                     elevation: 4,
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) =>
//                                                   SuratTugasCreatePage(
//                                                     suratMasukId: suratMasuk.idSuratIn,
//                                                     dispSuratId: suratMasuk.disposSurat.id,
//                                                     suratMasusDispDetTujuanId: suratMasuk.idDispDetailTujuan,
//                                                   )));
//                                     },
//                                     color: Colors.red,
//                                     child: Text(
//                                       'Buat Surat Laporan',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ) : SizedBox.shrink(), 

//                                   suratMasuk.skbapl != null && suratMasuk.skbapl.statusLaporan != '0' && suratMasuk.skbapl.baplId != '0' && suratMasuk.skbapl.baplId != '' ?
//                                   RaisedButton(

//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) =>
//                                                   SuratTugasCreatePage()));
//                                     },
//                                     color: Colors.white,
//                                     elevation: 4,
//                                     child: Text(
//                                       'Edit BAPL',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ) : SizedBox.shrink() 
                                  
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//               },
//             );
//           } 

//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.black.withOpacity(0.5),
//             child: Center(
//               child: SpinKitRing(color: Colors.green),
//             ),
//           );

//         }));
//   }
// }
