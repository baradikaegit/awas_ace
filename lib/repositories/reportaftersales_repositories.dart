import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksagrmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportAfterSalesRepository {
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGR(
      String linkPageObj);
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGRBySAName(
      String linkPageObj);
}

class ReportAfterSalesRepositories implements IReportAfterSalesRepository {
  final _host = "${urlApi()}ReportAfterSales/";

  //Prospek SA GR
  @override
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGR(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaGR = "${_host}GetReportProspekSaGR/$linkPageObj";

    var resultGetRptProspekSaGR =
        await http.get(Uri.parse(urlGetRptProspekSaGR), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaGR = jsonDecode(resultGetRptProspekSaGR.body);

    var responseGetProspekSaGR =
        ListRptAfterSlsProspekSaGRResponse.fromJson(jsonObjRptProspekSaGR);
    return responseGetProspekSaGR;
  }

  //Prospek SA GR By SAName
  @override
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGRBySAName(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaGRBySAName =
        "${_host}GetReportProspekSaGRBySAName/$linkPageObj";

    var resultGetRptProspekSaGRBySAName =
        await http.get(Uri.parse(urlGetRptProspekSaGRBySAName), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaGRBySAName =
        jsonDecode(resultGetRptProspekSaGRBySAName.body);

    var responseGetProspekSaGRBySAName =
        ListRptAfterSlsProspekSaGRResponse.fromJson(
            jsonObjRptProspekSaGRBySAName);
    return responseGetProspekSaGRBySAName;
  }
}
