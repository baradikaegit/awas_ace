// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';

import 'package:awas_ace/provider/svckendaraan_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/svckendaraandetailmodel.dart';
import 'package:awas_ace/widgets/model/taskstatusmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BodyRepariGRDetailPage extends StatefulWidget {
  final Object? linkObject;

  const BodyRepariGRDetailPage({super.key, required this.linkObject});

  static const String routeName = "/bodyRepariGRDetailPage";

  @override
  State<BodyRepariGRDetailPage> createState() => _BodyRepariGRDetailPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _BodyRepariGRDetailPageState extends State<BodyRepariGRDetailPage> {
  Widget titleBar = const Text(
    "Task Detail",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController iDController = TextEditingController();
  TextEditingController taskStatusController = TextEditingController();
  TextEditingController taskStatusIDController = TextEditingController();
  TextEditingController ketController = TextEditingController();

  List<ModelSelect> bodyCapture = [
    ModelSelect('Pilih Data Yang Sesuai', 1),
  ];

  String taskStatus = '';
  String taskStatusID = '';
  String bodyCaptureVal = 'Pilih Data Yang Sesuai';

  void _custHomePhoneCall(String custHomePhone) async {
    final Uri custHomePhoneUri = Uri(
      scheme: 'tel',
      path: custHomePhone,
    );
    if (await canLaunchUrl(custHomePhoneUri)) {
      await launchUrl(custHomePhoneUri);
    } else {
      throw 'Could not launch $custHomePhone';
    }
  }

  void _custPhoneCall(String custPhone) async {
    final Uri custPhoneUri = Uri(
      scheme: 'tel',
      path: custPhone,
    );
    if (await canLaunchUrl(custPhoneUri)) {
      await launchUrl(custPhoneUri);
    } else {
      throw 'Could not launch $custPhone';
    }
  }

  void _driverHomePhoneCall(String driverHomePhone) async {
    final Uri driverHomePhoneUri = Uri(
      scheme: 'tel',
      path: driverHomePhone,
    );
    if (await canLaunchUrl(driverHomePhoneUri)) {
      await launchUrl(driverHomePhoneUri);
    } else {
      throw 'Could not launch $driverHomePhone';
    }
  }

  void _driverPhoneCall(String driverPhone) async {
    final Uri driverPhoneUri = Uri(
      scheme: 'tel',
      path: driverPhone,
    );
    if (await canLaunchUrl(driverPhoneUri)) {
      await launchUrl(driverPhoneUri);
    } else {
      throw 'Could not launch $driverPhone';
    }
  }

  void _openWhatsApp(String phone, String message) async {
    final String whatsappUrl =
        "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhite = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorYellow = TextStyle(
      color: const Color.fromARGB(
        255,
        53,
        104,
        159,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorWhiteB = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    var textStyleColorWhiteBI = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );

    var textStyleColorH = TextStyle(
      color: const Color.fromARGB(
        255,
        53,
        104,
        159,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 20.5, landscapeValue: 20.5),
          const Condition.largerThan(
              name: TABLET, value: 25.5, landscapeValue: 25.5, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: titleBar,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(
            255,
            53,
            104,
            159,
          ),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(
          255,
          53,
          104,
          159,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              Consumer(
                builder: (context, WidgetRef ref, child) {
                  var linkObj = widget.linkObject.toString();

                  final databodyrepairgrdetail =
                      ref.watch(svcKendaraanDetail(linkObj));

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: databodyrepairgrdetail.when(
                                data:
                                    (datadetail) =>
                                        (datadetail.listSvcKendaraanDetail !=
                                                null)
                                            ? datadetail.listSvcKendaraanDetail!
                                                    .isNotEmpty
                                                ? ListView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount: datadetail
                                                        .listSvcKendaraanDetail!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      iDController.text = datadetail
                                                          .listSvcKendaraanDetail![
                                                              index]
                                                          .iD;

                                                      taskStatusID == ''
                                                          ? taskStatusIDController
                                                                  .text =
                                                              datadetail
                                                                  .listSvcKendaraanDetail![
                                                                      index]
                                                                  .taskStatusID
                                                                  .toUpperCase()
                                                          : null;

                                                      taskStatus == ''
                                                          ? taskStatusController
                                                                  .text =
                                                              datadetail
                                                                  .listSvcKendaraanDetail![
                                                                      index]
                                                                  .statusName
                                                          : null;

                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          20,
                                                          20,
                                                          20,
                                                          0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Text(
                                                                datadetail
                                                                    .listSvcKendaraanDetail![
                                                                        index]
                                                                    .taskType,
                                                                style:
                                                                    textStyleColorH,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight: 90,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        167,
                                                                        53,
                                                                        104,
                                                                        159,
                                                                      ),
                                                                      blurRadius:
                                                                          3.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          1.1,
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    167,
                                                                    36,
                                                                    80,
                                                                    128,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listSvcKendaraanDetail![index]
                                                                              .policeNumber,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "${datadetail.listSvcKendaraanDetail![index].vtype} (${datadetail.listSvcKendaraanDetail![index].chassisNumber})"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "${datadetail.listSvcKendaraanDetail![index].vColor} (${datadetail.listSvcKendaraanDetail![index].year})"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "SA - ${datadetail.listSvcKendaraanDetail![index].usernameSAName}"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Service Terakhir - ${datadetail.listSvcKendaraanDetail![index].lastService}"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tanggal Service - ${datadetail.listSvcKendaraanDetail![index].lastServiceDate}"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listSvcKendaraanDetail![index]
                                                                              .info
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight: 90,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        167,
                                                                        53,
                                                                        104,
                                                                        159,
                                                                      ),
                                                                      blurRadius:
                                                                          3.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          1.1,
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    167,
                                                                    36,
                                                                    80,
                                                                    128,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listSvcKendaraanDetail![index]
                                                                              .custName,
                                                                          style:
                                                                              textStyleColorWhiteB,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: datadetail.listSvcKendaraanDetail![index].custHomePhone ==
                                                                                ''
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  String custPhone = datadetail.listSvcKendaraanDetail![index].custPhone;
                                                                                  _custPhoneCall(custPhone);
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.phone_android,
                                                                                      color: Colors.white,
                                                                                      size: 35.0,
                                                                                    ),
                                                                                    Text(
                                                                                      datadetail.listSvcKendaraanDetail![index].custPhone,
                                                                                      style: textStyleColorWhite,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : datadetail.listSvcKendaraanDetail![index].custPhone == ''
                                                                                ? InkWell(
                                                                                    onTap: () {
                                                                                      String custHomePhone = datadetail.listSvcKendaraanDetail![index].custHomePhone;
                                                                                      _custHomePhoneCall(custHomePhone);
                                                                                    },
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const Icon(
                                                                                          Icons.phone,
                                                                                          color: Colors.white,
                                                                                          size: 35.0,
                                                                                        ),
                                                                                        Text(
                                                                                          datadetail.listSvcKendaraanDetail![index].custHomePhone,
                                                                                          style: textStyleColorWhite,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                : Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          String custHomePhone = datadetail.listSvcKendaraanDetail![index].custHomePhone;
                                                                                          _custHomePhoneCall(custHomePhone);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            const Icon(
                                                                                              Icons.phone,
                                                                                              color: Colors.white,
                                                                                              size: 35.0,
                                                                                            ),
                                                                                            Text(
                                                                                              datadetail.listSvcKendaraanDetail![index].custHomePhone,
                                                                                              style: textStyleColorWhite,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          String custPhone = datadetail.listSvcKendaraanDetail![index].custPhone;
                                                                                          _custPhoneCall(custPhone);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            const Icon(
                                                                                              Icons.phone_android,
                                                                                              color: Colors.white,
                                                                                              size: 35.0,
                                                                                            ),
                                                                                            Text(
                                                                                              datadetail.listSvcKendaraanDetail![index].custPhone,
                                                                                              style: textStyleColorWhite,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: datadetail.listSvcKendaraanDetail![index].custPhone !=
                                                                                ''
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  String phone = datadetail.listSvcKendaraanDetail![index].custPhone;
                                                                                  String message = "Hello..";
                                                                                  _openWhatsApp(phone, message);
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    const FaIcon(
                                                                                      FontAwesomeIcons.whatsapp,
                                                                                      color: Colors.white,
                                                                                      size: 35.0,
                                                                                    ),
                                                                                    Text(
                                                                                      datadetail.listSvcKendaraanDetail![index].custPhone,
                                                                                      style: textStyleColorWhite,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : null,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight: 90,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        167,
                                                                        53,
                                                                        104,
                                                                        159,
                                                                      ),
                                                                      blurRadius:
                                                                          3.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          1.1,
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    167,
                                                                    36,
                                                                    80,
                                                                    128,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listSvcKendaraanDetail![index]
                                                                              .driverName,
                                                                          style:
                                                                              textStyleColorWhiteB,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: datadetail.listSvcKendaraanDetail![index].driverHomePhone ==
                                                                                ''
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  String driverPhone = datadetail.listSvcKendaraanDetail![index].driverPhone;
                                                                                  _driverPhoneCall(driverPhone);
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.phone_android,
                                                                                      color: Colors.white,
                                                                                      size: 35.0,
                                                                                    ),
                                                                                    Text(
                                                                                      datadetail.listSvcKendaraanDetail![index].driverPhone,
                                                                                      style: textStyleColorWhite,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : datadetail.listSvcKendaraanDetail![index].driverPhone == ''
                                                                                ? InkWell(
                                                                                    onTap: () {
                                                                                      String driverHomePhone = datadetail.listSvcKendaraanDetail![index].driverHomePhone;
                                                                                      _driverHomePhoneCall(driverHomePhone);
                                                                                    },
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const Icon(
                                                                                          Icons.phone,
                                                                                          color: Colors.white,
                                                                                          size: 35.0,
                                                                                        ),
                                                                                        Text(
                                                                                          datadetail.listSvcKendaraanDetail![index].driverHomePhone,
                                                                                          style: textStyleColorWhite,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                : Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          String driverHomePhone = datadetail.listSvcKendaraanDetail![index].driverHomePhone;
                                                                                          _driverHomePhoneCall(driverHomePhone);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            const Icon(
                                                                                              Icons.phone,
                                                                                              color: Colors.white,
                                                                                              size: 35.0,
                                                                                            ),
                                                                                            Text(
                                                                                              datadetail.listSvcKendaraanDetail![index].driverHomePhone,
                                                                                              style: textStyleColorWhite,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          String driverPhone = datadetail.listSvcKendaraanDetail![index].driverPhone;
                                                                                          _driverPhoneCall(driverPhone);
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            const Icon(
                                                                                              Icons.phone_android,
                                                                                              color: Colors.white,
                                                                                              size: 35.0,
                                                                                            ),
                                                                                            Text(
                                                                                              datadetail.listSvcKendaraanDetail![index].driverPhone,
                                                                                              style: textStyleColorWhite,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            if (datadetail
                                                                    .listSvcKendaraanDetail![
                                                                        index]
                                                                    .countTaskDetail !=
                                                                null)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  0,
                                                                  10,
                                                                  0,
                                                                  10,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  constraints:
                                                                      const BoxConstraints(
                                                                    minHeight:
                                                                        10,
                                                                    minWidth: double
                                                                        .infinity,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color
                                                                            .fromARGB(
                                                                          167,
                                                                          36,
                                                                          80,
                                                                          128,
                                                                        ),
                                                                        blurRadius:
                                                                            3.0,
                                                                        offset:
                                                                            Offset(
                                                                          0,
                                                                          0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.1,
                                                                      ),
                                                                    ],
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10.0,
                                                                    ),
                                                                    color: const Color
                                                                        .fromARGB(
                                                                      167,
                                                                      36,
                                                                      80,
                                                                      128,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      ExpansionTile(
                                                                    trailing:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255,
                                                                      ),
                                                                      size:
                                                                          15.0,
                                                                    ),
                                                                    title: Text(
                                                                      "History ",
                                                                      style:
                                                                          textStyleColorWhiteB,
                                                                    ),
                                                                    children: [
                                                                      for (int x =
                                                                              0;
                                                                          datadetail.listSvcKendaraanDetail![index].countTaskDetail != null
                                                                              ? x < datadetail.listSvcKendaraanDetail![index].countTaskDetail!.length
                                                                              : x < 0;
                                                                          x++)
                                                                        Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.fromLTRB(
                                                                              25,
                                                                              0,
                                                                              20,
                                                                              15,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    "${datadetail.listSvcKendaraanDetail![index].countTaskDetail![x].CreatedDate} - ${datadetail.listSvcKendaraanDetail![index].countTaskDetail![x].Name}",
                                                                                    style: textStyleColorWhiteBI,
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    datadetail.listSvcKendaraanDetail![index].countTaskDetail![x].TaskNote,
                                                                                    style: textStyleColorWhiteB,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      10,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        "Status :",
                                                                        style:
                                                                            textStyleColorYellow,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: DropdownSearch<
                                                                        TaskStatus>(
                                                                      popupProps:
                                                                          PopupProps
                                                                              .dialog(
                                                                        dialogProps:
                                                                            const DialogProps(
                                                                          shape:
                                                                              Border.symmetric(
                                                                            vertical:
                                                                                BorderSide.none,
                                                                          ),
                                                                        ),
                                                                        showSearchBox:
                                                                            true,
                                                                        searchFieldProps:
                                                                            TextFieldProps(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "Search..",
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  134,
                                                                                  134,
                                                                                  134,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  134,
                                                                                  134,
                                                                                  134,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        itemBuilder: (context,
                                                                                item,
                                                                                isSelected) =>
                                                                            ListTile(
                                                                          title:
                                                                              Text(
                                                                            item.text,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      dropdownDecoratorProps:
                                                                          DropDownDecoratorProps(
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintStyle:
                                                                              textStyleColorYellow,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                36,
                                                                                80,
                                                                                128,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                36,
                                                                                80,
                                                                                128,
                                                                              ),
                                                                              width: 2,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                          () {
                                                                            taskStatus =
                                                                                value!.text;

                                                                            taskStatusID =
                                                                                value.iD.toUpperCase();

                                                                            taskStatusController.text =
                                                                                taskStatus;

                                                                            taskStatusIDController.text =
                                                                                taskStatusID;
                                                                          },
                                                                        );
                                                                      },
                                                                      dropdownBuilder:
                                                                          (context, selectedItem) =>
                                                                              Text(
                                                                        taskStatus !=
                                                                                ''
                                                                            ? taskStatus
                                                                            : datadetail.listSvcKendaraanDetail![index].statusName,
                                                                        style:
                                                                            textStyleColorYellow,
                                                                      ),
                                                                      asyncItems:
                                                                          (String
                                                                              filter) async {
                                                                        var response =
                                                                            await http.get(
                                                                          Uri.parse(
                                                                            "${urlApi()}SvcKendaraan/GetTaskStatusSvcKendaraan/5",
                                                                          ),
                                                                        );
                                                                        if (response.statusCode !=
                                                                            200) {
                                                                          return [];
                                                                        }
                                                                        List allTaskStatus = (jsonDecode(
                                                                            response
                                                                                .body) as Map<
                                                                            String,
                                                                            dynamic>)["listTaskStatusSvc"];
                                                                        List<TaskStatus>
                                                                            allModelTaskStatus =
                                                                            [];

                                                                        for (var element
                                                                            in allTaskStatus) {
                                                                          allModelTaskStatus
                                                                              .add(
                                                                            TaskStatus(
                                                                              iD: element["iD"],
                                                                              text: element["text"],
                                                                            ),
                                                                          );
                                                                        }
                                                                        return allModelTaskStatus;
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        false,
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          taskStatusIDController,
                                                                      autocorrect:
                                                                          false,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Task Status',
                                                                        hintStyle:
                                                                            textStyleColorYellow,
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              167,
                                                                              36,
                                                                              80,
                                                                              128,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        "Keterangan :",
                                                                        style:
                                                                            textStyleColorYellow,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        TextFormField(
                                                                      style:
                                                                          textStyleColorYellow,
                                                                      autocorrect:
                                                                          false,
                                                                      controller:
                                                                          ketController,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        errorStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            17,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                        errorBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        hintText:
                                                                            'Keterangan',
                                                                        hintStyle:
                                                                            textStyleColorYellow,
                                                                        labelText:
                                                                            'Keterangan',
                                                                        labelStyle:
                                                                            textStyleColorYellow,
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              167,
                                                                              36,
                                                                              80,
                                                                              128,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              167,
                                                                              36,
                                                                              80,
                                                                              128,
                                                                            ),
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                10,
                                                                0,
                                                                20,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  OutlinedButton(
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      side:
                                                                          const BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Color
                                                                            .fromARGB(
                                                                          255,
                                                                          53,
                                                                          104,
                                                                          159,
                                                                        ),
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      fixedSize:
                                                                          Size(
                                                                        ResponsiveValue<double>(context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(
                                                                                    name: TABLET,
                                                                                    value: 200,
                                                                                    landscapeValue: 200,
                                                                                  ),
                                                                                  const Condition.largerThan(
                                                                                    name: TABLET,
                                                                                    value: 200,
                                                                                    landscapeValue: 200,
                                                                                    breakpoint: 800,
                                                                                  ),
                                                                                ],
                                                                                defaultValue: 130)
                                                                            .value,
                                                                        ResponsiveValue<
                                                                            double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 55,
                                                                                landscapeValue: 55),
                                                                            const Condition.largerThan(
                                                                                name: TABLET,
                                                                                value: 55,
                                                                                landscapeValue: 55,
                                                                                breakpoint: 800),
                                                                          ],
                                                                          defaultValue:
                                                                              50,
                                                                        ).value,
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          const Color
                                                                              .fromARGB(
                                                                        255,
                                                                        53,
                                                                        104,
                                                                        159,
                                                                      ),
                                                                    ).copyWith(
                                                                      overlayColor:
                                                                          MaterialStateProperty.resolveWith<
                                                                              Color?>(
                                                                        (Set<MaterialState>
                                                                            states) {
                                                                          if (states
                                                                              .contains(MaterialState.pressed)) {
                                                                            return const Color.fromARGB(
                                                                              255,
                                                                              84,
                                                                              157,
                                                                              235,
                                                                            );
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      var updateSvcKendaraan =
                                                                          ListSvcKendaraanUpdate(
                                                                        iD: iDController
                                                                            .text,
                                                                        taskStatusID:
                                                                            taskStatusIDController.text,
                                                                        taskNote:
                                                                            ketController.text,
                                                                      );

                                                                      try {
                                                                        var resp = await ref
                                                                            .read(updateSvcKendaraanFormProviderDetail)
                                                                            .onUpdateSvcKendaraan(updateSvcKendaraan);

                                                                        if (resp.statusMessage ==
                                                                            "Success Updated") {
                                                                          ketController
                                                                              .clear();
                                                                        }

                                                                        Navigator.of(context)
                                                                            .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage(),
                                                                          ),
                                                                          (route) =>
                                                                              false,
                                                                        );

                                                                        notifUpdated(
                                                                            context);
                                                                      } catch (e) {
                                                                        Navigator.of(context)
                                                                            .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage(),
                                                                          ),
                                                                          (route) =>
                                                                              false,
                                                                        );

                                                                        catchError(
                                                                          context,
                                                                          e,
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      children: <Widget>[
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            "Simpan",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const MyAlertDialog()
                                            : const notActivetoken(),
                                error: (err, stack) => Text('Error $err'),
                                loading: () => const Center(
                                  child: Column(
                                    children: [loadingAnimation()],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const Watermark(),
            ],
          ),
        ),
      ),
    );
  }

  void notifUpdated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ("Success Updated" == "Success Updated")
            ? const Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text(("Success Updated" == "Success Updated")
            ? "Task berhasil di update dengan status ${taskStatusController.text} "
            : "Task gagal di update "),
      ),
    );
  }
}
