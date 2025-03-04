import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportGeneralRepository {
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoin();
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySS(
      String linkPageObj);
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySales(
      String linkPageObj);
}

class ReportGeneralRepositories implements IReportGeneralRepository {
  final _host = "${urlApi()}ReportGeneral/";

  //Monitoring Poin
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoin = "${_host}GetReportMonitoringPoin";

    var resultGetRptMonitPoin =
        await http.get(Uri.parse(urlGetRptMonitPoin), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitPoin = jsonDecode(resultGetRptMonitPoin.body);

    var responseGetMonitPoin =
        ListRptGeneralMntPoinResponse.fromJson(jsonObjRptMonitPoin);
    return responseGetMonitPoin;
  }

  //Monitoring Poin by SS
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoinBySS =
        "${_host}GetReportMonitoringPoinBySS/$linkPageObj";

    var resultGetRptMonitPoinBySS =
        await http.get(Uri.parse(urlGetRptMonitPoinBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitPoinBySS = jsonDecode(resultGetRptMonitPoinBySS.body);

    var responseGetMonitPoinBySS =
        ListRptGeneralMntPoinResponse.fromJson(jsonObjRptMonitPoinBySS);
    return responseGetMonitPoinBySS;
  }

  //Monitoring Poin by Sales
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoinBySales =
        "${_host}GetReportMonitoringPoinBySales/$linkPageObj";
    print(urlGetRptMonitPoinBySales);

    var resultGetRptMonitPoinBySales =
        await http.get(Uri.parse(urlGetRptMonitPoinBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitPoinBySales =
        jsonDecode(resultGetRptMonitPoinBySales.body);

    var responseGetMonitPoinBySales =
        ListRptGeneralMntPoinResponse.fromJson(jsonObjRptMonitPoinBySales);
    return responseGetMonitPoinBySales;
  }
}
