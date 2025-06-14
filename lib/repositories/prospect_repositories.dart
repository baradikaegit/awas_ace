// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:awas_ace/widgets/model/grafikprospectsalesmodel.dart';
import 'package:awas_ace/widgets/model/prospectbengkeldetailmodel.dart';
import 'package:awas_ace/widgets/model/prospectbengkelmodel.dart';
import 'package:awas_ace/widgets/model/prospectgetsalessvcmodel.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:awas_ace/widgets/model/prospectsalesdetailmodel.dart';
import 'package:awas_ace/widgets/model/prospectsalesmodel.dart';
import 'package:awas_ace/widgets/model/prospectuebpmodel.dart';
import 'package:awas_ace/widgets/model/prospectupdatemodel.dart';
import 'package:awas_ace/widgets/model/sendtaskprospectsvcmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProspectURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    return "${baseUrl}Prospect/";
  }
}

abstract class IProspectRepository {
  Future<ProspectResponse> createNewProspect(ListProspectData prospect);
  Future<ProspectUEBPResponse> createNewProspectUEBP(
      ListEntryProspectUEBP uebp);
  Future<ListProspectUEBP> fecthListDataUEBP(String objID);
  Future<ListGrafikProspectSalesResponse> fecthListDataGrafikProspectSales();
  Future<ListProspectDariBengkelResponse> fecthListDataProspectBengkel();
  Future<ListProspectDariBengkelDetailResponse>
      fecthListDataProspectBengkelDetail(String linkObj);
  Future<UpdateProspectDariBengkelResponse> updateNewProspectBengkel(
      ListProspectbengkelUpdate updateProspectDariBengkel);
  Future<ProspectSalesListResponse> fecthListDataProspectSales();
  Future<ProspectSalesListResponse> fecthListDataProspectSalesBySls(
      String linkObj);
  Future<ProspectSalesDetailResponse> fecthListDataProspectSalesDetail(
      String linkObj);
  Future<UpdateProspectResponse> updateNewProspectSales(
      ListProspectUpdateResponse updateProspect);
  Future<SendProspectResponse> updateSendProspect(
      ListSendProspect upSendProspect);
  Future<ListProspectGetSalesSvcResponse> fecthListDataGetProspectSalesSvc();
  Future<SendTaskProspectResponse> updateReminderSendTask(
      ListSendTaskProspect upSendTask);
}

class ProspectRepositories implements IProspectRepository {
  // final _host = "${urlApi()}Prospect/";

  @override
  Future<ProspectResponse> createNewProspect(ListProspectData prospect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var url = "${_host}AddEntryProspect";
    var body = json.encode(prospect);

    var results = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObject = json.decode(results.body);
    var response = ProspectResponse.fromJson(jsonObject);
    return response;
  }

  @override
  Future<ProspectUEBPResponse> createNewProspectUEBP(
      ListEntryProspectUEBP uebp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var url = "${_host}AddEntryProspectUEBP";
    var body = json.encode(uebp);

    var results = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObject = json.decode(results.body);
    var response = ProspectUEBPResponse.fromJson(jsonObject);
    return response;
  }

  @override
  Future<ListProspectUEBP> fecthListDataUEBP(String objID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlUEBP = "${_host}GetProspectUEBP/$objID";
    var resultUEBP = await http.get(Uri.parse(urlUEBP), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectUEBP = jsonDecode(resultUEBP.body);

    var responseUEBP = ListProspectUEBP.fromJson(jsonObjectUEBP);
    return responseUEBP;
  }

  //Grafiks prospect sales
  @override
  Future<ListGrafikProspectSalesResponse>
      fecthListDataGrafikProspectSales() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetGrafikProspectSales = "${_host}GetGrafikProspectSales";

    var resultGetGrafikProspectSales =
        await http.get(Uri.parse(urlGetGrafikProspectSales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjGrafikProspectSales =
        jsonDecode(resultGetGrafikProspectSales.body);

    var responseGetGrafikProspectSales =
        ListGrafikProspectSalesResponse.fromJson(jsonObjGrafikProspectSales);
    return responseGetGrafikProspectSales;
  }

  //Prospect dari bengkel
  @override
  Future<ListProspectDariBengkelResponse> fecthListDataProspectBengkel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetProspectBengkel = "${_host}GetProspectDariBengkel";

    var resultGetProspectBengkel =
        await http.get(Uri.parse(urlGetProspectBengkel), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProspectBengkel = jsonDecode(resultGetProspectBengkel.body);

    var responseGetProspectBengkel =
        ListProspectDariBengkelResponse.fromJson(jsonObjProspectBengkel);
    return responseGetProspectBengkel;
  }

  //Prospect dari bengkel detail
  @override
  Future<ListProspectDariBengkelDetailResponse>
      fecthListDataProspectBengkelDetail(String linkObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetPbDetail = "${_host}GetProspectDariBengkelDetail/$linkObj";
    var resultPbDetail = await http.get(Uri.parse(urlGetPbDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectPbDetail = jsonDecode(resultPbDetail.body);

    var responsePbDetail =
        ListProspectDariBengkelDetailResponse.fromJson(jsonObjectPbDetail);
    return responsePbDetail;
  }

  //update prospect dari bengkel
  @override
  Future<UpdateProspectDariBengkelResponse> updateNewProspectBengkel(
      ListProspectbengkelUpdate updateProspectDariBengkel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateProspectBengkel =
        "${_host}UpdateProspectDariBengkel/${updateProspectDariBengkel.iD}";
    var body = jsonEncode(updateProspectDariBengkel);

    var resultUpdateProspectBengkel = await http.put(
      Uri.parse(urlUpdateProspectBengkel),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateProspectBengkel =
        json.decode(resultUpdateProspectBengkel.body);
    var responseUpdateProspectBengkel =
        UpdateProspectDariBengkelResponse.fromJson(
            jsonObjectUpdateProspectBengkel);
    return responseUpdateProspectBengkel;
  }

  //Prospect sales
  @override
  Future<ProspectSalesListResponse> fecthListDataProspectSales() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetProspectSales = "${_host}GetProspectSales";

    var resultGetProspectSales =
        await http.get(Uri.parse(urlGetProspectSales), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProspectSales = jsonDecode(resultGetProspectSales.body);

    var responseGetProspectSales =
        ProspectSalesListResponse.fromJson(jsonObjProspectSales);
    return responseGetProspectSales;
  }

  //Prospect sales by sls
  @override
  Future<ProspectSalesListResponse> fecthListDataProspectSalesBySls(
      String linkObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetProspectSalesBySls = "${_host}GetProspectSalesBySales/$linkObj";

    var resultGetProspectSalesBySls =
        await http.get(Uri.parse(urlGetProspectSalesBySls), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProspectSalesBySls =
        jsonDecode(resultGetProspectSalesBySls.body);

    var responseGetProspectSalesBySls =
        ProspectSalesListResponse.fromJson(jsonObjProspectSalesBySls);
    return responseGetProspectSalesBySls;
  }

  //Prospect sales detail
  @override
  Future<ProspectSalesDetailResponse> fecthListDataProspectSalesDetail(
      String linkObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetProspectSalesDetail = "${_host}GetProspectSalesDetail/$linkObj";

    var resultGetProspectSalesDetail =
        await http.get(Uri.parse(urlGetProspectSalesDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProspectSalesDetail =
        jsonDecode(resultGetProspectSalesDetail.body);

    var responseGetProspectSalesDetail =
        ProspectSalesDetailResponse.fromJson(jsonObjProspectSalesDetail);
    return responseGetProspectSalesDetail;
  }

  @override
  Future<UpdateProspectResponse> updateNewProspectSales(
      ListProspectUpdateResponse updateProspect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateProspect =
        "${_host}UpdateProspect/${updateProspect.prospectHId}/${updateProspect.prospectCode}";
    var body = jsonEncode(updateProspect);

    var resultUpdateProspect = await http.put(
      Uri.parse(urlUpdateProspect),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateProspect = json.decode(resultUpdateProspect.body);
    var responseUpdateProspect =
        UpdateProspectResponse.fromJson(jsonObjectUpdateProspect);
    return responseUpdateProspect;
  }

  //update send prospect
  @override
  Future<SendProspectResponse> updateSendProspect(
      ListSendProspect upSendProspect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateSendProspect = "${_host}SendProspect";
    var body = jsonEncode(upSendProspect);

    var resultUpdateSendProspect = await http.put(
      Uri.parse(urlUpdateSendProspect),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateSendProspect =
        json.decode(resultUpdateSendProspect.body);
    var responseUpdateSendProspect =
        SendProspectResponse.fromJson(jsonObjectUpdateSendProspect);
    return responseUpdateSendProspect;
  }

  //Get Sales Prospect Svc
  @override
  Future<ListProspectGetSalesSvcResponse>
      fecthListDataGetProspectSalesSvc() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    var urlGetProspectBengkel = "${_host}GetSalesProspectSvc";

    var resultGetProspectBengkel =
        await http.get(Uri.parse(urlGetProspectBengkel), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProspectBengkel = jsonDecode(resultGetProspectBengkel.body);

    var responseGetProspectBengkel =
        ListProspectGetSalesSvcResponse.fromJson(jsonObjProspectBengkel);
    return responseGetProspectBengkel;
  }

  //update send task prospect sales svc
  @override
  Future<SendTaskProspectResponse> updateReminderSendTask(
      ListSendTaskProspect upSendTask) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await ProspectURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateSendTask = "${_host}SendTaskProspectSvc";
    var body = jsonEncode(upSendTask);

    var resultUpdateSendTask = await http.put(
      Uri.parse(urlUpdateSendTask),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateSendTask = json.decode(resultUpdateSendTask.body);
    var responseUpdateSendTask =
        SendTaskProspectResponse.fromJson(jsonObjectUpdateSendTask);
    return responseUpdateSendTask;
  }
}
