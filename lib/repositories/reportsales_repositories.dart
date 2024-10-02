import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospekvsmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospeuebpmodel.dart';
import 'package:awas_ace/widgets/model/reportslstargetslsactmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportSalesRepository {
  Future<ListRptFunnelingResponse> fecthListData(String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySS(String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySales(
      String linkPageObj);
  Future<ListRptFunnelingDetailResponse> fecthListDataBySalesDetail(
      String linkPageObj);
  Future<ListRptProspekVsResponse> fecthListDataProspekVs(String linkPageObj);
  Future<ListRptProspekVsResponse> fecthListDataProspekVsBySS(
      String linkPageObj);
  Future<ListRptProspekVsResponse> fecthListDataProspekVsBySales(
      String linkPageObj);
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBP(
      String linkPageObj);
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBPBySS(
      String linkPageObj);
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBPBySales(
      String linkPageObj);
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActual(
      String linkPageObj);
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActualBySS(
      String linkPageObj);
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActualBySales(
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

  //Prospek valid spk
  @override
  Future<ListRptProspekVsResponse> fecthListDataProspekVs(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekVspk = "${_host}GetReportProspekValidSpk/$linkPageObj";

    var resultGetRptProspekVspk =
        await http.get(Uri.parse(urlGetRptProspekVspk), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekVspk = jsonDecode(resultGetRptProspekVspk.body);

    var responseGetRptProspekVspk =
        ListRptProspekVsResponse.fromJson(jsonObjRptProspekVspk);
    return responseGetRptProspekVspk;
  }

  //Prospek valid spk by ss
  @override
  Future<ListRptProspekVsResponse> fecthListDataProspekVsBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekVspkBySS =
        "${_host}GetReportProspekValidSpkBySS/$linkPageObj";

    var resultGetRptProspekVspkBySS =
        await http.get(Uri.parse(urlGetRptProspekVspkBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekVspkBySS =
        jsonDecode(resultGetRptProspekVspkBySS.body);

    var responseGetRptProspekVspkBySS =
        ListRptProspekVsResponse.fromJson(jsonObjRptProspekVspkBySS);
    return responseGetRptProspekVspkBySS;
  }

  //Prospek valid spk by sales
  @override
  Future<ListRptProspekVsResponse> fecthListDataProspekVsBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekVspkBySales =
        "${_host}GetReportProspekValidSpkBySales/$linkPageObj";

    var resultGetRptProspekVspkBySales =
        await http.get(Uri.parse(urlGetRptProspekVspkBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekVspkBySales =
        jsonDecode(resultGetRptProspekVspkBySales.body);

    var responseGetRptProspekVspkBySales =
        ListRptProspekVsResponse.fromJson(jsonObjRptProspekVspkBySales);
    return responseGetRptProspekVspkBySales;
  }

  //Prospek uebp
  @override
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBP(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekUeBP = "${_host}GetReportProspekUeBp/$linkPageObj";

    var resultGetRptProspekUeBP =
        await http.get(Uri.parse(urlGetRptProspekUeBP), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekUeBP = jsonDecode(resultGetRptProspekUeBP.body);

    var responseGetRptProspekUeBP =
        ListRptProspekUeBpResponse.fromJson(jsonObjRptProspekUeBP);
    return responseGetRptProspekUeBP;
  }

  //Prospek uebp by ss
  @override
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBPBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekUeBPBySS =
        "${_host}GetReportProspekUeBpBySS/$linkPageObj";

    var resultGetRptProspekUeBPBySS =
        await http.get(Uri.parse(urlGetRptProspekUeBPBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekUeBPBySS =
        jsonDecode(resultGetRptProspekUeBPBySS.body);

    var responseGetRptProspekUeBPBySS =
        ListRptProspekUeBpResponse.fromJson(jsonObjRptProspekUeBPBySS);
    return responseGetRptProspekUeBPBySS;
  }

  //Prospek uebp by sales
  @override
  Future<ListRptProspekUeBpResponse> fecthListDataProspekUeBPBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekUeBPBySales =
        "${_host}GetReportProspekUeBpBySales/$linkPageObj";

    var resultGetRptProspekUeBPBySales =
        await http.get(Uri.parse(urlGetRptProspekUeBPBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekUeBPBySales =
        jsonDecode(resultGetRptProspekUeBPBySales.body);

    var responseGetRptProspekUeBPBySales =
        ListRptProspekUeBpResponse.fromJson(jsonObjRptProspekUeBPBySales);
    return responseGetRptProspekUeBPBySales;
  }

  //Target Sales Actual
  @override
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActual(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptTSalesActual = "${_host}GetReportTSalesActual/$linkPageObj";

    var resultGetRptTSalesActual =
        await http.get(Uri.parse(urlGetRptTSalesActual), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptTSalesActual = jsonDecode(resultGetRptTSalesActual.body);

    var responseGetRptTSalesActual =
        ListRptTSalesActualResponse.fromJson(jsonObjRptTSalesActual);
    return responseGetRptTSalesActual;
  }

  //Target Sales Actual By SS
  @override
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActualBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptTSalesActualBySS =
        "${_host}GetReportTSalesActualBySS/$linkPageObj";

    var resultGetRptTSalesActualBySS =
        await http.get(Uri.parse(urlGetRptTSalesActualBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptTSalesActualBySS =
        jsonDecode(resultGetRptTSalesActualBySS.body);

    var responseGetRptTSalesActualBySS =
        ListRptTSalesActualResponse.fromJson(jsonObjRptTSalesActualBySS);
    return responseGetRptTSalesActualBySS;
  }

  //Target Sales Actual By Sales
  @override
  Future<ListRptTSalesActualResponse> fecthListDataTSalesActualBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptTSalesActualBySales =
        "${_host}GetReportTSalesActualBySales/$linkPageObj";

    var resultGetRptTSalesActualBySales =
        await http.get(Uri.parse(urlGetRptTSalesActualBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptTSalesActualBySales =
        jsonDecode(resultGetRptTSalesActualBySales.body);

    var responseGetRptTSalesActualBySales =
        ListRptTSalesActualResponse.fromJson(jsonObjRptTSalesActualBySales);
    return responseGetRptTSalesActualBySales;
  }
}
