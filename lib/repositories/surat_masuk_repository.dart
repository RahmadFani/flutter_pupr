
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:pupr/helpers/api.dart';
import 'package:pupr/models/surat_masuk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class SuratMasukRepository {
  Future<ListSuratMasuk> loadSuratMasuks();
}

class ApiSuratMasukRepository implements SuratMasukRepository {
  @override
  Future<ListSuratMasuk> loadSuratMasuks() async {
    ListSuratMasuk listSuratMasuk = ListSuratMasuk();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    try {
      final result = await http.get(
        '$url_api/surat-masuk',
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: '$token'
        }
      );
      if (result.statusCode == 200) {

        final json = jsonDecode(result.body);
        log(json.toString());
        listSuratMasuk = ListSuratMasuk.fromJson(json);
        return listSuratMasuk;
      } else {
        throw Error();
      }
    } catch (e) {
      log('error '+e.toString());
      return throw Error();
    }
  }

}