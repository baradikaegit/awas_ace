import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemhistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntsaldomodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportGeneralRepository {
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoin();
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySS(
      String linkPageObj);
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySvc(
      String linkPageObj);
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySales(
      String linkPageObj);
  Future<ListRptGeneralMntPoinHistoryResponse>
      fecthListDataMonitoringPoinHistory(String linkPageObj);
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeem();
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySS(
      String linkPageObj);
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySvc(
      String linkPageObj);
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySales(
      String linkPageObj);
  Future<ListRptRedeemHistoryResponse> fecthListDataMonitoringRedeemByHistory(
      String linkPageObj);
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldo();
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

  //Monitoring Poin by Svc
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySvc(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoinBySvc =
        "${_host}GetReportMonitoringPoinBySvc/$linkPageObj";

    var resultGetRptMonitPoinBySvc =
        await http.get(Uri.parse(urlGetRptMonitPoinBySvc), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitPoinBySvc =
        jsonDecode(resultGetRptMonitPoinBySvc.body);

    var responseGetMonitPoinBySvc =
        ListRptGeneralMntPoinResponse.fromJson(jsonObjRptMonitPoinBySvc);
    return responseGetMonitPoinBySvc;
  }

  //Monitoring Poin by Sales
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoinBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoinBySales =
        "${_host}GetReportMonitoringPoinBySales/$linkPageObj";

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

  //Monitoring Poin history
  @override
  Future<ListRptGeneralMntPoinHistoryResponse>
      fecthListDataMonitoringPoinHistory(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitPoinHistory =
        "${_host}GetReportMonitoringPoinByHistory/$linkPageObj";

    var resultGetRptMonitPoinHistory =
        await http.get(Uri.parse(urlGetRptMonitPoinHistory), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitPoinHistory =
        jsonDecode(resultGetRptMonitPoinHistory.body);

    var responseGetMonitPoinHistory =
        ListRptGeneralMntPoinHistoryResponse.fromJson(
            jsonObjRptMonitPoinHistory);
    return responseGetMonitPoinHistory;
  }

  //Monitoring Redeem
  @override
  Future<ListRptGeneralMntRedeemResponse>
      fecthListDataMonitoringRedeem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitRedeem = "${_host}GetReportMonitoringRedeem";

    var resultGetRptMonitRedeem =
        await http.get(Uri.parse(urlGetRptMonitRedeem), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeem = jsonDecode(resultGetRptMonitRedeem.body);

    var responseGetMonitRedeem =
        ListRptGeneralMntRedeemResponse.fromJson(jsonObjRptMonitRedeem);
    return responseGetMonitRedeem;
  }

  //Monitoring Redeem by ss
  @override
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySS(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitRedeemBySS =
        "${_host}GetReportMonitoringRedeemBySS/$linkPageObj";

    var resultGetRptMonitRedeemBySS =
        await http.get(Uri.parse(urlGetRptMonitRedeemBySS), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemBySS =
        jsonDecode(resultGetRptMonitRedeemBySS.body);

    var responseGetMonitRedeemBySS =
        ListRptGeneralMntRedeemResponse.fromJson(jsonObjRptMonitRedeemBySS);
    return responseGetMonitRedeemBySS;
  }

  //Monitoring Redeem by svc
  @override
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySvc(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitRedeemBySvc =
        "${_host}GetReportMonitoringRedeemBySvc/$linkPageObj";

    var resultGetRptMonitRedeemBySvc =
        await http.get(Uri.parse(urlGetRptMonitRedeemBySvc), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemBySvc =
        jsonDecode(resultGetRptMonitRedeemBySvc.body);

    var responseGetMonitRedeemBySvc =
        ListRptGeneralMntRedeemResponse.fromJson(jsonObjRptMonitRedeemBySvc);
    return responseGetMonitRedeemBySvc;
  }

  //Monitoring Redeem by sales
  @override
  Future<ListRptGeneralMntRedeemResponse> fecthListDataMonitoringRedeemBySales(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitRedeemBySales =
        "${_host}GetReportMonitoringRedeemBySales/$linkPageObj";

    var resultGetRptMonitRedeemBySales =
        await http.get(Uri.parse(urlGetRptMonitRedeemBySales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemBySales =
        jsonDecode(resultGetRptMonitRedeemBySales.body);

    var responseGetMonitRedeemBySales =
        ListRptGeneralMntRedeemResponse.fromJson(jsonObjRptMonitRedeemBySales);
    return responseGetMonitRedeemBySales;
  }

  //Monitoring Redeem by history
  @override
  Future<ListRptRedeemHistoryResponse> fecthListDataMonitoringRedeemByHistory(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitRedeemByHistory =
        "${_host}GetReportMonitoringRedeemByHistroy/$linkPageObj";

    var resultGetRptMonitRedeemByHistory =
        await http.get(Uri.parse(urlGetRptMonitRedeemByHistory), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemByHistory =
        jsonDecode(resultGetRptMonitRedeemByHistory.body);

    var responseGetMonitRedeemByHistory =
        ListRptRedeemHistoryResponse.fromJson(jsonObjRptMonitRedeemByHistory);
    return responseGetMonitRedeemByHistory;
  }

  //Monitoring Saldo
  @override
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptMonitSaldo = "${_host}GetReportMonitoringSaldo";

    var resultGetRptMonitSaldo =
        await http.get(Uri.parse(urlGetRptMonitSaldo), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitSaldo = jsonDecode(resultGetRptMonitSaldo.body);

    var responseGetMonitSaldo =
        ListRptGeneralMntSaldoResponse.fromJson(jsonObjRptMonitSaldo);
    return responseGetMonitSaldo;
  }
}
