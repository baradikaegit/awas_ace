// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:awas_ace/widgets/model/targetsalesmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TargetSalesURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    return "${baseUrl}TargetSales/";
  }
}

abstract class ITargetSalesRepository {
  Future<ListTargetSalesResponse> fecthListData();
  Future<ListTargetSalesResponse> fecthListDataSSCode(String linkPageObj);
  Future<TargetSalesResponse> createNewTargetSales(
      ListEntryTargetSales targetsls);
}

class TargetSalesRepositories implements ITargetSalesRepository {
  // final _host = "${urlApi()}TargetSales/";

  @override
  Future<ListTargetSalesResponse> fecthListData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await TargetSalesURL.host;

    var urlGet = "${_host}GetTargetSales";
    var resultGet = await http.get(Uri.parse(urlGet), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectGet = jsonDecode(resultGet.body);

    var responseGet = ListTargetSalesResponse.fromJson(jsonObjectGet);
    return responseGet;
  }

  @override
  Future<ListTargetSalesResponse> fecthListDataSSCode(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await TargetSalesURL.host;

    var urlGetSSCode = "${_host}GetTargetSalesDetail/$linkPageObj";

    var resultGetSSCode = await http.get(Uri.parse(urlGetSSCode), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectGetSSCode = jsonDecode(resultGetSSCode.body);

    var responseGetSSCode =
        ListTargetSalesResponse.fromJson(jsonObjectGetSSCode);
    return responseGetSSCode;
  }

  @override
  Future<TargetSalesResponse> createNewTargetSales(
      ListEntryTargetSales targetsales) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await TargetSalesURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlEntry = "${_host}AddEntryTargetSales";
    var bodyEntry = json.encode(targetsales);

    var resultsEntry = await http.post(
      Uri.parse(urlEntry),
      body: bodyEntry,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectEntry = json.decode(resultsEntry.body);
    var responseEntry = TargetSalesResponse.fromJson(jsonObjectEntry);
    return responseEntry;
  }
}
