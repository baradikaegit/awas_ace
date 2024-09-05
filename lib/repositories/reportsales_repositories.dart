import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportslsfunneling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportSalesRepository {
  Future<ListRptFunnelingResponse> fecthListData(String linkPageObj);
}

class ReportSalesRepositories implements IReportSalesRepository {
  final _host = "${urlApi()}ReportSales/";

  @override
  Future<ListRptFunnelingResponse> fecthListData(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunneling = "${_host}GetReportFunneling/$linkPageObj";

    var resultGetRptFunneling =
        await http.get(Uri.parse(urlGetRptFunneling), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunneling = jsonDecode(resultGetRptFunneling.body);

    var responseGetRptFunneling =
        ListRptFunnelingResponse.fromJson(jsonObjRptFunneling);
    return responseGetRptFunneling;
  }
}
