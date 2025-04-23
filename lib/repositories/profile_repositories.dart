import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:awas_ace/widgets/model/profileteammodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IProfileRepository {
  Future<ListProfileResponse> fecthListDataGetProfile();
  Future<ListProfileTeamResponse> fecthListDataGetProfileTeam();
  Future<UpdateProfileResponse> updateProfile(ListUpdateProfile up);
}

class ProfileRepositories implements IProfileRepository {
  final _host = "${urlApi()}Profile/";

  //Get Sales
  @override
  Future<ListProfileResponse> fecthListDataGetProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetProfile = "${_host}GetProfile";

    var resultGetProfile = await http.get(Uri.parse(urlGetProfile), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjProfile = jsonDecode(resultGetProfile.body);

    var responseGetProfile = ListProfileResponse.fromJson(jsonObjProfile);
    return responseGetProfile;
  }

  //Get Sales
  @override
  Future<ListProfileTeamResponse> fecthListDataGetProfileTeam() async {
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
        ListProfileTeamResponse.fromJson(jsonObjProfileTeam);
    return responseGetProfileTeam;
  }

  //update profile
  @override
  Future<UpdateProfileResponse> updateProfile(ListUpdateProfile up) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateProfile = "${_host}UpdateProfile";
    var body = jsonEncode(up);

    var resultUpdateProfile = await http.put(
      Uri.parse(urlUpdateProfile),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateProfile = json.decode(resultUpdateProfile.body);
    var responseUpdateProfile =
        UpdateProfileResponse.fromJson(jsonObjectUpdateProfile);
    return responseUpdateProfile;
  }
}
