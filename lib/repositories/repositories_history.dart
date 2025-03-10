// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final monitoringPoinHistoryProvider = FutureProvider.family
    .autoDispose<ListRptGeneralMntPoinHistoryResponse, String>(
        (ref, linkPageObj) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("login");

  final _host = "${urlApi()}ReportGeneral/";
  var url = "${_host}GetReportMonitoringPoinByHistory/$linkPageObj";

  var response = await http.get(Uri.parse(url), headers: {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token",
  });

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return ListRptGeneralMntPoinHistoryResponse.fromJson(jsonResponse);
  } else {
    throw Exception("Gagal mengambil data: ${response.statusCode}");
  }
});
