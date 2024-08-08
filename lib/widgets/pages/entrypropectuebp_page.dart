// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';

import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/widgets/model/prospectopsimodel.dart';
import 'package:awas_ace/widgets/model/prospectuebp.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;

class EntryProspectUEbpPage extends ConsumerStatefulWidget {
  const EntryProspectUEbpPage({super.key});

  static const String routeName = "/entryProspectUEbpPage";

  @override
  _EntryProspectUEbpPageState createState() => _EntryProspectUEbpPageState();
}

class _EntryProspectUEbpPageState extends ConsumerState<EntryProspectUEbpPage> {
  Widget titleBar = const Text(
    "Entry Prospect UE BP",
    style: TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleBar,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(
          255,
          3,
          116,
          18,
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(
        255,
        3,
        116,
        18,
      ),
      body: const BodyEntryTSalesWidget(),
    );
  }
}

class BodyEntryTSalesWidget extends StatefulWidget {
  const BodyEntryTSalesWidget({super.key});

  @override
  State<BodyEntryTSalesWidget> createState() => _BodyEntryTSalesWidgetState();
}

class _BodyEntryTSalesWidgetState extends State<BodyEntryTSalesWidget> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController noPolController = TextEditingController();
  TextEditingController branchBusinessIDController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();
  TextEditingController idVehicleTypeController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleDamageController = TextEditingController();
  TextEditingController idServiceBPController = TextEditingController();
  TextEditingController serviceBPController = TextEditingController();

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? idVtype;
  String? vtype;
  String? idSvcBP;
  String? svcBP;
  String? branchID;

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Username');
      branchID = prefs.getString('BranchID');

      branchBusinessIDController.text = branchID!.toUpperCase();
    });
  }

  bool notShow = false;

  @override
  Widget build(BuildContext context) {
    var textStyleColorGreen = TextStyle(
      color: const Color.fromARGB(
        255,
        3,
        116,
        18,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
    );

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
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
    );

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
          255,
          3,
          116,
          18,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Consumer(
            builder: (context, WidgetRef ref, child) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      BootstrapContainer(
                        fluid: true,
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        children: <Widget>[
                          BootstrapRow(
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "No. Polisi  :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ),
                                        autocorrect: false,
                                        controller: noPolController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "No. Polisi tidak boleh kosong.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              17,
                                              0,
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                          ),
                                          hintText: 'B-1234-JKL ',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'No. Polisi ',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              116,
                                              18,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: notShow,
                                      child: TextFormField(
                                        controller: branchBusinessIDController,
                                        autocorrect: false,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: 'BranchBusinessID',
                                          hintStyle: textStyleColorWhite,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Nama :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ),
                                        autocorrect: false,
                                        controller: namaController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Nama tidak boleh kosong.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              17,
                                              0,
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                          ),
                                          hintText: 'Nama ',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Nama ',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              116,
                                              18,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                              width: 2,
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
                            ],
                          ),
                          BootstrapRow(
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "No.HP :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ),
                                        autocorrect: false,
                                        controller: noHPController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "No. HP tidak boleh kosong.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              17,
                                              0,
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                          ),
                                          hintText: 'No. HP',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'No. HP',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              116,
                                              18,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                              width: 2,
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
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tahun Kendaraan :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ),
                                        autocorrect: false,
                                        controller: vehicleYearController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Tahun Kendaraan tidak boleh kosong.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              17,
                                              0,
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                          ),
                                          hintText: 'Tahun Kendaraan',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Tahun Kendaraan',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              116,
                                              18,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                              width: 2,
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
                            ],
                          ),
                          BootstrapRow(
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tipe Kendaraan :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: DropdownSearch<ProspectOpsi>(
                                        validator: (val) {
                                          if (val == null || val.name == '') {
                                            return "Tipe kendaraan tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                        popupProps: PopupProps.dialog(
                                          dialogProps: const DialogProps(
                                            shape: Border.symmetric(
                                                vertical: BorderSide.none),
                                          ),
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: "Search..",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    134,
                                                    134,
                                                    134,
                                                  ),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    3,
                                                    116,
                                                    18,
                                                  ),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          itemBuilder:
                                              (context, item, isSelected) =>
                                                  ListTile(
                                            title: Text(
                                              item.name.toUpperCase(),
                                            ),
                                          ),
                                        ),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            errorStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                            errorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  17,
                                                  0,
                                                ),
                                              ),
                                            ),
                                            hintStyle: textStyleColorWhite,
                                            labelText: 'Tipe Kendaraan',
                                            labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            idVtype = value!.iD;
                                            vtype = value.name;

                                            vehicleTypeController.text =
                                                idVtype.toString();
                                            idVehicleTypeController.text =
                                                idVtype!;
                                          });
                                        },
                                        dropdownBuilder:
                                            (context, selectedItem) => Text(
                                          vtype != null
                                              ? vtype.toString()
                                              : "Belum memilih model",
                                          style: textStyleColorGreen,
                                        ),
                                        asyncItems: (String filter) async {
                                          var response = await http.get(
                                            Uri.parse(
                                              "${urlApi()}Prospect/GetVtype",
                                            ),
                                          );
                                          if (response.statusCode != 200) {
                                            return [];
                                          }
                                          List allVtype =
                                              (jsonDecode(response.body) as Map<
                                                  String,
                                                  dynamic>)["listProspectOpsi"];
                                          List<ProspectOpsi> allModelVtype = [];

                                          for (var element in allVtype) {
                                            allModelVtype.add(
                                              ProspectOpsi(
                                                iD: element["iD"],
                                                name: element["name"],
                                              ),
                                            );
                                          }
                                          return allModelVtype;
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: notShow,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 15),
                                        child: TextFormField(
                                          controller: idVehicleTypeController,
                                          autocorrect: false,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintText: 'VtypeID',
                                            hintStyle: textStyleColorGreen,
                                            labelText: 'VtypeID',
                                            labelStyle: textStyleColorGreen,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Kerusakan Kendaraan :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ),
                                        autocorrect: false,
                                        controller: vehicleDamageController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Kerusakan Kendaraan tidak boleh kosong.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              17,
                                              0,
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                          ),
                                          hintText: 'Kerusakan Kendaraan',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Kerusakan Kendaraan',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              116,
                                              18,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                              width: 2,
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
                            ],
                          ),
                          BootstrapRow(
                            children: [
                              BootstrapCol(
                                sizes: 'col-md-6 col-12',
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Bengkel BP :",
                                          style: textStyleColorGreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: DropdownSearch<ProspectOpsi>(
                                        validator: (val) {
                                          if (val == null || val.name == '') {
                                            return "Bengkel BP tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                        popupProps: PopupProps.dialog(
                                          dialogProps: const DialogProps(
                                            shape: Border.symmetric(
                                                vertical: BorderSide.none),
                                          ),
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: "Search..",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    134,
                                                    134,
                                                    134,
                                                  ),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    3,
                                                    116,
                                                    18,
                                                  ),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          itemBuilder:
                                              (context, item, isSelected) =>
                                                  ListTile(
                                            title: Text(
                                              item.name.toUpperCase(),
                                            ),
                                          ),
                                        ),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            errorStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                17,
                                                0,
                                              ),
                                            ),
                                            errorBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  17,
                                                  0,
                                                ),
                                              ),
                                            ),
                                            hintStyle: textStyleColorWhite,
                                            labelText: 'Bengkel BP',
                                            labelStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                3,
                                                116,
                                                18,
                                              ),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            idSvcBP = value!.iD;
                                            svcBP = value.name;

                                            serviceBPController.text =
                                                idSvcBP.toString();
                                            idServiceBPController.text =
                                                idSvcBP!;
                                          });
                                        },
                                        dropdownBuilder:
                                            (context, selectedItem) => Text(
                                          svcBP != null
                                              ? svcBP.toString()
                                              : "Belum memilih bengkel BP",
                                          style: textStyleColorGreen,
                                        ),
                                        asyncItems: (String filter) async {
                                          var response = await http.get(
                                            Uri.parse(
                                              "${urlApi()}Prospect/GetServiceBP",
                                            ),
                                          );
                                          if (response.statusCode != 200) {
                                            return [];
                                          }
                                          List allVtype =
                                              (jsonDecode(response.body) as Map<
                                                  String,
                                                  dynamic>)["listProspectOpsi"];
                                          List<ProspectOpsi> allModelVtype = [];

                                          for (var element in allVtype) {
                                            allModelVtype.add(
                                              ProspectOpsi(
                                                iD: element["iD"],
                                                name: element["code"],
                                              ),
                                            );
                                          }
                                          return allModelVtype;
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: notShow,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 15),
                                        child: TextFormField(
                                          controller: idServiceBPController,
                                          autocorrect: false,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintText: 'IDSvcBP',
                                            hintStyle: textStyleColorGreen,
                                            labelText: 'IDSvcBP',
                                            labelStyle: textStyleColorGreen,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BootstrapCol(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Column(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          fixedSize: Size(
                                            ResponsiveValue<double>(context,
                                                    conditionalValues: [
                                                      const Condition.equals(
                                                        name: TABLET,
                                                        value: 200,
                                                        landscapeValue: 200,
                                                      ),
                                                      const Condition
                                                          .largerThan(
                                                          name: TABLET,
                                                          value: 200,
                                                          landscapeValue: 200,
                                                          breakpoint: 800),
                                                    ],
                                                    defaultValue: 130)
                                                .value,
                                            ResponsiveValue<double>(
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
                                              defaultValue: 50,
                                            ).value,
                                          ),
                                          elevation: 0,
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            3,
                                            116,
                                            18,
                                          ),
                                        ).copyWith(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return const Color.fromARGB(
                                                  255,
                                                  1,
                                                  209,
                                                  29,
                                                );
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                            try {
                                              var uebp = ListEntryProspectUEBP(
                                                branchBusinessUnitID:
                                                    branchBusinessIDController
                                                        .text,
                                                branchBPID:
                                                    idServiceBPController.text,
                                                customerServiceID: '',
                                                vehicleTypeID:
                                                    idVehicleTypeController
                                                        .text,
                                                nomorPolisi:
                                                    noPolController.text,
                                                nama: namaController.text,
                                                noHandPhone:
                                                    noHPController.text,
                                                tahunKendaraan:
                                                    vehicleYearController.text,
                                                keterangan:
                                                    vehicleDamageController
                                                        .text,
                                              );

                                              var resp = await ref
                                                  .read(
                                                      prospectUEBPFormProvider)
                                                  .onSubmitProspectUEBP(uebp);

                                              if (resp.statusMessage ==
                                                  "Sucess") {
                                                branchBusinessIDController
                                                    .clear();
                                                idServiceBPController.clear();
                                                vehicleTypeController.clear();
                                                noPolController.clear();
                                                namaController.clear();
                                                noHPController.clear();
                                                vehicleYearController.clear();
                                                vehicleDamageController.clear();
                                                formkey.currentState!.reset();
                                              }

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage()),
                                                      (route) => false);

                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  title: const Text("Info"),
                                                  content: const Text(
                                                    "Terima kasih, Pastikan mobil masuk dalam kurun waktu 45 hari, dan nikmati poin anda.",
                                                  ),
                                                  actions: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide.none,
                                                      ),
                                                      child: const Text("Ok"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } catch (e) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage()),
                                                      (route) => false);

                                              catchError(context, e);
                                            }
                                          }
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Simpan",
                                                textAlign: TextAlign.center,
                                                style: textStyleColorWhite,
                                              ),
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
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
