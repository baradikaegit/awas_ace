import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:awas_ace/widgets/model/prospectuebp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IProspectRepository {
  Future<ProspectResponse> createNewProspect(ListProspectData prospect);
  Future<ProspectUEBPResponse> createNewProspectUEBP(
      ListEntryProspectUEBP uebp);
}

class ProspectRepositories implements IProspectRepository {
  final _host = "${urlApi()}Prospect/";

  @override
  Future<ProspectResponse> createNewProspect(ListProspectData prospect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

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
}
