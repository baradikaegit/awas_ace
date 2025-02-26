import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/model/reportafterslsboccaibypicbookingmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsbookingtoshowmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospekgruebpmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksagrmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslstmsproductivitymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class IReportAfterSalesRepository {
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGR(
      String linkPageObj);
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGRBySAName(
      String linkPageObj);
  Future<ListRptAfterSlsProspekGRUeBPResponse> fecthListDataProspekGRtoUeBP(
      String linkPageObj);
  Future<ListRptAfterSlsProspekGRUeBPResponse>
      fecthListDataProspekGRtoUeBPBySAName(String linkPageObj);
  Future<ListRptAfterSlsTMSPRoductivityResponse> fecthListDataTMSProductivity(
      String linkPageObj);
  Future<ListRptAfterSlsBookingToShowResponse> fecthListDataBookingToShow(
      String linkPageObj);
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunneling(
      String linkPageObj);
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunnelingByBranch(
      String linkPageObj);
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunnelingByActual(
      String linkPageObj);
  Future<ListRptSalesBocCaiByPICBookingResponse>
      fecthListDataBocCaiByPicBooking(String linkPageObj);
}

class ReportAfterSalesRepositories implements IReportAfterSalesRepository {
  final _host = "${urlApi()}ReportAfterSales/";

  //Prospek SA GR
  @override
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGR(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaGR = "${_host}GetReportProspekSaGR/$linkPageObj";

    var resultGetRptProspekSaGR =
        await http.get(Uri.parse(urlGetRptProspekSaGR), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaGR = jsonDecode(resultGetRptProspekSaGR.body);

    var responseGetProspekSaGR =
        ListRptAfterSlsProspekSaGRResponse.fromJson(jsonObjRptProspekSaGR);
    return responseGetProspekSaGR;
  }

  //Prospek SA GR By SAName
  @override
  Future<ListRptAfterSlsProspekSaGRResponse> fecthListDataProspekSaGRBySAName(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekSaGRBySAName =
        "${_host}GetReportProspekSaGRBySAName/$linkPageObj";

    var resultGetRptProspekSaGRBySAName =
        await http.get(Uri.parse(urlGetRptProspekSaGRBySAName), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekSaGRBySAName =
        jsonDecode(resultGetRptProspekSaGRBySAName.body);

    var responseGetProspekSaGRBySAName =
        ListRptAfterSlsProspekSaGRResponse.fromJson(
            jsonObjRptProspekSaGRBySAName);
    return responseGetProspekSaGRBySAName;
  }

  //Prospek GR to UEBP
  @override
  Future<ListRptAfterSlsProspekGRUeBPResponse> fecthListDataProspekGRtoUeBP(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekGRtoUeBP =
        "${_host}GetReportProspekGRtoUeBP/$linkPageObj";

    var resultGetRptProspekGRtoUeBP =
        await http.get(Uri.parse(urlGetRptProspekGRtoUeBP), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekGRtoUeBP =
        jsonDecode(resultGetRptProspekGRtoUeBP.body);

    var responseGetProspekGRtoUeBP =
        ListRptAfterSlsProspekGRUeBPResponse.fromJson(
            jsonObjRptProspekGRtoUeBP);
    return responseGetProspekGRtoUeBP;
  }

  //Prospek GR to UEBP By SAName
  @override
  Future<ListRptAfterSlsProspekGRUeBPResponse>
      fecthListDataProspekGRtoUeBPBySAName(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptProspekGRtoUeBPBySAName =
        "${_host}GetReportProspekGRtoUeBPBySAName/$linkPageObj";

    var resultGetRptProspekGRtoUeBPBySAName =
        await http.get(Uri.parse(urlGetRptProspekGRtoUeBPBySAName), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptProspekGRtoUeBPBySAName =
        jsonDecode(resultGetRptProspekGRtoUeBPBySAName.body);

    var responseGetProspekGRtoUeBPBySAName =
        ListRptAfterSlsProspekGRUeBPResponse.fromJson(
            jsonObjRptProspekGRtoUeBPBySAName);
    return responseGetProspekGRtoUeBPBySAName;
  }

  //TMS Productivity
  @override
  Future<ListRptAfterSlsTMSPRoductivityResponse> fecthListDataTMSProductivity(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptTMSProductivity =
        "${_host}GetReportTMSProductivity/$linkPageObj";

    var resultGetRptTMSProductivity =
        await http.get(Uri.parse(urlGetRptTMSProductivity), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptTMSProductivity =
        jsonDecode(resultGetRptTMSProductivity.body);

    var responseGetTMSProductivity =
        ListRptAfterSlsTMSPRoductivityResponse.fromJson(
            jsonObjRptTMSProductivity);
    return responseGetTMSProductivity;
  }

  //Booking To Show
  @override
  Future<ListRptAfterSlsBookingToShowResponse> fecthListDataBookingToShow(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptBookingToShow = "${_host}GetReportBookingToShow/$linkPageObj";

    var resultGetRptBookingToShow =
        await http.get(Uri.parse(urlGetRptBookingToShow), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptBookingToShow = jsonDecode(resultGetRptBookingToShow.body);

    var responseGetBookingToShow =
        ListRptAfterSlsBookingToShowResponse.fromJson(jsonObjRptBookingToShow);
    return responseGetBookingToShow;
  }

  //Funneling
  @override
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunneling(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunneling = "${_host}GetReportFunneling/$linkPageObj";

    var resultGetRptFunneling =
        await http.get(Uri.parse(urlGetRptFunneling), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunneling = jsonDecode(resultGetRptFunneling.body);

    var responseGetFunneling =
        ListRptAfterSlsFunnelingResponse.fromJson(jsonObjRptFunneling);
    return responseGetFunneling;
  }

  //Funneling by branch
  @override
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunnelingByBranch(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunnelingByBranch =
        "${_host}GetReportFunnelingByBranch/$linkPageObj";

    var resultGetRptFunnelingByBranch =
        await http.get(Uri.parse(urlGetRptFunnelingByBranch), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunnelingByBranch =
        jsonDecode(resultGetRptFunnelingByBranch.body);

    var responseGetFunnelingByBranch =
        ListRptAfterSlsFunnelingResponse.fromJson(jsonObjRptFunnelingByBranch);
    return responseGetFunnelingByBranch;
  }

  //Funneling by actual
  @override
  Future<ListRptAfterSlsFunnelingResponse> fecthListDataFunnelingByActual(
      String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptFunnelingByActual =
        "${_host}GetReportFunnelingByActual/$linkPageObj";

    var resultGetRptFunnelingByActual =
        await http.get(Uri.parse(urlGetRptFunnelingByActual), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptFunnelingByActual =
        jsonDecode(resultGetRptFunnelingByActual.body);

    var responseGetFunnelingByActual =
        ListRptAfterSlsFunnelingResponse.fromJson(jsonObjRptFunnelingByActual);
    return responseGetFunnelingByActual;
  }

  //Funneling by boc cai by pic booking
  @override
  Future<ListRptSalesBocCaiByPICBookingResponse>
      fecthListDataBocCaiByPicBooking(String linkPageObj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("login");

    var urlGetRptBocCaiByPicBooking =
        "${_host}GetReportBocCaiByPICBookingBranch/$linkPageObj";

    var resultGetRptBocCaiByPicBooking =
        await http.get(Uri.parse(urlGetRptBocCaiByPicBooking), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    final jsonObjRptBocCaiByPicBooking =
        jsonDecode(resultGetRptBocCaiByPicBooking.body);

    var responseGetBocCaiByPicBooking =
        ListRptSalesBocCaiByPICBookingResponse.fromJson(
            jsonObjRptBocCaiByPicBooking);
    return responseGetBocCaiByPicBooking;
  }
}
