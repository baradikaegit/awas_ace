// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemhistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemitemmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntsaldohistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntsaldomodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportGeneralURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    return "${baseUrl}ReportGeneral/";
  }
}

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
  Future<ListRptGeneralMntRedeemItemResponse>
      fecthListDataMonitoringRedeemItem();
  Future<ListRptGeneralMntRedeemItemResponse>
      fecthListDataMonitoringRedeemItemByDetail(String linkPageObj);
  Future<EntryRedeemPoinResponse> createNewRedeemPoin(
      ListEntryRedeemPoin redeempoin);
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldo();
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldoByUser(
      String linkPageObj);
  Future<ListRptGeneralMntSaldoHistoryResponse>
      fecthListDataMonitoringSaldoHistory(String linkPageObj);
}

class ReportGeneralRepositories implements IReportGeneralRepository {
  // final _host = "${urlApi()}ReportGeneral/";

  //Monitoring Poin
  @override
  Future<ListRptGeneralMntPoinResponse> fecthListDataMonitoringPoin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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
    final _host = await ReportGeneralURL.host;

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

  //Monitoring Redeem item
  @override
  Future<ListRptGeneralMntRedeemItemResponse>
      fecthListDataMonitoringRedeemItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

    var urlGetRptMonitRedeemItem = "${_host}GetReportMonitoringRedeemItem";

    var resultGetRptMonitRedeemItem =
        await http.get(Uri.parse(urlGetRptMonitRedeemItem), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemItem =
        jsonDecode(resultGetRptMonitRedeemItem.body);

    var responseGetMonitRedeemitem =
        ListRptGeneralMntRedeemItemResponse.fromJson(jsonObjRptMonitRedeemItem);
    return responseGetMonitRedeemitem;
  }

  //Monitoring Redeem item
  @override
  Future<ListRptGeneralMntRedeemItemResponse>
      fecthListDataMonitoringRedeemItemByDetail(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

    var urlGetRptMonitRedeemItemByDetail =
        "${_host}GetReportMonitoringRedeemItemByDetail/$linkPageObj";

    var resultGetRptMonitRedeemItemByDetail =
        await http.get(Uri.parse(urlGetRptMonitRedeemItemByDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitRedeemItemBYDetail =
        jsonDecode(resultGetRptMonitRedeemItemByDetail.body);

    var responseGetMonitRedeemitemByDetail =
        ListRptGeneralMntRedeemItemResponse.fromJson(
            jsonObjRptMonitRedeemItemBYDetail);
    return responseGetMonitRedeemitemByDetail;
  }

//Monitoring redeem poin
  @override
  Future<EntryRedeemPoinResponse> createNewRedeemPoin(
      ListEntryRedeemPoin redeempoin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var url = "${_host}EntryMonitoringRedeemPoin";
    var body = json.encode(redeempoin);

    var results = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObject = json.decode(results.body);
    var response = EntryRedeemPoinResponse.fromJson(jsonObject);
    return response;
  }

  //Monitoring Saldo
  @override
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

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

  //Monitoring Saldo by user
  @override
  Future<ListRptGeneralMntSaldoResponse> fecthListDataMonitoringSaldoByUser(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

    var urlGetRptMonitSaldoByUser =
        "${_host}GetReportMonitoringSaldoByUser/$linkPageObj";

    var resultGetRptMonitSaldoByUser =
        await http.get(Uri.parse(urlGetRptMonitSaldoByUser), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitSaldoByUser =
        jsonDecode(resultGetRptMonitSaldoByUser.body);

    var responseGetMonitSaldoByUser =
        ListRptGeneralMntSaldoResponse.fromJson(jsonObjRptMonitSaldoByUser);
    return responseGetMonitSaldoByUser;
  }

  //Monitoring Saldo history
  @override
  Future<ListRptGeneralMntSaldoHistoryResponse>
      fecthListDataMonitoringSaldoHistory(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ReportGeneralURL.host;

    var urlGetRptMonitSaldoHistory =
        "${_host}GetReportMonitoringSaldoByHistory/$linkPageObj";

    var resultGetRptMonitSaldoHistory =
        await http.get(Uri.parse(urlGetRptMonitSaldoHistory), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptMonitSaldoHistory =
        jsonDecode(resultGetRptMonitSaldoHistory.body);

    var responseGetMonitSaldoHistory =
        ListRptGeneralMntSaldoHistoryResponse.fromJson(
            jsonObjRptMonitSaldoHistory);
    return responseGetMonitSaldoHistory;
  }
}
