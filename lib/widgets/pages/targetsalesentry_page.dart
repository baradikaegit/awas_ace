// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetsalesEntryPage extends StatefulWidget {
  final Object? salesmanID;

  const TargetsalesEntryPage({super.key, required this.salesmanID});

  static const String routeName = "/targetSalesEntryPage";

  @override
  State<TargetsalesEntryPage> createState() => _TargetsalesEntryPageState();
}

class _TargetsalesEntryPageState extends State<TargetsalesEntryPage> {
  Widget titleBar = const Text(
    "Entry Target Sales",
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
      resizeToAvoidBottomInset: false,
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

  TextEditingController callController = TextEditingController();
  TextEditingController prospectController = TextEditingController();
  TextEditingController hotController = TextEditingController();
  TextEditingController spkController = TextEditingController();
  TextEditingController doController = TextEditingController();

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;

  @override
  void initState() {
    super.initState();
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.start,
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
                                          "Call  :",
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
                                        controller: callController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Call  tidak boleh kosong.";
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
                                          hintText: 'Call ',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'Call ',
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
                                          " Prospect :",
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
                                        controller: prospectController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return " Prospect tidak boleh kosong.";
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
                                          hintText: ' Prospect',
                                          hintStyle: textStyleColorGreen,
                                          labelText: ' Prospect',
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
                                          "HOT :",
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
                                        controller: hotController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "HOT tidak boleh kosong.";
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
                                          hintText: 'HOT',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'HOT',
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
                                          "SPK :",
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
                                        controller: spkController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "SPK tidak boleh kosong.";
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
                                          hintText: 'SPK',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'SPK',
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
                                          "DO :",
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
                                        controller: doController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "DO tidak boleh kosong.";
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
                                          hintText: 'DO',
                                          hintStyle: textStyleColorGreen,
                                          labelText: 'DO',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
