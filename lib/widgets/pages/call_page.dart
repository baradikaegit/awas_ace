// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallPage extends ConsumerStatefulWidget {
  const CallPage({super.key});

  static const String routeName = "/callPage";

  @override
  _CallPageState createState() => _CallPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _CallPageState extends ConsumerState<CallPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController periodeController = TextEditingController();
  TextEditingController roPeroranganController = TextEditingController();
  TextEditingController roPerusahaanController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController databaseController = TextEditingController();
  TextEditingController digitalLeadsController = TextEditingController();
  TextEditingController movingExhibitionController = TextEditingController();
  TextEditingController mobileCanvasingController = TextEditingController();
  TextEditingController walkInCustomerController = TextEditingController();
  TextEditingController callInController = TextEditingController();
  TextEditingController communityController = TextEditingController();

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;

  @override
  void initState() {
    super.initState();
    periodeController.text = dateNow;

    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Username');
    });
  }

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Call",
            style: TextStyle(color: Colors.white),
          ),
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
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                SingleChildScrollView(
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
                                          "Periode :",
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
                                        controller: periodeController,
                                        autocorrect: false,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: 'Periode',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Periode',
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
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2050),
                                          );
                                          if (pickedDate != null) {
                                            String formatDate =
                                                DateFormat('MM/dd/yyyy')
                                                    .format(pickedDate);

                                            setState(() {
                                              periodeController.text =
                                                  formatDate;
                                            });
                                          } else {
                                            //print("Tanggal tidak dipilih");

                                            periodeController.text = dateNow;
                                          }
                                        },
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
                                          "Repeat Order Perorangan :",
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
                                        controller: roPeroranganController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Repeat Order Perorangan tidak boleh kosong.";
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
                                          hintText: 'Repeat Order Perorangan',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Repeat Order Perorangan',
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
                                          "Repeat Order Perusahaan :",
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
                                        controller: roPerusahaanController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Repeat Order Perusahaan tidak boleh kosong.";
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
                                          hintText: 'Repeat Order Perusahaan',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Repeat Order Perusahaan',
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
                                          "Reference :",
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
                                        controller: referenceController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Reference tidak boleh kosong.";
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
                                          hintText: 'Reference',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Reference',
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
                                          "Database :",
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
                                        controller: databaseController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Database tidak boleh kosong.";
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
                                          hintText: 'Database',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Database',
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
                                          "Digital Leads :",
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
                                        controller: digitalLeadsController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Digital Leads tidak boleh kosong.";
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
                                          hintText: 'Digital Leads',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Digital Leads',
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
                                          "Moving Exhibition :",
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
                                        controller: movingExhibitionController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Moving Exhibition tidak boleh kosong.";
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
                                          hintText: 'Moving Exhibition',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Moving Exhibition',
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
                                          "Mobile/Canvasing :",
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
                                        controller: mobileCanvasingController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Mobile/Canvasing tidak boleh kosong.";
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
                                          hintText: 'Mobile/Canvasing',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Mobile/Canvasing',
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
                                          "Walk In Customer :",
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
                                        controller: walkInCustomerController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Walk In Customer tidak boleh kosong.";
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
                                          hintText: 'Walk In Customer',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Walk In Customer',
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
                                          "Call In :",
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
                                        controller: callInController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Call In tidak boleh kosong.";
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
                                          hintText: 'Call In',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Call In',
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
                                          "Community :",
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
                                        controller: communityController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Community tidak boleh kosong.";
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
                                          hintText: 'Community',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Community',
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
                                        onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
