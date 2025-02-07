import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportbpprospekbpuegrmodel.dart';
import 'package:awas_ace/widgets/model/reportbpprospeksabpmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportBodyPaintRepository {
  Future<ListRptBodyPaintProspekSaBPResponse> fecthListDataProspekSaBP(
      String linkPageObj);
  Future<ListRptBodyPaintProspekSaBPResponse> fecthListDataProspekSaBPBySAName(
      String linkPageObj);
  Future<ListRptBodyPaintProspekBPUeGRResponse> fecthListDataProspekBPtoUeGR(
      String linkPageObj);
  Future<ListRptBodyPaintProspekBPUeGRResponse>
      fecthListDataProspekBPtoUeGRBySAName(String linkPageObj);
}

class ReportBodyPaintRepositories implements IReportBodyPaintRepository {
  final _host = "${urlApi()}ReportBodyPaint/";

  //Prospek SA BP
  @override
  Future<ListRptBodyPaintProspekSaBPResponse> fecthListDataProspekSaBP(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaBP = "${_host}GetReportProspekSaBP/$linkPageObj";

    var resultGetRptProspekSaBP =
        await http.get(Uri.parse(urlGetRptProspekSaBP), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaBP = jsonDecode(resultGetRptProspekSaBP.body);

    var responseGetProspekSaBP =
        ListRptBodyPaintProspekSaBPResponse.fromJson(jsonObjRptProspekSaBP);
    return responseGetProspekSaBP;
  }

  //Prospek SA BP By SAName
  @override
  Future<ListRptBodyPaintProspekSaBPResponse> fecthListDataProspekSaBPBySAName(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaBPBySAName =
        "${_host}GetReportProspekSaBPBySAName/$linkPageObj";

    var resultGetRptProspekSaBPBySAName =
        await http.get(Uri.parse(urlGetRptProspekSaBPBySAName), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaBPBySAName =
        jsonDecode(resultGetRptProspekSaBPBySAName.body);

    var responseGetProspekSaBPBySAName =
        ListRptBodyPaintProspekSaBPResponse.fromJson(
            jsonObjRptProspekSaBPBySAName);
    return responseGetProspekSaBPBySAName;
  }

  //Prospek BP to UE GR
  @override
  Future<ListRptBodyPaintProspekBPUeGRResponse> fecthListDataProspekBPtoUeGR(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekBPtoUeGR =
        "${_host}GetReportProspekBPtoUeGR/$linkPageObj";

    var resultGetRptProspekBPtoUeGR =
        await http.get(Uri.parse(urlGetRptProspekBPtoUeGR), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekBPtoUeGR =
        jsonDecode(resultGetRptProspekBPtoUeGR.body);

    var responseGetProspekBPtoUeGR =
        ListRptBodyPaintProspekBPUeGRResponse.fromJson(
            jsonObjRptProspekBPtoUeGR);
    return responseGetProspekBPtoUeGR;
  }

  //Prospek BP to UE GR By SAName
  @override
  Future<ListRptBodyPaintProspekBPUeGRResponse>
      fecthListDataProspekBPtoUeGRBySAName(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekBPtoUeGRBySAName =
        "${_host}GetReportProspekBPtoUeGRBySAName/$linkPageObj";

    print(urlGetRptProspekBPtoUeGRBySAName);

    var resultGetRptProspekBPtoUeGRBySAName =
        await http.get(Uri.parse(urlGetRptProspekBPtoUeGRBySAName), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekBPtoUeGRBySAName =
        jsonDecode(resultGetRptProspekBPtoUeGRBySAName.body);

    var responseGetProspekBPtoUeGRBySAName =
        ListRptBodyPaintProspekBPUeGRResponse.fromJson(
            jsonObjRptProspekBPtoUeGRBySAName);
    return responseGetProspekBPtoUeGRBySAName;
  }
}
