import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportslsfunneling.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportSalesRepository {
  Future<ListRptFunnelingResponse> fecthListData(String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySS(String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySales(
      String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySalesDetail(
      String linkPageObj);
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

  //By SS
  @override
  Future<ListRptFunnelingDetailResponse> fecthListDataBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunnelingSS = "${_host}GetReportFunnelingBySS/$linkPageObj";

    var resultGetRptFunnelingSS =
        await http.get(Uri.parse(urlGetRptFunnelingSS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunnelingSS = jsonDecode(resultGetRptFunnelingSS.body);

    var responseGetRptFunnelingSS =
        ListRptFunnelingDetailResponse.fromJson(jsonObjRptFunnelingSS);
    return responseGetRptFunnelingSS;
  }

  //By Sales
  @override
  Future<ListRptFunnelingDetailResponse> fecthListDataBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunnelingSales =
        "${_host}GetReportFunnelingBySales/$linkPageObj";

    var resultGetRptFunnelingSales =
        await http.get(Uri.parse(urlGetRptFunnelingSales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunnelingSales =
        jsonDecode(resultGetRptFunnelingSales.body);

    var responseGetRptFunnelingSales =
        ListRptFunnelingDetailResponse.fromJson(jsonObjRptFunnelingSales);
    return responseGetRptFunnelingSales;
  }

  //By Sales Detail
  @override
  Future<ListRptFunnelingDetailResponse> fecthListDataBySalesDetail(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunnelingSalesDetail =
        "${_host}GetReportFunnelingBySalesDetail/$linkPageObj";

    var resultGetRptFunnelingSalesDetail =
        await http.get(Uri.parse(urlGetRptFunnelingSalesDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunnelingSalesDetail =
        jsonDecode(resultGetRptFunnelingSalesDetail.body);

    var responseGetRptFunnelingSalesDetail =
        ListRptFunnelingDetailResponse.fromJson(jsonObjRptFunnelingSalesDetail);
    return responseGetRptFunnelingSalesDetail;
  }
}
