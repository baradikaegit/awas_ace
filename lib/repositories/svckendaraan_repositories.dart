import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/svckendaraanmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ISvcKendaraanRepository {
  Future<ListSvcKendaraanResponse> fecthListDataSvcKendaraanPelanggan();
}

class SvckendaraanRepositories implements ISvcKendaraanRepository {
  final _host = "${urlApi()}SvcKendaraan/";

  //SVC Kendaraan pelanggan
  @override
  Future<ListSvcKendaraanResponse> fecthListDataSvcKendaraanPelanggan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetSvckendaraanPelanggan = "${_host}GetSvcKendaraanPelanggan";

    var resultGetSvckendaraanPelanggan =
        await http.get(Uri.parse(urlGetSvckendaraanPelanggan), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjSvckendaraanPelanggan =
        jsonDecode(resultGetSvckendaraanPelanggan.body);

    var responseGetSvckendaraanPelanggan =
        ListSvcKendaraanResponse.fromJson(jsonObjSvckendaraanPelanggan);
    return responseGetSvckendaraanPelanggan;
  }
}
