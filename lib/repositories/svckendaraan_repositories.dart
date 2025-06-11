// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:awas_ace/widgets/model/sendtaskmodel.dart';
import 'package:awas_ace/widgets/model/svccountmodel.dart';
import 'package:awas_ace/widgets/model/svckendaraandetailmodel.dart';
import 'package:awas_ace/widgets/model/svckendaraanmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SvcKendaraanURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    return "${baseUrl}SvcKendaraan/";
  }
}

abstract class ISvcKendaraanRepository {
  Future<ListSvcKendaraanResponse> fecthListDataSvcKendaraanPelanggan();
  Future<ListSvcKendaraanResponse> fecthListDataBodyRepairGR();
  Future<ListSvcKendaraanResponse> fecthListDataBodyRepairSls();
  Future<ListSvcKendaraanDetailResponse> fecthListDataSvcKendaraanDetail(
    String linkObj,
  );
  Future<UpdateSvcKendaraanResponse> updateNewSvcKendaraan(
    ListSvcKendaraanUpdate updateSvcKendaraan,
  );
  Future<ListSVCCountResponse> fecthListDataCount();
  Future<SendTaskResponse> updateSvcSendTask(ListSendTask upSendTask);
}

class SvckendaraanRepositories implements ISvcKendaraanRepository {
  // final _host = "${urlApi()}SvcKendaraan/";

  //SVC Kendaraan pelanggan
  @override
  Future<ListSvcKendaraanResponse> fecthListDataSvcKendaraanPelanggan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    var urlGetSvckendaraanPelanggan = "${_host}GetSvcKendaraanPelanggan";

    var resultGetSvckendaraanPelanggan =
        await http.get(Uri.parse(urlGetSvckendaraanPelanggan), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjSvckendaraanPelanggan =
        jsonDecode(resultGetSvckendaraanPelanggan.body);

    var responseGetSvckendaraanPelanggan =
        ListSvcKendaraanResponse.fromJson(jsonObjSvckendaraanPelanggan);
    return responseGetSvckendaraanPelanggan;
  }

  //Body Repair GR
  @override
  Future<ListSvcKendaraanResponse> fecthListDataBodyRepairGR() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    var urlGetBodyRepairGR = "${_host}GetBodyRepairGR";

    var resultGetBodyRepairGR =
        await http.get(Uri.parse(urlGetBodyRepairGR), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjBodyRepairGR = jsonDecode(resultGetBodyRepairGR.body);

    var responseGetBodyRepairGR =
        ListSvcKendaraanResponse.fromJson(jsonObjBodyRepairGR);
    return responseGetBodyRepairGR;
  }

  //Body Repair Sls
  @override
  Future<ListSvcKendaraanResponse> fecthListDataBodyRepairSls() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    var urlGetBodyRepairSls = "${_host}GetBodyRepairGR";

    var resultGetBodyRepairSls =
        await http.get(Uri.parse(urlGetBodyRepairSls), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjBodyRepairSls = jsonDecode(resultGetBodyRepairSls.body);

    var responseGetBodyRepairSls =
        ListSvcKendaraanResponse.fromJson(jsonObjBodyRepairSls);
    return responseGetBodyRepairSls;
  }

  //Svc Kendaraan detail
  @override
  Future<ListSvcKendaraanDetailResponse> fecthListDataSvcKendaraanDetail(
    String linkObj,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    var urlGetSvcKendaraanDetail = "${_host}GetSvcKendaraanDetail/$linkObj";
    var resultSvcKendaraanDetail =
        await http.get(Uri.parse(urlGetSvcKendaraanDetail), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjectSvcKendaraanDetail =
        jsonDecode(resultSvcKendaraanDetail.body);

    var responseSvcKendaraanDetail =
        ListSvcKendaraanDetailResponse.fromJson(jsonObjectSvcKendaraanDetail);
    return responseSvcKendaraanDetail;
  }

  //update Svc Kendaraan
  @override
  Future<UpdateSvcKendaraanResponse> updateNewSvcKendaraan(
      ListSvcKendaraanUpdate updateSvcKendaraan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateSvcKendaraan =
        "${_host}UpdateSvcKendaraan/${updateSvcKendaraan.iD}";
    var body = jsonEncode(updateSvcKendaraan);

    var resultUpdateSvcKendaraan = await http.put(
      Uri.parse(urlUpdateSvcKendaraan),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateSvcKendaraan =
        json.decode(resultUpdateSvcKendaraan.body);
    var responseUpdateSvcKendaraan =
        UpdateSvcKendaraanResponse.fromJson(jsonObjectUpdateSvcKendaraan);
    return responseUpdateSvcKendaraan;
  }

  //SVC COunt
  @override
  Future<ListSVCCountResponse> fecthListDataCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    var urlGetSvcCount = "${_host}GetSvcCount";

    var resultGetSvcCount = await http.get(Uri.parse(urlGetSvcCount), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjSvcCount = jsonDecode(resultGetSvcCount.body);

    var responseGetSvcCount = ListSVCCountResponse.fromJson(jsonObjSvcCount);
    return responseGetSvcCount;
  }

  //update send task
  @override
  Future<SendTaskResponse> updateSvcSendTask(ListSendTask upSendTask) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");
    final _host = await SvcKendaraanURL.host;

    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    var urlUpdateSendTask = "${_host}SendTaskSvc";
    var body = jsonEncode(upSendTask);

    var resultUpdateSendTask = await http.put(
      Uri.parse(urlUpdateSendTask),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    final jsonObjectUpdateSendTask = json.decode(resultUpdateSendTask.body);
    var responseUpdateSendTask =
        SendTaskResponse.fromJson(jsonObjectUpdateSendTask);
    return responseUpdateSendTask;
  }
}
