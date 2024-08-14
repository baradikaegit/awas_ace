// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/targetsales_provider.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/succes_submit.dart';
import 'package:awas_ace/widgets/model/targetsalesmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetsalesEntryPage extends ConsumerStatefulWidget {
  final Object? linkPageObj;

  const TargetsalesEntryPage({super.key, required this.linkPageObj});

  static const String routeName = "/targetSalesEntryPage";

  @override
  _TargetsalesEntryPageState createState() => _TargetsalesEntryPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _TargetsalesEntryPageState extends ConsumerState<TargetsalesEntryPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController bulanController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController branchBusinessIDController = TextEditingController();
  TextEditingController salesmanIDController = TextEditingController();
  TextEditingController callController = TextEditingController();
  TextEditingController prospectController = TextEditingController();
  TextEditingController hotController = TextEditingController();
  TextEditingController spkController = TextEditingController();
  TextEditingController doController = TextEditingController();

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? sid;
  String? branchID;
  bool notShow = false;

  List<ModelMonth> monthOptions = [
    ModelMonth('January', 1),
    ModelMonth('February', 2),
    ModelMonth('March', 3),
    ModelMonth('April', 4),
    ModelMonth('May', 5),
    ModelMonth('June', 6),
    ModelMonth('July', 7),
    ModelMonth('August', 8),
    ModelMonth('September', 9),
    ModelMonth('October', 10),
    ModelMonth('November', 11),
    ModelMonth('December', 12)
  ];
  List<String> yearOPtions = [
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.utc(DateTime.now().year - 1))
  ];

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

    String monthNow = DateFormat('M').format(DateTime.now());
    String yearNow = DateFormat('yyyy').format(DateTime.now());

    Widget titleBar = Text(
      widget.linkPageObj == '$monthNow/$yearNow/0'
          ? "Entry Target Sales"
          : "Edit Target Sales",
      style: const TextStyle(color: Colors.white),
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
              var linkPageObj = widget.linkPageObj.toString();

              final dataTargetSales = ref.watch(targetSSCodeList(linkPageObj));

              return Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: dataTargetSales.when(
                            data: (data) => (data.listTargetSales != null)
                                ? ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context, index) {
                                      callController.text = data
                                                  .listTargetSales![index].call
                                                  .toString() ==
                                              '0'
                                          ? ''
                                          : data.listTargetSales![index].call
                                              .toString();

                                      prospectController.text = data
                                                  .listTargetSales![index]
                                                  .prospect
                                                  .toString() ==
                                              '0'
                                          ? ''
                                          : data
                                              .listTargetSales![index].prospect
                                              .toString();

                                      hotController.text = data
                                                  .listTargetSales![index].hot
                                                  .toString() ==
                                              '0'
                                          ? ''
                                          : data.listTargetSales![index].hot
                                              .toString();

                                      spkController.text = data
                                                  .listTargetSales![index].spk
                                                  .toString() ==
                                              '0'
                                          ? ''
                                          : data.listTargetSales![index].spk
                                              .toString();

                                      doController.text = data
                                                  .listTargetSales![index].dO
                                                  .toString() ==
                                              '0'
                                          ? ''
                                          : data.listTargetSales![index].dO
                                              .toString();

                                      String monthSelected = (linkPageObj ==
                                              '$monthNow/$yearNow/0')
                                          ? DateFormat('M')
                                              .format(DateTime.now())
                                          : data.listTargetSales!.isNotEmpty
                                              ? data
                                                  .listTargetSales![index].bulan
                                                  .toString()
                                              : '';

                                      String yearSelected = (linkPageObj ==
                                              '$monthNow/$yearNow/0')
                                          ? DateFormat('yyyy')
                                              .format(DateTime.now())
                                          : data.listTargetSales!.isNotEmpty
                                              ? data
                                                  .listTargetSales![index].tahun
                                                  .toString()
                                              : '';

                                      bulanController.text = data
                                          .listTargetSales![index].bulan
                                          .toString();
                                      tahunController.text = data
                                          .listTargetSales![index].tahun
                                          .toString();

                                      return BootstrapContainer(
                                        fluid: true,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 15, 0, 15),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    isExpanded: false,
                                                    value: monthSelected,
                                                    items: monthOptions
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            item.id.toString(),
                                                        child: Text(
                                                          item.value,
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        monthSelected = value!;
                                                        var yearSelected = data
                                                            .listTargetSales![
                                                                index]
                                                            .tahun;

                                                        var linkPage =
                                                            '$monthSelected/$yearSelected/0';

                                                        Navigator
                                                            .pushReplacementNamed(
                                                          context,
                                                          TargetsalesEntryPage
                                                              .routeName,
                                                          arguments: linkPage,
                                                        );
                                                      });
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      width: 160,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 14,
                                                        right: 14,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            3,
                                                            116,
                                                            18,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Color.fromARGB(
                                                        255,
                                                        3,
                                                        116,
                                                        18,
                                                      ),
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: Colors.white,
                                                      ),
                                                      offset:
                                                          const Offset(0, 0),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(15),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(
                                                                    true),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 15, 0, 15),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    isExpanded: false,
                                                    value: yearSelected,
                                                    items: yearOPtions
                                                        .map((String valYear) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: valYear,
                                                        child: Text(
                                                          valYear,
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        yearSelected = value!;

                                                        var monthSelectedVal =
                                                            data
                                                                .listTargetSales![
                                                                    index]
                                                                .bulan;

                                                        var linkPageYear =
                                                            '$monthSelectedVal/$yearSelected/0';

                                                        Navigator
                                                            .pushReplacementNamed(
                                                          context,
                                                          TargetsalesEntryPage
                                                              .routeName,
                                                          arguments:
                                                              linkPageYear,
                                                        );
                                                      });
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      width: 160,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 14,
                                                        right: 14,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            3,
                                                            116,
                                                            18,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Color.fromARGB(
                                                        255,
                                                        3,
                                                        116,
                                                        18,
                                                      ),
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: Colors.white,
                                                      ),
                                                      offset:
                                                          const Offset(0, 0),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(15),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(
                                                                    true),
                                                      ),
                                                    ),
                                                  ),
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Call  :",
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
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
                                                        controller:
                                                            callController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "Call  tidak boleh kosong.";
                                                          }
                                                          return null;
                                                        },
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
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                17,
                                                                0,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: 'Call ',
                                                          hintStyle:
                                                              textStyleColorGreen,
                                                          labelText: 'Call ',
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
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
                                                                0, 0, 0, 15),
                                                        child: TextFormField(
                                                          controller:
                                                              bulanController,
                                                          autocorrect: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Bulan',
                                                            hintStyle:
                                                                textStyleColorGreen,
                                                            labelText: 'Bulan',
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
                                                                0, 0, 0, 15),
                                                        child: TextFormField(
                                                          controller:
                                                              tahunController,
                                                          autocorrect: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Tahun',
                                                            hintStyle:
                                                                textStyleColorGreen,
                                                            labelText: 'Tahun',
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
                                                                0, 0, 0, 15),
                                                        child: TextFormField(
                                                          controller:
                                                              branchBusinessIDController,
                                                          autocorrect: false,
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
                                                                0, 0, 0, 15),
                                                        child: TextFormField(
                                                          controller:
                                                              salesmanIDController,
                                                          autocorrect: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'SalesmanHeaderID',
                                                            hintStyle:
                                                                textStyleColorGreen,
                                                            labelText:
                                                                'SalesmanHeaderID',
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
                                              BootstrapCol(
                                                sizes: 'col-md-6 col-12',
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          " Prospect :",
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
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
                                                        controller:
                                                            prospectController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return " Prospect tidak boleh kosong.";
                                                          }
                                                          return null;
                                                        },
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
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                17,
                                                                0,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: ' Prospect',
                                                          hintStyle:
                                                              textStyleColorGreen,
                                                          labelText:
                                                              ' Prospect',
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "HOT :",
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
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
                                                        controller:
                                                            hotController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "HOT tidak boleh kosong.";
                                                          }
                                                          return null;
                                                        },
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
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                17,
                                                                0,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: 'HOT',
                                                          hintStyle:
                                                              textStyleColorGreen,
                                                          labelText: 'HOT',
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "SPK :",
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
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
                                                        controller:
                                                            spkController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "SPK tidak boleh kosong.";
                                                          }
                                                          return null;
                                                        },
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
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                17,
                                                                0,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: 'SPK',
                                                          hintStyle:
                                                              textStyleColorGreen,
                                                          labelText: 'SPK',
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "DO :",
                                                          style:
                                                              textStyleColorGreen,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
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
                                                        controller:
                                                            doController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "DO tidak boleh kosong.";
                                                          }
                                                          return null;
                                                        },
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
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                17,
                                                                0,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: 'DO',
                                                          hintStyle:
                                                              textStyleColorGreen,
                                                          labelText: 'DO',
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
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
                                                      const EdgeInsets.fromLTRB(
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
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          fixedSize: Size(
                                                            ResponsiveValue<
                                                                        double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            200,
                                                                        landscapeValue:
                                                                            200,
                                                                      ),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              200,
                                                                          landscapeValue:
                                                                              200,
                                                                          breakpoint:
                                                                              800),
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
                                                                    value: 55,
                                                                    landscapeValue:
                                                                        55),
                                                                const Condition
                                                                    .largerThan(
                                                                    name:
                                                                        TABLET,
                                                                    value: 55,
                                                                    landscapeValue:
                                                                        55,
                                                                    breakpoint:
                                                                        800),
                                                              ],
                                                              defaultValue: 50,
                                                            ).value,
                                                          ),
                                                          elevation: 0,
                                                          side: BorderSide(
                                                            color: data
                                                                        .listTargetSales![
                                                                            index]
                                                                        .iD ==
                                                                    ''
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    3,
                                                                    116,
                                                                    18,
                                                                  )
                                                                : const Color
                                                                    .fromARGB(
                                                                    92,
                                                                    150,
                                                                    150,
                                                                    150,
                                                                  ),
                                                          ),
                                                          backgroundColor: data
                                                                      .listTargetSales![
                                                                          index]
                                                                      .iD ==
                                                                  ''
                                                              ? const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  3,
                                                                  116,
                                                                  18,
                                                                )
                                                              : const Color
                                                                  .fromARGB(
                                                                  92,
                                                                  150,
                                                                  150,
                                                                  150,
                                                                ),
                                                        ).copyWith(
                                                          overlayColor:
                                                              MaterialStateProperty
                                                                  .resolveWith<
                                                                      Color?>(
                                                            (Set<MaterialState>
                                                                states) {
                                                              if (states.contains(
                                                                  MaterialState
                                                                      .pressed)) {
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
                                                        onPressed: () async {
                                                          if (data
                                                                  .listTargetSales![
                                                                      index]
                                                                  .iD ==
                                                              '') {
                                                            if (formkey
                                                                .currentState!
                                                                .validate()) {
                                                              try {
                                                                var targetSales =
                                                                    ListEntryTargetSales(
                                                                  branchBusinessUnitID:
                                                                      branchBusinessIDController
                                                                          .text,
                                                                  salesmanID:
                                                                      salesmanIDController
                                                                          .text,
                                                                  tahun:
                                                                      tahunController
                                                                          .text,
                                                                  bulan: int.tryParse(
                                                                      bulanController
                                                                          .text),
                                                                  call: int.tryParse(
                                                                      callController
                                                                          .text),
                                                                  prospect: int
                                                                      .tryParse(
                                                                          prospectController
                                                                              .text),
                                                                  hot: int.tryParse(
                                                                      hotController
                                                                          .text),
                                                                  spk: int.tryParse(
                                                                      spkController
                                                                          .text),
                                                                  dO: int.tryParse(
                                                                      doController
                                                                          .text),
                                                                );

                                                                var resp = await ref
                                                                    .read(
                                                                        targetSalesFormProvider)
                                                                    .onSubmitTargetSales(
                                                                        targetSales);

                                                                if (resp.statusMessage ==
                                                                    "Sucess") {
                                                                  callController
                                                                      .clear();
                                                                  prospectController
                                                                      .clear();
                                                                  hotController
                                                                      .clear();
                                                                  spkController
                                                                      .clear();
                                                                  doController
                                                                      .clear();
                                                                }

                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const HomePage()),
                                                                    (route) =>
                                                                        false);

                                                                sucessSubmit2(
                                                                    context);
                                                              } catch (e) {
                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const HomePage()),
                                                                    (route) =>
                                                                        false);

                                                                catchError(
                                                                    context, e);
                                                              }
                                                            }
                                                          } else {}
                                                        },
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Simpan",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: data.listTargetSales![index]
                                                                            .iD ==
                                                                        ''
                                                                    ? textStyleColorWhite
                                                                    : const TextStyle(
                                                                        color: Color
                                                                            .fromARGB(
                                                                          148,
                                                                          150,
                                                                          150,
                                                                          150,
                                                                        ),
                                                                      ),
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
                                : const notActivetoken(),
                            error: (err, stack) => Text('Error $err'),
                            loading: () => const Center(
                              child: Text(''),
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
}
