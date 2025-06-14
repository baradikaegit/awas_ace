// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:awas_ace/widgets/model/reportslsboccaibysalesmodel.dart';
import 'package:awas_ace/widgets/model/reportslsdotogatepassmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/model/reportslsgatepasstosbimodel.dart';
import 'package:awas_ace/widgets/model/reportslsmonitoringfoapmamodel.dart';
import 'package:awas_ace/widgets/model/reportslsmonitoringmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospekvsmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospeuebpmodel.dart';
import 'package:awas_ace/widgets/model/reportslsstockmodel.dart';
import 'package:awas_ace/widgets/model/reportslstargetslsactmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportSalesURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    return "${baseUrl}ReportSales/";
  }
}

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
  Future<ListRptStockByModelResponse> fecthListDataStockByModel();
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVtype(
      String linkPageObj);
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVcolor(
      String linkPageObj);
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVbranch(
      String linkPageObj);
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepass(
      String linkPageObj);
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepassBySS(
      String linkPageObj);
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepassBySales(
      String linkPageObj);
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBI(
      String linkPageObj);
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBIBySS(
      String linkPageObj);
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBIBySales(
      String linkPageObj);
  Future<ListMonitroingVolProfitMakerResponse>
      fecthListDataMonitoringVolProfitMaker(String linkPageObj);
  Future<ListMonitroingVolProfitMakerResponse>
      fecthListDataMonitoringVolProfitMakerDetail(String linkPageObj);
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMA(
      String linkPageObj);
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMABySS(
      String linkPageObj);
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMABySls(
      String linkPageObj);
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySales(
      String linkPageObj);
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySalesSS(
      String linkPageObj);
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySalesSSDetail(
      String linkPageObj);
}

class ReportSalesRepositories implements IReportSalesRepository {
  // final _host = "${urlApi()}ReportSales/";

  @override
  Future<ListRptFunnelingResponse> fecthListData(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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
    final _host = await ReportSalesURL.host;

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

  //Stock By Model
  @override
  Future<ListRptStockByModelResponse> fecthListDataStockByModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptStockByModel = "${_host}GetReportStockByModel";

    var resultGetRptStockByModel =
        await http.get(Uri.parse(urlGetRptStockByModel), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptStockByModel = jsonDecode(resultGetRptStockByModel.body);

    var responseGetRptStockByModel =
        ListRptStockByModelResponse.fromJson(jsonObjRptStockByModel);
    return responseGetRptStockByModel;
  }

  //Stock By Model vtype
  @override
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVtype(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptStockByModelVtype =
        "${_host}GetReportStockByModelVtype/$linkPageObj";

    var resultGetRptStockByModelVtype =
        await http.get(Uri.parse(urlGetRptStockByModelVtype), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptStockByModelVtype =
        jsonDecode(resultGetRptStockByModelVtype.body);

    var responseGetRptStockByModelVtype =
        ListRptStockByModelResponse.fromJson(jsonObjRptStockByModelVtype);
    return responseGetRptStockByModelVtype;
  }

  //Stock By Model vcolor
  @override
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVcolor(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptStockByModelVcolor =
        "${_host}GetReportStockByModelVcolor/$linkPageObj";

    var resultGetRptStockByModelVcolor =
        await http.get(Uri.parse(urlGetRptStockByModelVcolor), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptStockByModelVcolor =
        jsonDecode(resultGetRptStockByModelVcolor.body);

    var responseGetRptStockByModelVcolor =
        ListRptStockByModelResponse.fromJson(jsonObjRptStockByModelVcolor);
    return responseGetRptStockByModelVcolor;
  }

  //Stock By Model vbranch
  @override
  Future<ListRptStockByModelResponse> fecthListDataStockByModelVbranch(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptStockByModelVbranch =
        "${_host}GetReportStockByModelBranch/$linkPageObj";

    var resultGetRptStockByModelVbranch =
        await http.get(Uri.parse(urlGetRptStockByModelVbranch), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptStockByModelVbranch =
        jsonDecode(resultGetRptStockByModelVbranch.body);

    var responseGetRptStockByModelVbranch =
        ListRptStockByModelResponse.fromJson(jsonObjRptStockByModelVbranch);
    return responseGetRptStockByModelVbranch;
  }

  //Do to Gatepass
  @override
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepass(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptDoToGatepass = "${_host}GetReportDoToGatepass/$linkPageObj";

    var resultGetRptDoToGatepass =
        await http.get(Uri.parse(urlGetRptDoToGatepass), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptDoToGatepass = jsonDecode(resultGetRptDoToGatepass.body);

    var responseGetRptDoToGatepass =
        ListRptDoToGatepassResponse.fromJson(jsonObjRptDoToGatepass);
    return responseGetRptDoToGatepass;
  }

  //Do to Gatepass by ss
  @override
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepassBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptDoToGatepassBySS =
        "${_host}GetReportDoToGatepassBySS/$linkPageObj";

    var resultGetRptDoToGatepassBySS =
        await http.get(Uri.parse(urlGetRptDoToGatepassBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptDoToGatepassBySS =
        jsonDecode(resultGetRptDoToGatepassBySS.body);

    var responseGetRptDoToGatepassBySS =
        ListRptDoToGatepassResponse.fromJson(jsonObjRptDoToGatepassBySS);
    return responseGetRptDoToGatepassBySS;
  }

  //Do to Gatepass by sales
  @override
  Future<ListRptDoToGatepassResponse> fecthListDataDotoGatepassBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptDoToGatepassBySales =
        "${_host}GetReportDoToGatepassBySales/$linkPageObj";

    var resultGetRptDoToGatepassBySales =
        await http.get(Uri.parse(urlGetRptDoToGatepassBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjDoToGatepassBySales =
        jsonDecode(resultGetRptDoToGatepassBySales.body);

    var responseGetRptDoToGatepassBySales =
        ListRptDoToGatepassResponse.fromJson(jsonObjDoToGatepassBySales);
    return responseGetRptDoToGatepassBySales;
  }

  //Gatepass to SBI
  @override
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBI(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptGatepasstoSBI = "${_host}GetReportGatepassToSBI/$linkPageObj";

    var resultGetRptGatepasstoSBI =
        await http.get(Uri.parse(urlGetRptGatepasstoSBI), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptGatepasstoSBI = jsonDecode(resultGetRptGatepasstoSBI.body);

    var responseGetGatepasstoSBI =
        ListRptGatepassToSbiResponse.fromJson(jsonObjRptGatepasstoSBI);
    return responseGetGatepasstoSBI;
  }

  //Gatepass to SBI By SS
  @override
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBIBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptGatepasstoSBIBySS =
        "${_host}GetReportGatepassToSBIBySS/$linkPageObj";

    var resultGetRptGatepasstoSBIBySS =
        await http.get(Uri.parse(urlGetRptGatepasstoSBIBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptGatepasstoSBIBySS =
        jsonDecode(resultGetRptGatepasstoSBIBySS.body);

    var responseGetGatepasstoSBIBySS =
        ListRptGatepassToSbiResponse.fromJson(jsonObjRptGatepasstoSBIBySS);
    return responseGetGatepasstoSBIBySS;
  }

  //Gatepass to SBI By Sales
  @override
  Future<ListRptGatepassToSbiResponse> fecthListDataGatepasstoSBIBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptGatepasstoSBIBySales =
        "${_host}GetReportGatepassToSBIBySales/$linkPageObj";

    var resultGetRptGatepasstoSBIBySales =
        await http.get(Uri.parse(urlGetRptGatepasstoSBIBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptGatepasstoSBIBySales =
        jsonDecode(resultGetRptGatepasstoSBIBySales.body);

    var responseGetGatepasstoSBIBySales =
        ListRptGatepassToSbiResponse.fromJson(jsonObjRptGatepasstoSBIBySales);
    return responseGetGatepasstoSBIBySales;
  }

  //Monitoring vol & profit maker
  @override
  Future<ListMonitroingVolProfitMakerResponse>
      fecthListDataMonitoringVolProfitMaker(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptMonitoringVolProfitMaker =
        "${_host}GetReportMonitoringVolProfitMaker/$linkPageObj";

    var resultGetRptMonitoringVolProfitMaker =
        await http.get(Uri.parse(urlGetRptMonitoringVolProfitMaker), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitoringVolProfitMaker =
        jsonDecode(resultGetRptMonitoringVolProfitMaker.body);

    var responseGetMonitoringVolProfitMaker =
        ListMonitroingVolProfitMakerResponse.fromJson(
            jsonObjRptMonitoringVolProfitMaker);
    return responseGetMonitoringVolProfitMaker;
  }

  //Monitoring vol & profit maker detail
  @override
  Future<ListMonitroingVolProfitMakerResponse>
      fecthListDataMonitoringVolProfitMakerDetail(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptVolProfitMakerDetail =
        "${_host}GetReportMonitoringVolProfitMakerDetail/$linkPageObj";

    var resultGetRptVolProfitMakerDetail =
        await http.get(Uri.parse(urlGetRptVolProfitMakerDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptVolProfitMakerDetail =
        jsonDecode(resultGetRptVolProfitMakerDetail.body);

    var responseGetVolProfitMakerDetail =
        ListMonitroingVolProfitMakerResponse.fromJson(
            jsonObjRptVolProfitMakerDetail);
    return responseGetVolProfitMakerDetail;
  }

  //Monitoring Foa & PMA
  @override
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMA(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptFoaPMA = "${_host}GetMonitoringFoaPMA/$linkPageObj";

    var resultGetRptFoaPMA =
        await http.get(Uri.parse(urlGetRptFoaPMA), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFoaPMA = jsonDecode(resultGetRptFoaPMA.body);

    var responseGetRptFoaPMA =
        ListMonitroingFoaPMAResponse.fromJson(jsonObjRptFoaPMA);
    return responseGetRptFoaPMA;
  }

  //Monitoring Foa & PMA BySS
  @override
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMABySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptFoaPMABySS = "${_host}GetMonitoringFoaPMABySS/$linkPageObj";

    var resultGetRptFoaPMABySS =
        await http.get(Uri.parse(urlGetRptFoaPMABySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFoaPMABySS = jsonDecode(resultGetRptFoaPMABySS.body);

    var responseGetRptFoaPMABySS =
        ListMonitroingFoaPMAResponse.fromJson(jsonObjRptFoaPMABySS);
    return responseGetRptFoaPMABySS;
  }

  //Monitoring Foa & PMA BySales
  @override
  Future<ListMonitroingFoaPMAResponse> fecthListDataMonitoringFoaPMABySls(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptFoaPMABySls =
        "${_host}GetMonitoringFoaPMABySales/$linkPageObj";

    var resultGetRptFoaPMABySls =
        await http.get(Uri.parse(urlGetRptFoaPMABySls), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFoaPMABySls = jsonDecode(resultGetRptFoaPMABySls.body);

    var responseGetRptFoaPMABySls =
        ListMonitroingFoaPMAResponse.fromJson(jsonObjRptFoaPMABySls);
    return responseGetRptFoaPMABySls;
  }

  //Monitoring BOC & CAI BySales
  @override
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptBocCaiBySales = "${_host}GetBocCaiBySalesBranch/$linkPageObj";

    var resultGetRptBocCaiBySales =
        await http.get(Uri.parse(urlGetRptBocCaiBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptBocCaiBySales = jsonDecode(resultGetRptBocCaiBySales.body);

    var responseGetRptBocCaiBySales =
        ListRptSalesBocCaiBySalesResponse.fromJson(jsonObjRptBocCaiBySales);
    return responseGetRptBocCaiBySales;
  }

  //Monitoring BOC & CAI BySales SS
  @override
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySalesSS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptBocCaiBySalesSS = "${_host}GetBocCaiBySalesSS/$linkPageObj";

    var resultGetRptBocCaiBySalesSS =
        await http.get(Uri.parse(urlGetRptBocCaiBySalesSS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptBocCaiBySalesSS =
        jsonDecode(resultGetRptBocCaiBySalesSS.body);

    var responseGetRptBocCaiBySalesSS =
        ListRptSalesBocCaiBySalesResponse.fromJson(jsonObjRptBocCaiBySalesSS);
    return responseGetRptBocCaiBySalesSS;
  }

  //Monitoring BOC & CAI BySales SS detail
  @override
  Future<ListRptSalesBocCaiBySalesResponse> fecthListDataBocCaiBySalesSSDetail(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportSalesURL.host;

    var urlGetRptBocCaiBySalesSSDtl =
        "${_host}GetBocCaiBySalesSSDetail/$linkPageObj";

    var resultGetRptBocCaiBySalesSSDtl =
        await http.get(Uri.parse(urlGetRptBocCaiBySalesSSDtl), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptBocCaiBySalesSSDtl =
        jsonDecode(resultGetRptBocCaiBySalesSSDtl.body);

    var responseGetRptBocCaiBySalesSSDtl =
        ListRptSalesBocCaiBySalesResponse.fromJson(
            jsonObjRptBocCaiBySalesSSDtl);
    return responseGetRptBocCaiBySalesSSDtl;
  }
}
