import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/targetsalesmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ITargetSalesRepository {
  Future<ListTargetSalesResponse> fecthListData();
}

class TargetSalesRepositories implements ITargetSalesRepository {
  final _host = "${urlApi()}TargetSales/";

  @override
  Future<ListTargetSalesResponse> fecthListData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

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
}
