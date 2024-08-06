import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/callinmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ICallinRepository {
  Future<ListReferensiResponse> fetchListData(String callDate);
  Future<CallResponse> createNewCall(ListEntryCallin call);
  Future<CallResponse> createNewCallDetail(ListEntryCallinDetail callDetail);
}

class CallinRepositories implements ICallinRepository {
  final _host = "${urlApi()}Callin/";

  @override
  Future<ListReferensiResponse> fetchListData(String callDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var getAllAppUrl = "${_host}GetReferensi/$callDate";

    var result = await http.get(Uri.parse(getAllAppUrl), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObject = jsonDecode(result.body);

    var response = ListReferensiResponse.fromJson(jsonObject);
    return response;
  }

  @override
  Future<CallResponse> createNewCall(ListEntryCallin call) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlEntryCall = "${_host}AddEntryCallHeader";
    var body = json.encode(call);

    var resultsEntryCall = await http.post(
      Uri.parse(urlEntryCall),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectEntryCall = json.decode(resultsEntryCall.body);
    var responseEntryCall = CallResponse.fromJson(jsonObjectEntryCall);
    return responseEntryCall;
  }

  @override
  Future<CallResponse> createNewCallDetail(
      ListEntryCallinDetail callDetail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlEntryCall = "${_host}AddEntryCallDetail";
    var body = json.encode(callDetail);

    var resultsEntryCall = await http.post(
      Uri.parse(urlEntryCall),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectEntryCall = json.decode(resultsEntryCall.body);
    var responseEntryCall = CallResponse.fromJson(jsonObjectEntryCall);
    return responseEntryCall;
  }
}
