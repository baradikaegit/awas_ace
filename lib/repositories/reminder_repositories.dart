import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reminderdetailmodel.dart';
import 'package:awas_ace/widgets/model/remindermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReminderRepository {
  Future<ListReminderResponse> fecthListDataStnk();
  Future<ListReminderResponse> fecthListDataBirthday();
  Future<ListReminderResponse> fecthListDataLeasingBerakhir();
  Future<ListReminderDetailResponse> fecthListDataReminderDetail(
    String linkObj,
  );
  Future<UpdateReminderResponse> updateNewReminder(
    ListReminderUpdate updateReminder,
  );
}

class ReminderRepositories implements IReminderRepository {
  final _host = "${urlApi()}Reminder/";

  //STNK
  @override
  Future<ListReminderResponse> fecthListDataStnk() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetSTNK = "${_host}GetSTNK";

    var resultGetSTNK = await http.get(Uri.parse(urlGetSTNK), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjSTNK = jsonDecode(resultGetSTNK.body);

    var responseGetSTNK = ListReminderResponse.fromJson(jsonObjSTNK);
    return responseGetSTNK;
  }

  //Birthday
  @override
  Future<ListReminderResponse> fecthListDataBirthday() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetBirthday = "${_host}GetBirthday";

    var resultGetBirthday = await http.get(Uri.parse(urlGetBirthday), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjBirthday = jsonDecode(resultGetBirthday.body);

    var responseGetBirthday = ListReminderResponse.fromJson(jsonObjBirthday);
    return responseGetBirthday;
  }

  //Leasing Berakhir
  @override
  Future<ListReminderResponse> fecthListDataLeasingBerakhir() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetLeasingBerakhir = "${_host}GetLeasingBerakhir";

    var resultGetLeasingBerakhir =
        await http.get(Uri.parse(urlGetLeasingBerakhir), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjLeasingBerakhir = jsonDecode(resultGetLeasingBerakhir.body);

    var responseGetLeasingBerakhir =
        ListReminderResponse.fromJson(jsonObjLeasingBerakhir);
    return responseGetLeasingBerakhir;
  }

  //Reminder detail
  @override
  Future<ListReminderDetailResponse> fecthListDataReminderDetail(
    String linkObj,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetReminderDetail = "${_host}GetReminderDetail/$linkObj";
    var resultReminderDetail =
        await http.get(Uri.parse(urlGetReminderDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectReminderDetail = jsonDecode(resultReminderDetail.body);

    var responseReminderDetail =
        ListReminderDetailResponse.fromJson(jsonObjectReminderDetail);
    return responseReminderDetail;
  }

  //update reminder
  @override
  Future<UpdateReminderResponse> updateNewReminder(
      ListReminderUpdate updateReminder) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateReminder = "${_host}UpdateReminder/${updateReminder.iD}";
    var body = jsonEncode(updateReminder);

    var resultUpdateReminder = await http.put(
      Uri.parse(urlUpdateReminder),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateReminder = json.decode(resultUpdateReminder.body);
    var responseUpdateReminder =
        UpdateReminderResponse.fromJson(jsonObjectUpdateReminder);
    return responseUpdateReminder;
  }
}
