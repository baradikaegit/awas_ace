// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/callin_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/widgets/model/callinmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallPage extends ConsumerStatefulWidget {
  final Object? callDateObject;

  const CallPage({super.key, required this.callDateObject});

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
  TextEditingController newIDController = TextEditingController();
  TextEditingController branchBusinessIDController = TextEditingController();
  TextEditingController salesmanIDController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  List<TextEditingController> listNewIDController = [];
  List<TextEditingController> amountReferensiController = [];
  List<TextEditingController> idReferensiController = [];
  List<TextEditingController> codeReferensiController = [];

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? sid;
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
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');

      branchBusinessIDController.text = branchID!.toUpperCase();
      salesmanIDController.text = sid!.toUpperCase();
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
    bool notShow = false;

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
          child: Consumer(
            builder: (context, WidgetRef ref, child) {
              var callDate = widget.callDateObject.toString();

              final callInData = ref.watch(callInList(callDate.toString()));

              return Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: callInData.when(
                            data: (dataCallIn) =>
                                (dataCallIn.listCallin != null)
                                    ? dataCallIn.listCallin!.isNotEmpty
                                        ? ListView.builder(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              for (int i = 0;
                                                  i <
                                                      dataCallIn
                                                          .listCallin!.length;
                                                  i++) {
                                                dataCallIn.listCallin![i]
                                                            .callCustomerHeaderID ==
                                                        ''
                                                    ? amountReferensiController
                                                        .add(
                                                            TextEditingController(
                                                                text: '0'))
                                                    : amountReferensiController
                                                        .add(TextEditingController(
                                                            text: dataCallIn
                                                                .listCallin![i]
                                                                .amount
                                                                .toString()));

                                                idReferensiController.add(
                                                  TextEditingController(
                                                    text: dataCallIn
                                                        .listCallin![i]
                                                        .referensiID
                                                        .toString(),
                                                  ),
                                                );

                                                listNewIDController.add(
                                                  TextEditingController(
                                                    text: dataCallIn
                                                        .listCallin![i]
                                                        .callCustomerHeaderID
                                                        .toString(),
                                                  ),
                                                );

                                                codeReferensiController.add(
                                                  TextEditingController(
                                                    text: dataCallIn
                                                        .listCallin![i].code
                                                        .toString(),
                                                  ),
                                                );
                                              }

                                              dataCallIn.listCallin![index]
                                                          .callDate ==
                                                      ""
                                                  ? periodeController.text =
                                                      dateNow
                                                  : periodeController.text =
                                                      dataCallIn
                                                          .listCallin![index]
                                                          .callDate;

                                              newIDController.text = dataCallIn
                                                  .listCallin![index]
                                                  .callCustomerHeaderID;

                                              typeController.text = dataCallIn
                                                  .listCallin![index].type;

                                              return BootstrapContainer(
                                                fluid: true,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 30, 0, 0),
                                                children: <Widget>[
                                                  BootstrapRow(
                                                    children: <BootstrapCol>[
                                                      BootstrapCol(
                                                        sizes:
                                                            'col-md-6 col-12',
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      15),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Periode :",
                                                                  style:
                                                                      textStyleColorGreen,
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
                                                                      20),
                                                              child:
                                                                  TextFormField(
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    255,
                                                                    3,
                                                                    116,
                                                                    18,
                                                                  ),
                                                                ),
                                                                controller:
                                                                    periodeController,
                                                                autocorrect:
                                                                    false,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Periode',
                                                                  hintStyle:
                                                                      textStyleColorGreen,
                                                                  labelText:
                                                                      'Periode',
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                      255,
                                                                      3,
                                                                      116,
                                                                      18,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        3,
                                                                        116,
                                                                        18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        3,
                                                                        116,
                                                                        18,
                                                                      ),
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  DateTime?
                                                                      pickedDate =
                                                                      await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2000),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2050),
                                                                  );
                                                                  if (pickedDate !=
                                                                      null) {
                                                                    String
                                                                        formatDate =
                                                                        DateFormat('yyyy-MM-dd')
                                                                            .format(pickedDate);

                                                                    setState(
                                                                        () {
                                                                      Navigator
                                                                          .pushNamed(
                                                                        context,
                                                                        CallPage
                                                                            .routeName,
                                                                        arguments:
                                                                            formatDate,
                                                                      );
                                                                    });
                                                                  } else {
                                                                    periodeController
                                                                            .text =
                                                                        dateNow;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: notShow,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      newIDController,
                                                                  autocorrect:
                                                                      false,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'NewID',
                                                                    hintStyle:
                                                                        textStyleColorGreen,
                                                                    labelText:
                                                                        'NewID',
                                                                    labelStyle:
                                                                        textStyleColorGreen,
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
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
                                                            Visibility(
                                                              visible: notShow,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      branchBusinessIDController,
                                                                  autocorrect:
                                                                      false,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'BranchBusinessID',
                                                                    hintStyle:
                                                                        textStyleColorGreen,
                                                                    labelText:
                                                                        'BranchBusinessID',
                                                                    labelStyle:
                                                                        textStyleColorGreen,
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
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
                                                            Visibility(
                                                              visible: notShow,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      salesmanIDController,
                                                                  autocorrect:
                                                                      false,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'SalesmanID',
                                                                    hintStyle:
                                                                        textStyleColorGreen,
                                                                    labelText:
                                                                        'SalesmanID',
                                                                    labelStyle:
                                                                        textStyleColorGreen,
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
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
                                                            Visibility(
                                                              visible: notShow,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      typeController,
                                                                  autocorrect:
                                                                      false,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Type',
                                                                    hintStyle:
                                                                        textStyleColorGreen,
                                                                    labelText:
                                                                        'Type',
                                                                    labelStyle:
                                                                        textStyleColorGreen,
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
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
                                                    ],
                                                  ),
                                                  for (int formCall = 0;
                                                      formCall <
                                                          dataCallIn.listCallin!
                                                              .length;
                                                      formCall++)
                                                    BootstrapRow(
                                                      children: <BootstrapCol>[
                                                        BootstrapCol(
                                                          sizes:
                                                              'col-md-6 col-12',
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  15,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    dataCallIn.listCallin![formCall].code ==
                                                                            'RT'
                                                                        ? "Repeat Order Perorangan :"
                                                                        : dataCallIn.listCallin![formCall].code ==
                                                                                'RR'
                                                                            ? "Repeat Order Non Perorangan"
                                                                            : dataCallIn.listCallin![formCall].code == 'RF'
                                                                                ? "Reference"
                                                                                : dataCallIn.listCallin![formCall].code == 'DB'
                                                                                    ? "Database"
                                                                                    : dataCallIn.listCallin![formCall].code == 'MS'
                                                                                        ? "Digital Leads"
                                                                                        : dataCallIn.listCallin![formCall].code == 'ME'
                                                                                            ? "Moving Exhibition"
                                                                                            : dataCallIn.listCallin![formCall].code == 'CV'
                                                                                                ? "Mobile/Canvasing"
                                                                                                : dataCallIn.listCallin![formCall].code == 'WK'
                                                                                                    ? "Walk In Customer"
                                                                                                    : dataCallIn.listCallin![formCall].code == 'CI'
                                                                                                        ? "Call In"
                                                                                                        : "Community",
                                                                    style:
                                                                        textStyleColorGreen,
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
                                                                  20,
                                                                ),
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                      255,
                                                                      3,
                                                                      116,
                                                                      18,
                                                                    ),
                                                                  ),
                                                                  inputFormatters: <TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  autocorrect:
                                                                      false,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      amountReferensiController[
                                                                          formCall],
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    errorStyle:
                                                                        const TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
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
                                                                        color: Color
                                                                            .fromARGB(
                                                                          255,
                                                                          255,
                                                                          17,
                                                                          0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    hintText: dataCallIn.listCallin![formCall].code ==
                                                                            'RT'
                                                                        ? "Repeat Order Perorangan :"
                                                                        : dataCallIn.listCallin![formCall].code ==
                                                                                'RR'
                                                                            ? "Repeat Order Non Perorangan"
                                                                            : dataCallIn.listCallin![formCall].code == 'RF'
                                                                                ? "Reference"
                                                                                : dataCallIn.listCallin![formCall].code == 'DB'
                                                                                    ? "Database"
                                                                                    : dataCallIn.listCallin![formCall].code == 'MS'
                                                                                        ? "Digital Leads"
                                                                                        : dataCallIn.listCallin![formCall].code == 'ME'
                                                                                            ? "Moving Exhibition"
                                                                                            : dataCallIn.listCallin![formCall].code == 'CV'
                                                                                                ? "Mobile/Canvasing"
                                                                                                : dataCallIn.listCallin![formCall].code == 'WK'
                                                                                                    ? "Walk In Customer"
                                                                                                    : dataCallIn.listCallin![formCall].code == 'CI'
                                                                                                        ? "Call In"
                                                                                                        : "Community",
                                                                    hintStyle:
                                                                        textStyleColorGreen,
                                                                    labelText: dataCallIn.listCallin![formCall].code ==
                                                                            'RT'
                                                                        ? "Repeat Order Perorangan :"
                                                                        : dataCallIn.listCallin![formCall].code ==
                                                                                'RR'
                                                                            ? "Repeat Order Non Perorangan"
                                                                            : dataCallIn.listCallin![formCall].code == 'RF'
                                                                                ? "Reference"
                                                                                : dataCallIn.listCallin![formCall].code == 'DB'
                                                                                    ? "Database"
                                                                                    : dataCallIn.listCallin![formCall].code == 'MS'
                                                                                        ? "Digital Leads"
                                                                                        : dataCallIn.listCallin![formCall].code == 'ME'
                                                                                            ? "Moving Exhibition"
                                                                                            : dataCallIn.listCallin![formCall].code == 'CV'
                                                                                                ? "Mobile/Canvasing"
                                                                                                : dataCallIn.listCallin![formCall].code == 'WK'
                                                                                                    ? "Walk In Customer"
                                                                                                    : dataCallIn.listCallin![formCall].code == 'CI'
                                                                                                        ? "Call In"
                                                                                                        : "Community",
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        3,
                                                                        116,
                                                                        18,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
                                                                          255,
                                                                          3,
                                                                          116,
                                                                          18,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Color
                                                                            .fromARGB(
                                                                          255,
                                                                          3,
                                                                          116,
                                                                          18,
                                                                        ),
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible:
                                                                    notShow,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        idReferensiController[
                                                                            formCall],
                                                                    autocorrect:
                                                                        false,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText: dataCallIn.listCallin![formCall].code ==
                                                                              'RT'
                                                                          ? "Repeat Order Perorangan :"
                                                                          : dataCallIn.listCallin![formCall].code == 'RR'
                                                                              ? "Repeat Order Non Perorangan"
                                                                              : dataCallIn.listCallin![formCall].code == 'RF'
                                                                                  ? "Reference"
                                                                                  : dataCallIn.listCallin![formCall].code == 'DB'
                                                                                      ? "Database"
                                                                                      : dataCallIn.listCallin![formCall].code == 'MS'
                                                                                          ? "Digital Leads"
                                                                                          : dataCallIn.listCallin![formCall].code == 'ME'
                                                                                              ? "Moving Exhibition"
                                                                                              : dataCallIn.listCallin![formCall].code == 'CV'
                                                                                                  ? "Mobile/Canvasing"
                                                                                                  : dataCallIn.listCallin![formCall].code == 'WK'
                                                                                                      ? "Walk In Customer"
                                                                                                      : dataCallIn.listCallin![formCall].code == 'CI'
                                                                                                          ? "Call In"
                                                                                                          : "Community",
                                                                      labelStyle:
                                                                          textStyleColorGreen,
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color.fromARGB(
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
                                                              Visibility(
                                                                visible:
                                                                    notShow,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        codeReferensiController[
                                                                            formCall],
                                                                    autocorrect:
                                                                        false,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText: dataCallIn.listCallin![formCall].code ==
                                                                              'RT'
                                                                          ? "Repeat Order Perorangan :"
                                                                          : dataCallIn.listCallin![formCall].code == 'RR'
                                                                              ? "Repeat Order Non Perorangan"
                                                                              : dataCallIn.listCallin![formCall].code == 'RF'
                                                                                  ? "Reference"
                                                                                  : dataCallIn.listCallin![formCall].code == 'DB'
                                                                                      ? "Database"
                                                                                      : dataCallIn.listCallin![formCall].code == 'MS'
                                                                                          ? "Digital Leads"
                                                                                          : dataCallIn.listCallin![formCall].code == 'ME'
                                                                                              ? "Moving Exhibition"
                                                                                              : dataCallIn.listCallin![formCall].code == 'CV'
                                                                                                  ? "Mobile/Canvasing"
                                                                                                  : dataCallIn.listCallin![formCall].code == 'WK'
                                                                                                      ? "Walk In Customer"
                                                                                                      : dataCallIn.listCallin![formCall].code == 'CI'
                                                                                                          ? "Call In"
                                                                                                          : "Community",
                                                                      labelStyle:
                                                                          textStyleColorGreen,
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color.fromARGB(
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
                                                              Visibility(
                                                                visible:
                                                                    notShow,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        listNewIDController[
                                                                            formCall],
                                                                    autocorrect:
                                                                        false,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "NewID 2",
                                                                      labelStyle:
                                                                          textStyleColorGreen,
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color.fromARGB(
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
                                                      ],
                                                    ),
                                                  BootstrapRow(
                                                    children: [
                                                      BootstrapCol(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 0, 20),
                                                          child: Column(
                                                            children: [
                                                              OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  fixedSize:
                                                                      Size(
                                                                    ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 200,
                                                                                landscapeValue: 200,
                                                                              ),
                                                                              const Condition.largerThan(name: TABLET, value: 200, landscapeValue: 200, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                130)
                                                                        .value,
                                                                    ResponsiveValue<
                                                                        double>(
                                                                      context,
                                                                      conditionalValues: [
                                                                        const Condition
                                                                            .equals(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                55,
                                                                            landscapeValue:
                                                                                55),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                55,
                                                                            landscapeValue:
                                                                                55,
                                                                            breakpoint:
                                                                                800),
                                                                      ],
                                                                      defaultValue:
                                                                          50,
                                                                    ).value,
                                                                  ),
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                    255,
                                                                    3,
                                                                    116,
                                                                    18,
                                                                  ),
                                                                ).copyWith(
                                                                  overlayColor:
                                                                      MaterialStateProperty
                                                                          .resolveWith<
                                                                              Color?>(
                                                                    (Set<MaterialState>
                                                                        states) {
                                                                      if (states
                                                                          .contains(
                                                                              MaterialState.pressed)) {
                                                                        return const Color
                                                                            .fromARGB(
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
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    if (typeController
                                                                            .text ==
                                                                        'Input') {
                                                                      var call =
                                                                          ListEntryCallin(
                                                                        callCustomerHeaderID:
                                                                            newIDController.text,
                                                                        branchBusinessUnitID:
                                                                            branchBusinessIDController.text,
                                                                        salesmanHeaderID:
                                                                            salesmanIDController.text,
                                                                        callDate:
                                                                            periodeController.text,
                                                                      );

                                                                      await ref
                                                                          .read(
                                                                              callFormProvider)
                                                                          .onSubmitCall(
                                                                              call);

                                                                      for (int indexSubmit =
                                                                              0;
                                                                          indexSubmit <
                                                                              dataCallIn.listCallin!.length;
                                                                          indexSubmit++) {
                                                                        var call2 =
                                                                            ListEntryCallinDetail(
                                                                          callCustomerHeaderID2:
                                                                              listNewIDController[indexSubmit].text,
                                                                          referensiID:
                                                                              idReferensiController[indexSubmit].text,
                                                                          amount:
                                                                              int.tryParse(amountReferensiController[indexSubmit].text),
                                                                        );

                                                                        var resp = await ref
                                                                            .read(callFormProvider2)
                                                                            .onSubmitCallDetail(call2);

                                                                        if (resp.statusMessage ==
                                                                            "Sucess") {
                                                                          idReferensiController[indexSubmit]
                                                                              .clear();
                                                                        }
                                                                      }

                                                                      Navigator.of(context).pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  const HomePage()),
                                                                          (route) =>
                                                                              false);

                                                                      sucessSubmit(
                                                                          context);
                                                                    } else {
                                                                      print(
                                                                          "update");
                                                                    }
                                                                  } catch (e) {
                                                                    Navigator.of(context).pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage()),
                                                                        (route) =>
                                                                            false);

                                                                    catchError(
                                                                        context,
                                                                        e);
                                                                  }
                                                                },
                                                                child: Stack(
                                                                  children: <Widget>[
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
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
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void sucessSubmit(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: ("Success" == "Success")
            ? Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text("Message : Success Insert"),
      ),
    );
  }
}
