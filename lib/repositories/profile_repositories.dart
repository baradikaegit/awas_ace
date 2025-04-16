import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IProfileRepository {
  Future<ListProfileResponse> fecthListDataGetProfileTeam();
}

class ProfileRepositories implements IProfileRepository {
  final _host = "${urlApi()}Profile/";

  //Get Sales
  @override
  Future<ListProfileResponse> fecthListDataGetProfileTeam() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetProfileTeam = "${_host}GetProfileTeam";

    var resultGetProfileTeam =
        await http.get(Uri.parse(urlGetProfileTeam), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProfileTeam = jsonDecode(resultGetProfileTeam.body);

    var responseGetProfileTeam =
        ListProfileResponse.fromJson(jsonObjProfileTeam);
    return responseGetProfileTeam;
  }
}
