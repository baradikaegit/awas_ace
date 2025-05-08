import 'dart:convert';

import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/alert_notempty.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/referensimodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_bysales_detail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FunnelingSalesPage extends StatefulWidget {
  final Object? linkPageObj;
  const FunnelingSalesPage({super.key, required this.linkPageObj});

  static const String routeName = "/funnelingSalesPage";

  @override
  State<FunnelingSalesPage> createState() => _FunnelingSalesPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _FunnelingSalesPageState extends State<FunnelingSalesPage> {
  Widget titleBar = const Text(
    "Funneling",
    style: TextStyle(color: Colors.white),
  );

  String? userName;
  String? roles;
  String? sid;
  String? branchID;
  String nameRef = '';
  String idRef = '';

  List<String> tipePeriodeOptions = ['MTD', 'YTD'];
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

  List<ListRptFunnelingDetailResponse> listRptFunnelingSSByModelRes = [];

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Name');
      roles = prefs.getString('Roles');
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');
    });
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorGold = TextStyle(
      color: const Color.fromARGB(255, 250, 158, 19),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.0, landscapeValue: 12.0),
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: titleBar,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                255,
                33,
                44,
                81,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              children: [
                const Watermark(),
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    String monthNow = DateFormat('M').format(DateTime.now());
                    String yearNow = DateFormat('yyyy').format(DateTime.now());
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptFunneling =
                        ref.watch(reportFunnelingBySalesList(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptFunneling.when(
                                    data: (dataSelectOpt) {
                                      String tipePeriode = dataSelectOpt
                                              .listRptFunnelingDetail!
                                              .isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? 'MTD'
                                              : dataSelectOpt
                                                  .listRptFunnelingDetail![0]
                                                  .periodTipe
                                          : '';

                                      String monthSelected = dataSelectOpt
                                              .listRptFunnelingDetail!
                                              .isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? DateFormat('M')
                                                  .format(DateTime.now())
                                              : dataSelectOpt
                                                  .listRptFunnelingDetail![0]
                                                  .month
                                                  .toString()
                                          : '';

                                      String yearSelected = dataSelectOpt
                                              .listRptFunnelingDetail!
                                              .isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? DateFormat('yyyy')
                                                  .format(DateTime.now())
                                              : dataSelectOpt
                                                  .listRptFunnelingDetail![0]
                                                  .year
                                                  .toString()
                                          : '';

                                      String refSelected = dataSelectOpt
                                              .listRptFunnelingDetail!
                                              .isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? 'ALL'
                                              : dataSelectOpt
                                                  .listRptFunnelingDetail![0]
                                                  .referensi
                                                  .toString()
                                          : '';

                                      return Column(
                                        children: [
                                          AppBar(
                                            automaticallyImplyLeading: false,
                                            centerTitle: false,
                                            title: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                        0,
                                                        15,
                                                        0,
                                                        0,
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          value: tipePeriode,
                                                          isExpanded: false,
                                                          items:
                                                              tipePeriodeOptions
                                                                  .map(
                                                            (String
                                                                valueTipePeriode) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    valueTipePeriode,
                                                                child: Text(
                                                                  valueTipePeriode,
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                              );
                                                            },
                                                          ).toList(),
                                                          onChanged: (String?
                                                              newValTp) {
                                                            setState(() {
                                                              tipePeriode =
                                                                  newValTp!;
                                                              var monthNow =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .month;
                                                              var yearNow =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .year;
                                                              var refId =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .refId;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .ssCode;

                                                              var linkResultPeriodTipe =
                                                                  '$monthNow/$yearNow/$tipePeriode/$refId/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                context,
                                                                FunnelingSalesPage
                                                                    .routeName,
                                                                arguments:
                                                                    linkResultPeriodTipe,
                                                              );
                                                            });
                                                          },
                                                          dropdownStyleData:
                                                              DropdownStyleData(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                33,
                                                                44,
                                                                81,
                                                              ),
                                                            ),
                                                            maxHeight: 250,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                            scrollbarTheme:
                                                                ScrollbarThemeData(
                                                              radius:
                                                                  const Radius
                                                                      .circular(
                                                                      40),
                                                              thickness:
                                                                  MaterialStateProperty
                                                                      .all(5),
                                                              thumbVisibility:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                          true),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                        0,
                                                        15,
                                                        0,
                                                        0,
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: false,
                                                          items: monthOptions
                                                              .map(
                                                                  (valueMonth) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: valueMonth
                                                                  .id
                                                                  .toString(),
                                                              child: Text(
                                                                valueMonth
                                                                    .value,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          value: monthSelected,
                                                          onChanged: (String?
                                                              newValMonth) {
                                                            setState(() {
                                                              monthSelected =
                                                                  newValMonth!;
                                                              var yearNow =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .year;
                                                              var periodTipe =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .periodTipe;
                                                              var refId =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .refId;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .ssCode;

                                                              var linkResultMonth =
                                                                  '$monthSelected/$yearNow/$periodTipe/$refId/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                context,
                                                                FunnelingSalesPage
                                                                    .routeName,
                                                                arguments:
                                                                    linkResultMonth,
                                                              );
                                                            });
                                                          },
                                                          dropdownStyleData:
                                                              DropdownStyleData(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                33,
                                                                44,
                                                                81,
                                                              ),
                                                            ),
                                                            maxHeight: 250,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                            scrollbarTheme:
                                                                ScrollbarThemeData(
                                                              radius:
                                                                  const Radius
                                                                      .circular(
                                                                      40),
                                                              thickness:
                                                                  MaterialStateProperty
                                                                      .all(5),
                                                              thumbVisibility:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                          true),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                        0,
                                                        15,
                                                        15,
                                                        0,
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          value: yearSelected,
                                                          isExpanded: false,
                                                          items: yearOPtions
                                                              .map((String
                                                                  valueYear) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: valueYear,
                                                              child: Text(
                                                                valueYear,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValYear) {
                                                            setState(() {
                                                              yearSelected =
                                                                  newValYear!;
                                                              var monthNow =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .month;
                                                              var periodTipe =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .periodTipe;
                                                              var refId =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .refId;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptFunnelingDetail![
                                                                          0]
                                                                      .ssCode;

                                                              var linkResultYear =
                                                                  '$monthNow/$yearSelected/$periodTipe/$refId/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                FunnelingSalesPage
                                                                    .routeName,
                                                                arguments:
                                                                    linkResultYear,
                                                              );
                                                            });
                                                          },
                                                          dropdownStyleData:
                                                              const DropdownStyleData(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                33,
                                                                44,
                                                                81,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                              255,
                                              33,
                                              44,
                                              81,
                                            ),
                                          ),
                                          AppBar(
                                            automaticallyImplyLeading: false,
                                            centerTitle: false,
                                            title: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    20,
                                                    10,
                                                    15,
                                                    0,
                                                  ),
                                                  child:
                                                      DropdownSearch<Referensi>(
                                                    popupProps:
                                                        PopupProps.dialog(
                                                      dialogProps:
                                                          const DialogProps(
                                                        shape: Border.symmetric(
                                                            vertical: BorderSide
                                                                .none),
                                                      ),
                                                      showSearchBox: false,
                                                      searchFieldProps:
                                                          TextFieldProps(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Search..",
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                134,
                                                                134,
                                                                134,
                                                              ),
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                134,
                                                                134,
                                                                134,
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
                                                      itemBuilder: (context,
                                                              item,
                                                              isSelected) =>
                                                          ListTile(
                                                        title: Text(
                                                          item.name
                                                              .toUpperCase(),
                                                        ),
                                                      ),
                                                    ),
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        errorStyle:
                                                            const TextStyle(
                                                          color: Color.fromARGB(
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
                                                        hintStyle:
                                                            textStyleColorWhite,
                                                        labelStyle:
                                                            const TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        nameRef = value!.name;
                                                        idRef = value.iD;

                                                        var monthNow = dataSelectOpt
                                                            .listRptFunnelingDetail![
                                                                0]
                                                            .month;
                                                        var yearNow = dataSelectOpt
                                                            .listRptFunnelingDetail![
                                                                0]
                                                            .year;
                                                        var periodTipe =
                                                            dataSelectOpt
                                                                .listRptFunnelingDetail![
                                                                    0]
                                                                .periodTipe;
                                                        var branchCode =
                                                            dataSelectOpt
                                                                .listRptFunnelingDetail![
                                                                    0]
                                                                .title;
                                                        var ssCode = dataSelectOpt
                                                            .listRptFunnelingDetail![
                                                                0]
                                                            .ssCode;

                                                        var linkResultRef =
                                                            '$monthNow/$yearNow/$periodTipe/$idRef/$branchCode/$ssCode';

                                                        Navigator.pushNamed(
                                                          context,
                                                          FunnelingSalesPage
                                                              .routeName,
                                                          arguments:
                                                              linkResultRef,
                                                        );
                                                      });
                                                    },
                                                    dropdownBuilder: (context,
                                                            selectedItem) =>
                                                        Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        refSelected,
                                                        style:
                                                            textStyleColorWhite,
                                                      ),
                                                    ),
                                                    asyncItems:
                                                        (String filter) async {
                                                      var response =
                                                          await http.get(
                                                        Uri.parse(
                                                          "${urlApi()}ReportSales/GetReferensi",
                                                        ),
                                                      );
                                                      if (response.statusCode !=
                                                          200) {
                                                        return [];
                                                      }
                                                      List allRef = (jsonDecode(
                                                                  response.body)
                                                              as Map<String,
                                                                  dynamic>)[
                                                          "listReferensi"];
                                                      List<Referensi>
                                                          allModelRef = [];

                                                      for (var element
                                                          in allRef) {
                                                        allModelRef.add(
                                                          Referensi(
                                                            iD: element["iD"],
                                                            name:
                                                                element["name"],
                                                          ),
                                                        );
                                                      }
                                                      return allModelRef;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                              255,
                                              33,
                                              44,
                                              81,
                                            ),
                                          ),
                                          AppBar(
                                            automaticallyImplyLeading: false,
                                            centerTitle: true,
                                            title: Padding(
                                              padding: roles == 'OD' ||
                                                      roles == 'PD'
                                                  ? const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0)
                                                  : const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Data Corong (${dataSelectOpt.listRptFunnelingDetail![0].title})",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                      fontSize: ResponsiveValue<
                                                          double>(
                                                        context,
                                                        conditionalValues: [
                                                          const Condition
                                                              .equals(
                                                              name: TABLET,
                                                              value: 17.0,
                                                              landscapeValue:
                                                                  17.0),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 17.0,
                                                              landscapeValue:
                                                                  17.0,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 14.5,
                                                      ).value,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    roles == 'OD' ||
                                                            roles == 'PD'
                                                        ? ""
                                                        : dataSelectOpt
                                                            .listRptFunnelingDetail![
                                                                0]
                                                            .userName,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                      fontSize: ResponsiveValue<
                                                          double>(
                                                        context,
                                                        conditionalValues: [
                                                          const Condition
                                                              .equals(
                                                              name: TABLET,
                                                              value: 17.0,
                                                              landscapeValue:
                                                                  17.0),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 17.0,
                                                              landscapeValue:
                                                                  17.0,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 14.5,
                                                      ).value,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          AppBar(
                                            automaticallyImplyLeading: false,
                                            centerTitle: false,
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Periode : ${dataSelectOpt.listRptFunnelingDetail![0].monthID} ${dataSelectOpt.listRptFunnelingDetail![0].year}",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        fontSize:
                                                            ResponsiveValue<
                                                                double>(
                                                          context,
                                                          conditionalValues: [
                                                            const Condition
                                                                .equals(
                                                                name: TABLET,
                                                                value: 12.0,
                                                                landscapeValue:
                                                                    12.0),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11.0,
                                                        ).value,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Tanggal Hari ini : $dateNow",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        fontSize:
                                                            ResponsiveValue<
                                                                double>(
                                                          context,
                                                          conditionalValues: [
                                                            const Condition
                                                                .equals(
                                                                name: TABLET,
                                                                value: 12.0,
                                                                landscapeValue:
                                                                    12.0),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11.0,
                                                        ).value,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ],
                                      );
                                    },
                                    error: (err, stack) => Text('Error $err'),
                                    loading: () =>
                                        const Center(child: Text('')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                        reportFunnelingBySalesList(
                                            linkPageObj.toString()));
                                  },
                                  child: rptFunneling.when(
                                    data: (dataFunneling) {
                                      listRptFunnelingSSByModelRes.clear();
                                      listRptFunnelingSSByModelRes
                                          .add(dataFunneling);

                                      return (dataFunneling.listRptFunnelingDetail !=
                                              null)
                                          ? dataFunneling.listRptFunnelingDetail!
                                                  .isNotEmpty
                                              ? dataFunneling
                                                              .listRptFunnelingDetail![
                                                                  0]
                                                              .call >
                                                          0 ||
                                                      dataFunneling
                                                              .listRptFunnelingDetail![
                                                                  0]
                                                              .prospek >
                                                          0 ||
                                                      dataFunneling
                                                              .listRptFunnelingDetail![
                                                                  0]
                                                              .spk >
                                                          0 ||
                                                      dataFunneling
                                                              .listRptFunnelingDetail![
                                                                  0]
                                                              .dO >
                                                          0
                                                  ? ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                20,
                                                                10,
                                                                20,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 900,
                                                                    child:
                                                                        SfCartesianChart(
                                                                      title: ChartTitle(
                                                                          text:
                                                                              ""),
                                                                      legend:
                                                                          Legend(
                                                                        isVisible:
                                                                            true,
                                                                        textStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                              const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.5,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                      series: <CartesianSeries>[
                                                                        //memanggil isi grafik

                                                                        StackedBarSeries<
                                                                            DataFunneling,
                                                                            String>(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            183,
                                                                            0,
                                                                            89,
                                                                            255,
                                                                          ),
                                                                          name:
                                                                              "CALL",
                                                                          legendIconType:
                                                                              LegendIconType.circle,
                                                                          dataSource:
                                                                              toDynamic(listRptFunnelingSSByModelRes[0].listRptFunnelingDetail!),
                                                                          xValueMapper: (DataFunneling data, _) =>
                                                                              data.x,

                                                                          yValueMapper: (DataFunneling data, _) =>
                                                                              data.y,

                                                                          // untuk menampilkan label pada grafik
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                            isVisible:
                                                                                true,
                                                                            showCumulativeValues:
                                                                                true,
                                                                            // labelAlignment:
                                                                            //     ChartDataLabelAlignment.middle,
                                                                          ),
                                                                        ),

                                                                        StackedBarSeries<
                                                                            DataFunneling,
                                                                            String>(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            155,
                                                                            0,
                                                                            255,
                                                                            170,
                                                                          ),
                                                                          name:
                                                                              "PROSPEK",
                                                                          legendIconType:
                                                                              LegendIconType.circle,
                                                                          dataSource:
                                                                              toDynamic(listRptFunnelingSSByModelRes[0].listRptFunnelingDetail!),
                                                                          pointColorMapper: (DataFunneling data, _) =>
                                                                              data.color2,
                                                                          xValueMapper: (DataFunneling data, _) =>
                                                                              data.x,

                                                                          yValueMapper: (DataFunneling data, _) =>
                                                                              data.y2,

                                                                          // untuk menampilkan label pada grafik
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                            isVisible:
                                                                                true,
                                                                            showCumulativeValues:
                                                                                true,
                                                                            // labelAlignment:
                                                                            //     ChartDataLabelAlignment.middle,
                                                                          ),
                                                                        ),

                                                                        StackedBarSeries<
                                                                            DataFunneling,
                                                                            String>(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            185,
                                                                            255,
                                                                            238,
                                                                            2,
                                                                          ),
                                                                          name:
                                                                              "SPK",
                                                                          legendIconType:
                                                                              LegendIconType.circle,
                                                                          dataSource:
                                                                              toDynamic(listRptFunnelingSSByModelRes[0].listRptFunnelingDetail!),
                                                                          pointColorMapper: (DataFunneling data, _) =>
                                                                              data.color3,
                                                                          xValueMapper: (DataFunneling data, _) =>
                                                                              data.x,

                                                                          yValueMapper: (DataFunneling data, _) =>
                                                                              data.y3,

                                                                          // untuk menampilkan label pada grafik
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                            isVisible:
                                                                                true,
                                                                            showCumulativeValues:
                                                                                true,
                                                                            // labelAlignment:
                                                                            //     ChartDataLabelAlignment.middle,
                                                                          ),
                                                                        ),

                                                                        StackedBarSeries<
                                                                            DataFunneling,
                                                                            String>(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            192,
                                                                            255,
                                                                            81,
                                                                            0,
                                                                          ),
                                                                          name:
                                                                              "DO",
                                                                          legendIconType:
                                                                              LegendIconType.circle,
                                                                          dataSource:
                                                                              toDynamic(listRptFunnelingSSByModelRes[0].listRptFunnelingDetail!),
                                                                          pointColorMapper: (DataFunneling data, _) =>
                                                                              data.color4,
                                                                          xValueMapper: (DataFunneling data, _) =>
                                                                              data.x,

                                                                          yValueMapper: (DataFunneling data, _) =>
                                                                              data.y4,

                                                                          // untuk menampilkan label pada grafik
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                            isVisible:
                                                                                true,
                                                                            showCumulativeValues:
                                                                                true,
                                                                            // labelAlignment:
                                                                            //     ChartDataLabelAlignment.middle,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      primaryXAxis:
                                                                          CategoryAxis(
                                                                        labelStyle:
                                                                            textStyleColorWhite,
                                                                      ),
                                                                      primaryYAxis:
                                                                          NumericAxis(
                                                                        labelStyle:
                                                                            textStyleColorWhite,
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
                                                                10,
                                                                20,
                                                                10,
                                                                20,
                                                              ),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight:
                                                                      600,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                child:
                                                                    DataTable(
                                                                  border:
                                                                      const TableBorder(
                                                                    horizontalInside:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        27,
                                                                        37,
                                                                        68,
                                                                      ),
                                                                      width:
                                                                          2.5,
                                                                    ),
                                                                  ),
                                                                  columnSpacing:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              20.0,
                                                                          landscapeValue:
                                                                              20.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              0.0,
                                                                          landscapeValue:
                                                                              0.0)
                                                                    ],
                                                                    defaultValue:
                                                                        10,
                                                                  ).value,
                                                                  horizontalMargin: ResponsiveValue<
                                                                              double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 5.0,
                                                                                landscapeValue: 5.0),
                                                                            const Condition.largerThan(
                                                                                name: TABLET,
                                                                                value: 5.0,
                                                                                landscapeValue: 5.0,
                                                                                breakpoint: 800)
                                                                          ],
                                                                          defaultValue:
                                                                              12.0)
                                                                      .value,
                                                                  headingRowHeight:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              35.0,
                                                                          landscapeValue:
                                                                              35.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              50.0,
                                                                          landscapeValue:
                                                                              50.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        30.0,
                                                                  ).value,
                                                                  columns: [
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              120,
                                                                          child:
                                                                              Text(
                                                                            "Sales",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              Text(
                                                                            "CALL",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              Text(
                                                                            "PROSPEK",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              Text(
                                                                            "HOT",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              Text(
                                                                            "SPK",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              Text(
                                                                            "DO",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: List<
                                                                      DataRow>.generate(
                                                                    dataFunneling
                                                                        .listRptFunnelingDetail!
                                                                        .length,
                                                                    (indexObj) {
                                                                      final dataRptFunneling =
                                                                          dataFunneling
                                                                              .listRptFunnelingDetail![indexObj];

                                                                      var persenProspek = dataFunneling.listRptFunnelingDetail![indexObj].call >
                                                                              0
                                                                          ? (dataFunneling.listRptFunnelingDetail![indexObj].prospek /
                                                                              dataFunneling.listRptFunnelingDetail![indexObj].call *
                                                                              100)
                                                                          : 0;

                                                                      var persenHot = dataFunneling.listRptFunnelingDetail![indexObj].prospek >
                                                                              0
                                                                          ? (dataFunneling.listRptFunnelingDetail![indexObj].hot /
                                                                              dataFunneling.listRptFunnelingDetail![indexObj].prospek *
                                                                              100)
                                                                          : 0;

                                                                      var persenSpk = dataFunneling.listRptFunnelingDetail![indexObj].hot >
                                                                              0
                                                                          ? (dataFunneling.listRptFunnelingDetail![indexObj].spk /
                                                                              dataFunneling.listRptFunnelingDetail![indexObj].hot *
                                                                              100)
                                                                          : 0;

                                                                      var persenDO = dataFunneling.listRptFunnelingDetail![indexObj].spk >
                                                                              0
                                                                          ? (dataFunneling.listRptFunnelingDetail![indexObj].dO /
                                                                              dataFunneling.listRptFunnelingDetail![indexObj].spk *
                                                                              100)
                                                                          : 0;

                                                                      var textStyleDataTable =
                                                                          TextStyle(
                                                                        color: dataFunneling.listRptFunnelingDetail![indexObj].headerName ==
                                                                                'TOTAL'
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255,
                                                                              )
                                                                            : Colors.blue,
                                                                        fontSize:
                                                                            ResponsiveValue<double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 12.0,
                                                                                landscapeValue: 12.0),
                                                                            const Condition.largerThan(
                                                                                name: TABLET,
                                                                                value: 14.0,
                                                                                landscapeValue: 14.0,
                                                                                breakpoint: 800),
                                                                          ],
                                                                          defaultValue:
                                                                              11.0,
                                                                        ).value,
                                                                      );

                                                                      return DataRow(
                                                                        color: MaterialStateColor
                                                                            .resolveWith(
                                                                          (states) => indexObj.isEven
                                                                              ? const Color.fromARGB(
                                                                                  213,
                                                                                  27,
                                                                                  37,
                                                                                  68,
                                                                                )
                                                                              : Colors.transparent,
                                                                        ),
                                                                        cells: <DataCell>[
                                                                          DataCell(
                                                                            InkWell(
                                                                              onTap: dataFunneling.listRptFunnelingDetail![indexObj].headerName == 'TOTAL'
                                                                                  ? () {}
                                                                                  : () {
                                                                                      var month = dataFunneling.listRptFunnelingDetail![indexObj].month.toString();
                                                                                      var year = dataFunneling.listRptFunnelingDetail![indexObj].year.toString();
                                                                                      var periodTipe = dataFunneling.listRptFunnelingDetail![indexObj].periodTipe;
                                                                                      var refId = dataFunneling.listRptFunnelingDetail![indexObj].refId;
                                                                                      var branchCode = dataFunneling.listRptFunnelingDetail![indexObj].title;
                                                                                      var ssCode = dataFunneling.listRptFunnelingDetail![indexObj].ssCode;
                                                                                      var salesCode = dataFunneling.listRptFunnelingDetail![indexObj].headerCode;

                                                                                      Navigator.pushNamed(
                                                                                        context,
                                                                                        FunnelingSalesDetailPage.routeName,
                                                                                        arguments: '$month/$year/$periodTipe/$refId/$branchCode/$ssCode/$salesCode',
                                                                                      );
                                                                                    },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  left: 10,
                                                                                ),
                                                                                child: Text(
                                                                                  dataRptFunneling.headerName,
                                                                                  style: textStyleDataTable,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Text(
                                                                              dataRptFunneling.call.toString(),
                                                                              style: textStyleColorWhite,
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            RichText(
                                                                              textAlign: TextAlign.right,
                                                                              text: TextSpan(
                                                                                text: dataRptFunneling.prospek.toString(),
                                                                                style: textStyleColorWhite,
                                                                                children: <TextSpan>[
                                                                                  TextSpan(text: ' (${persenProspek.floor()}%)', style: textStyleColorGold),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            RichText(
                                                                              textAlign: TextAlign.right,
                                                                              text: TextSpan(
                                                                                text: dataRptFunneling.hot.toString(),
                                                                                style: textStyleColorWhite,
                                                                                children: <TextSpan>[
                                                                                  TextSpan(text: ' (${persenHot.floor()}%)', style: textStyleColorGold),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            RichText(
                                                                              textAlign: TextAlign.right,
                                                                              text: TextSpan(
                                                                                text: dataRptFunneling.spk.toString(),
                                                                                style: textStyleColorWhite,
                                                                                children: <TextSpan>[
                                                                                  TextSpan(text: ' (${persenSpk.floor()}%)', style: textStyleColorGold),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            RichText(
                                                                              textAlign: TextAlign.right,
                                                                              text: TextSpan(
                                                                                text: dataRptFunneling.dO.toString(),
                                                                                style: textStyleColorWhite,
                                                                                children: <TextSpan>[
                                                                                  TextSpan(text: ' (${persenDO.floor()}%)', style: textStyleColorGold),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : const AlertNotempty()
                                              : const MyAlertDialog()
                                          : const notActivetoken();
                                    },
                                    error: (err, stack) => Text('Error $err'),
                                    loading: () => const Center(
                                      child: Column(
                                        children: [loadingAnimation()],
                                      ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DataFunneling {
  String x;
  double y;
  double y2;
  double y3;
  double y4;
  Color color;
  Color color2;
  Color color3;
  Color color4;

  DataFunneling(
    this.x,
    this.y,
    this.y2,
    this.y3,
    this.y4,
    this.color,
    this.color2,
    this.color3,
    this.color4,
  );
}

dynamic toDynamic(List<ListRptFunnelingDetail> objList) {
  List<DataFunneling> barData = [];

  for (var i = 1; i < objList.length + 1; i++) {
    if (objList[objList.length - i].headerName != 'TOTAL') {
      barData.add(DataFunneling(
        objList[objList.length - i].headerName,
        objList[objList.length - i].call.toDouble(),
        objList[objList.length - i].prospek.toDouble(),
        objList[objList.length - i].spk.toDouble(),
        objList[objList.length - i].dO.toDouble(),
        const Color.fromARGB(183, 0, 89, 255),
        const Color.fromARGB(155, 0, 255, 170),
        const Color.fromARGB(185, 255, 238, 2),
        const Color.fromARGB(192, 255, 81, 0),
      ));
    }
  }
  return barData;
}
