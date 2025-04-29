import 'package:awas_ace/provider/reportaftersales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportafterslsfunnelingmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FunnelingByActualAfterSalesPage extends StatefulWidget {
  final Object? linkPageObj;
  const FunnelingByActualAfterSalesPage({super.key, required this.linkPageObj});

  static const String routeName = "/funnelingByActualAfterSalesPage";
  @override
  State<FunnelingByActualAfterSalesPage> createState() =>
      _FunnelingByActualAfterSalesPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _FunnelingByActualAfterSalesPageState
    extends State<FunnelingByActualAfterSalesPage> {
  Widget titleBar = const Text(
    "Funneling",
    style: TextStyle(color: Colors.white),
  );

  String? userName;
  String? roles;
  String? sid;
  String? branchID;

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

  List<ListRptAfterSlsFunnelingResponse> listRptFunnelingModelRes = [];

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

    var textStyleColorConnected = TextStyle(
      color: const Color.fromARGB(
        155,
        0,
        255,
        170,
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

    var textStyleColorContacted = TextStyle(
      color: const Color.fromARGB(
        185,
        255,
        238,
        2,
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

    var textStyleColorCai = TextStyle(
      color: const Color.fromARGB(
        192,
        255,
        81,
        0,
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
              color: Color.fromARGB(255, 33, 44, 81),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    String monthNow = DateFormat('M').format(DateTime.now());
                    String yearNow = DateFormat('yyyy').format(DateTime.now());
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptFunneling =
                        ref.watch(reportFunnelingByActual(linkPageObj));

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
                                      if (dataSelectOpt
                                              .listRptAfterSalesFunneling !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptAfterSalesFunneling!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptAfterSalesFunneling![
                                                        0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptAfterSalesFunneling!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptAfterSalesFunneling![
                                                        0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptAfterSalesFunneling!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptAfterSalesFunneling![
                                                        0]
                                                    .year
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
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 15, 0, 0),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value: tipePeriode,
                                                            isExpanded: false,
                                                            items: tipePeriodeOptions
                                                                .map((String
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
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValTp) {
                                                              setState(
                                                                () {
                                                                  tipePeriode =
                                                                      newValTp!;
                                                                  var monthNow =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesFunneling![
                                                                              0]
                                                                          .month;
                                                                  var yearNow =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesFunneling![
                                                                              0]
                                                                          .year;
                                                                  var branchCode =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesFunneling![
                                                                              0]
                                                                          .headerCode;
                                                                  var actual =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesFunneling![
                                                                              0]
                                                                          .tipe;
                                                                  var linkResultPeriodTipe =
                                                                      '$monthNow/$yearNow/$tipePeriode/$branchCode/$actual';

                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                    context,
                                                                    FunnelingByActualAfterSalesPage
                                                                        .routeName,
                                                                    arguments:
                                                                        linkResultPeriodTipe,
                                                                  );
                                                                },
                                                              );
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
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          0,
                                                          15,
                                                          0,
                                                          0,
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
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
                                                            value:
                                                                monthSelected,
                                                            onChanged: (String?
                                                                newValMonth) {
                                                              setState(() {
                                                                monthSelected =
                                                                    newValMonth!;
                                                                var yearNow =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .periodTipe;
                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .headerCode;
                                                                var actual =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .tipe;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe/$branchCode/$actual';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  FunnelingByActualAfterSalesPage
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
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          0,
                                                          15,
                                                          15,
                                                          0,
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value: yearSelected,
                                                            isExpanded: false,
                                                            items: yearOPtions
                                                                .map((String
                                                                    valueYear) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    valueYear,
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
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .periodTipe;
                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .headerCode;
                                                                var actual =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesFunneling![
                                                                            0]
                                                                        .tipe;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe/$branchCode/$actual';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  FunnelingByActualAfterSalesPage
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
                                              centerTitle: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                  0,
                                                  10,
                                                  0,
                                                  0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Cabang ${dataSelectOpt.listRptAfterSalesFunneling![1].headerCode}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 14.5,
                                                        ).value,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      dataSelectOpt
                                                          .listRptAfterSalesFunneling![
                                                              0]
                                                          .tipe,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0,
                                                                breakpoint:
                                                                    800),
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
                                                        "Periode : ${dataSelectOpt.listRptAfterSalesFunneling![0].monthID} ${dataSelectOpt.listRptAfterSalesFunneling![0].year}",
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
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                255,
                                                33,
                                                44,
                                                81,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return null;
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
                                    return ref.refresh(reportFunnelingByActual(
                                        linkPageObj.toString()));
                                  },
                                  child: rptFunneling.when(
                                    data: (dataFunnelingList) {
                                      listRptFunnelingModelRes.clear();
                                      listRptFunnelingModelRes
                                          .add(dataFunnelingList);

                                      var gConnected = dataFunnelingList
                                          .listRptAfterSalesFunneling![0]
                                          .perConnected;
                                      var gContacted = dataFunnelingList
                                          .listRptAfterSalesFunneling![0]
                                          .perContacted;
                                      var gCai = dataFunnelingList
                                          .listRptAfterSalesFunneling![0]
                                          .perCai;

                                      return (dataFunnelingList
                                                  .listRptAfterSalesFunneling !=
                                              null)
                                          ? dataFunnelingList
                                                  .listRptAfterSalesFunneling!
                                                  .isNotEmpty
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
                                                            5,
                                                            20,
                                                            5,
                                                            20,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: 150,
                                                                    child:
                                                                        SfRadialGauge(
                                                                      enableLoadingAnimation:
                                                                          true,
                                                                      animationDuration:
                                                                          4500,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                          startAngle:
                                                                              120.0,
                                                                          endAngle:
                                                                              330.0,
                                                                          axisLineStyle:
                                                                              const AxisLineStyle(
                                                                            thicknessUnit:
                                                                                GaugeSizeUnit.factor,
                                                                            thickness:
                                                                                0.08,
                                                                          ),
                                                                          majorTickStyle:
                                                                              const MajorTickStyle(
                                                                            length:
                                                                                8,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          minorTickStyle:
                                                                              const MinorTickStyle(
                                                                            length:
                                                                                4,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          axisLabelStyle:
                                                                              const GaugeTextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          labelsPosition:
                                                                              ElementsPosition.inside,
                                                                          useRangeColorForAxis:
                                                                              true,
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              100,
                                                                          interval:
                                                                              25.0,
                                                                          labelOffset:
                                                                              15,
                                                                          showLastLabel:
                                                                              true,
                                                                          ranges: <GaugeRange>[
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 0,
                                                                              endValue: 20,
                                                                              color: const Color.fromARGB(255, 0, 211, 165),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 20,
                                                                              endValue: 40,
                                                                              color: const Color.fromARGB(255, 0, 148, 116),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 40,
                                                                              endValue: 60,
                                                                              color: const Color.fromARGB(255, 245, 206, 101),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 60,
                                                                              endValue: 80,
                                                                              color: const Color.fromARGB(255, 247, 182, 3),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 80,
                                                                              endValue: 100,
                                                                              color: const Color.fromARGB(255, 250, 84, 7),
                                                                            ),
                                                                          ],
                                                                          pointers: <GaugePointer>[
                                                                            NeedlePointer(
                                                                              value: gConnected.toDouble(),
                                                                              needleLength: 0.95,
                                                                              enableAnimation: true,
                                                                              // animationType: AnimationType.ease,
                                                                              needleStartWidth: 0.3,
                                                                              needleEndWidth: 6,
                                                                              needleColor: gConnected < 20
                                                                                  ? const Color.fromARGB(255, 0, 211, 165)
                                                                                  : gConnected < 40
                                                                                      ? const Color.fromARGB(255, 0, 148, 116)
                                                                                      : gConnected < 60
                                                                                          ? const Color.fromARGB(255, 245, 206, 101)
                                                                                          : gConnected < 60
                                                                                              ? const Color.fromARGB(255, 247, 182, 3)
                                                                                              : const Color.fromARGB(255, 250, 84, 7),
                                                                              knobStyle: KnobStyle(
                                                                                knobRadius: 0.1,
                                                                                color: gConnected < 20
                                                                                    ? const Color.fromARGB(255, 0, 211, 165)
                                                                                    : gConnected < 40
                                                                                        ? const Color.fromARGB(255, 0, 148, 116)
                                                                                        : gConnected < 60
                                                                                            ? const Color.fromARGB(255, 245, 206, 101)
                                                                                            : gConnected < 60
                                                                                                ? const Color.fromARGB(255, 247, 182, 3)
                                                                                                : const Color.fromARGB(255, 250, 84, 7),
                                                                              ),
                                                                            )
                                                                          ],
                                                                          annotations: <GaugeAnnotation>[
                                                                            GaugeAnnotation(
                                                                              widget: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                      text: 'Connected \n',
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      children: [
                                                                                        const WidgetSpan(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: '${gConnected.toString()}%',
                                                                                          style: const TextStyle(
                                                                                            color: Color.fromARGB(155, 0, 255, 170),
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              positionFactor: 0.4,
                                                                              angle: 90,
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: 170,
                                                                    child:
                                                                        SfRadialGauge(
                                                                      enableLoadingAnimation:
                                                                          true,
                                                                      animationDuration:
                                                                          4500,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                          axisLineStyle:
                                                                              const AxisLineStyle(
                                                                            thicknessUnit:
                                                                                GaugeSizeUnit.factor,
                                                                            thickness:
                                                                                0.08,
                                                                          ),
                                                                          majorTickStyle:
                                                                              const MajorTickStyle(
                                                                            length:
                                                                                8,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          minorTickStyle:
                                                                              const MinorTickStyle(
                                                                            length:
                                                                                4,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          axisLabelStyle:
                                                                              const GaugeTextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          labelsPosition:
                                                                              ElementsPosition.inside,
                                                                          useRangeColorForAxis:
                                                                              true,
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              100,
                                                                          interval:
                                                                              25.0,
                                                                          labelOffset:
                                                                              15,
                                                                          showLastLabel:
                                                                              true,
                                                                          ranges: <GaugeRange>[
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 0,
                                                                              endValue: 20,
                                                                              color: const Color.fromARGB(255, 0, 211, 165),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 20,
                                                                              endValue: 40,
                                                                              color: const Color.fromARGB(255, 0, 148, 116),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 40,
                                                                              endValue: 60,
                                                                              color: const Color.fromARGB(255, 245, 204, 101),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 60,
                                                                              endValue: 80,
                                                                              color: const Color.fromARGB(255, 247, 182, 3),
                                                                            ),
                                                                            GaugeRange(
                                                                                startWidth: 4,
                                                                                endWidth: 4,
                                                                                startValue: 80,
                                                                                endValue: 100,
                                                                                color: const Color.fromARGB(255, 250, 84, 7)),
                                                                          ],
                                                                          pointers: <GaugePointer>[
                                                                            NeedlePointer(
                                                                              value: gContacted.toDouble(),
                                                                              needleLength: 0.95,
                                                                              enableAnimation: true,
                                                                              // animationType: AnimationType.ease,
                                                                              needleStartWidth: 0.3,
                                                                              needleEndWidth: 6,
                                                                              needleColor: gContacted < 20
                                                                                  ? const Color.fromARGB(255, 0, 211, 165)
                                                                                  : gContacted < 40
                                                                                      ? const Color.fromARGB(255, 0, 148, 116)
                                                                                      : gContacted < 60
                                                                                          ? const Color.fromARGB(255, 245, 206, 101)
                                                                                          : gContacted < 60
                                                                                              ? const Color.fromARGB(255, 247, 182, 3)
                                                                                              : const Color.fromARGB(255, 250, 84, 7),
                                                                              knobStyle: KnobStyle(
                                                                                knobRadius: 0.1,
                                                                                color: gContacted < 20
                                                                                    ? const Color.fromARGB(255, 0, 211, 165)
                                                                                    : gContacted < 40
                                                                                        ? const Color.fromARGB(255, 0, 148, 116)
                                                                                        : gContacted < 60
                                                                                            ? const Color.fromARGB(255, 245, 206, 101)
                                                                                            : gContacted < 60
                                                                                                ? const Color.fromARGB(255, 247, 182, 3)
                                                                                                : const Color.fromARGB(255, 250, 84, 7),
                                                                              ),
                                                                            )
                                                                          ],
                                                                          annotations: <GaugeAnnotation>[
                                                                            GaugeAnnotation(
                                                                              widget: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                      text: 'Contacted \n',
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      children: [
                                                                                        const WidgetSpan(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: '${gContacted.toString()}%',
                                                                                          style: const TextStyle(
                                                                                            color: Color.fromARGB(
                                                                                              185,
                                                                                              255,
                                                                                              238,
                                                                                              2,
                                                                                            ),
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              positionFactor: 0.4,
                                                                              angle: 90,
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: 150,
                                                                    child:
                                                                        SfRadialGauge(
                                                                      enableLoadingAnimation:
                                                                          true,
                                                                      animationDuration:
                                                                          4500,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                          startAngle:
                                                                              210.0,
                                                                          endAngle:
                                                                              60.0,
                                                                          axisLineStyle:
                                                                              const AxisLineStyle(
                                                                            thicknessUnit:
                                                                                GaugeSizeUnit.factor,
                                                                            thickness:
                                                                                0.08,
                                                                          ),
                                                                          majorTickStyle:
                                                                              const MajorTickStyle(
                                                                            length:
                                                                                8,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          minorTickStyle:
                                                                              const MinorTickStyle(
                                                                            length:
                                                                                4,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          axisLabelStyle:
                                                                              const GaugeTextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          labelsPosition:
                                                                              ElementsPosition.inside,
                                                                          useRangeColorForAxis:
                                                                              true,
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              100,
                                                                          interval:
                                                                              25.0,
                                                                          labelOffset:
                                                                              15,
                                                                          showLastLabel:
                                                                              true,
                                                                          ranges: <GaugeRange>[
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 0,
                                                                              endValue: 20,
                                                                              color: const Color.fromARGB(255, 0, 211, 165),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 20,
                                                                              endValue: 40,
                                                                              color: const Color.fromARGB(255, 0, 148, 116),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 40,
                                                                              endValue: 60,
                                                                              color: const Color.fromARGB(255, 245, 204, 101),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 60,
                                                                              endValue: 80,
                                                                              color: const Color.fromARGB(255, 247, 182, 3),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 80,
                                                                              endValue: 100,
                                                                              color: const Color.fromARGB(255, 250, 84, 7),
                                                                            ),
                                                                          ],
                                                                          pointers: <GaugePointer>[
                                                                            NeedlePointer(
                                                                              value: gCai.toDouble(),
                                                                              needleLength: 0.95,
                                                                              enableAnimation: true,
                                                                              // animationType: AnimationType.ease,
                                                                              needleStartWidth: 0.3,
                                                                              needleEndWidth: 6,
                                                                              needleColor: gCai < 20
                                                                                  ? const Color.fromARGB(255, 0, 211, 165)
                                                                                  : gCai < 40
                                                                                      ? const Color.fromARGB(255, 0, 148, 116)
                                                                                      : gCai < 60
                                                                                          ? const Color.fromARGB(255, 245, 206, 101)
                                                                                          : gCai < 60
                                                                                              ? const Color.fromARGB(255, 247, 182, 3)
                                                                                              : const Color.fromARGB(255, 250, 84, 7),
                                                                              knobStyle: KnobStyle(
                                                                                knobRadius: 0.1,
                                                                                color: gCai < 20
                                                                                    ? const Color.fromARGB(255, 0, 211, 165)
                                                                                    : gCai < 40
                                                                                        ? const Color.fromARGB(255, 0, 148, 116)
                                                                                        : gCai < 60
                                                                                            ? const Color.fromARGB(255, 245, 206, 101)
                                                                                            : gCai < 60
                                                                                                ? const Color.fromARGB(255, 247, 182, 3)
                                                                                                : const Color.fromARGB(255, 250, 84, 7),
                                                                              ),
                                                                            )
                                                                          ],
                                                                          annotations: <GaugeAnnotation>[
                                                                            GaugeAnnotation(
                                                                              widget: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                      text: 'CAI \n',
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      children: [
                                                                                        const WidgetSpan(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: '${gCai.toString()}%',
                                                                                          style: const TextStyle(
                                                                                            color: Color.fromARGB(255, 0, 211, 165),
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              positionFactor: 0.4,
                                                                              angle: 90,
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
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
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 550,
                                                                child:
                                                                    SfCartesianChart(
                                                                  title:
                                                                      const ChartTitle(
                                                                    text: "",
                                                                  ),
                                                                  legend:
                                                                      Legend(
                                                                    isVisible:
                                                                        true,
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          ResponsiveValue<
                                                                              double>(
                                                                        context,
                                                                        conditionalValues: [
                                                                          const Condition
                                                                              .equals(
                                                                              name: TABLET,
                                                                              value: 12.0,
                                                                              landscapeValue: 12.0),
                                                                          const Condition
                                                                              .largerThan(
                                                                              name: TABLET,
                                                                              value: 14.0,
                                                                              landscapeValue: 14.0,
                                                                              breakpoint: 800),
                                                                        ],
                                                                        defaultValue:
                                                                            12.5,
                                                                      ).value,
                                                                    ),
                                                                  ),
                                                                  series: <CartesianSeries>[
                                                                    //memanggil isi grafik

                                                                    StackedBarSeries<
                                                                        DataFunnelingColumn,
                                                                        String>(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        183,
                                                                        0,
                                                                        89,
                                                                        255,
                                                                      ),
                                                                      name:
                                                                          "Data",
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .circle,
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptFunnelingModelRes[0].listRptAfterSalesFunneling!),
                                                                      xValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.x,

                                                                      yValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
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
                                                                        DataFunnelingColumn,
                                                                        String>(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        155,
                                                                        0,
                                                                        255,
                                                                        170,
                                                                      ),
                                                                      name:
                                                                          "Connected",
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .circle,
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptFunnelingModelRes[0].listRptAfterSalesFunneling!),
                                                                      pointColorMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.color2,
                                                                      xValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.x,

                                                                      yValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
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
                                                                        DataFunnelingColumn,
                                                                        String>(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        185,
                                                                        255,
                                                                        238,
                                                                        2,
                                                                      ),
                                                                      name:
                                                                          "Contacted",
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .circle,
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptFunnelingModelRes[0].listRptAfterSalesFunneling!),
                                                                      pointColorMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.color3,
                                                                      xValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.x,

                                                                      yValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
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
                                                                        DataFunnelingColumn,
                                                                        String>(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        192,
                                                                        255,
                                                                        81,
                                                                        0,
                                                                      ),
                                                                      name:
                                                                          "Cai",
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .circle,
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptFunnelingModelRes[0].listRptAfterSalesFunneling!),
                                                                      pointColorMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.color4,
                                                                      xValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
                                                                              data.x,

                                                                      yValueMapper:
                                                                          (DataFunnelingColumn data, _) =>
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
                                                              minHeight: 600,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            child: DataTable(
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
                                                                  width: 2.5,
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
                                                                        const Condition
                                                                            .equals(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                5.0,
                                                                            landscapeValue:
                                                                                5.0),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                5.0,
                                                                            landscapeValue:
                                                                                5.0,
                                                                            breakpoint:
                                                                                800)
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
                                                                  const Condition.largerThan(
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "ACTUAL",
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
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 60,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "DATA",
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CONNECTED",
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CONTACTED",
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CAI",
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
                                                                dataFunnelingList
                                                                    .listRptAfterSalesFunneling!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptFunneling =
                                                                      dataFunnelingList
                                                                              .listRptAfterSalesFunneling![
                                                                          indexObj];

                                                                  var textStyleDataTable =
                                                                      TextStyle(
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
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                12.0,
                                                                            landscapeValue:
                                                                                12.0),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                14.0,
                                                                            landscapeValue:
                                                                                14.0,
                                                                            breakpoint:
                                                                                800),
                                                                      ],
                                                                      defaultValue:
                                                                          11.0,
                                                                    ).value,
                                                                  );

                                                                  return DataRow(
                                                                    color: MaterialStateColor
                                                                        .resolveWith(
                                                                      (states) => indexObj
                                                                              .isEven
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              213,
                                                                              27,
                                                                              37,
                                                                              68,
                                                                            )
                                                                          : Colors
                                                                              .transparent,
                                                                    ),
                                                                    cells: <DataCell>[
                                                                      DataCell(
                                                                        InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              dataRptFunneling.headerName,
                                                                              style: textStyleDataTable,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptFunneling.data1.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptFunneling.connected.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptFunneling.perConnected}%)', style: textStyleColorConnected),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptFunneling.contacted.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptFunneling.perContacted}%)', style: textStyleColorContacted),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptFunneling.cai.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptFunneling.perCai}%)', style: textStyleColorCai),
                                                                              ],
                                                                            ),
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
                          ),
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
      ],
    );
  }
}

class DataFunnelingColumn {
  String x;
  int y;
  int y2;
  int y3;
  int y4;
  Color color;
  Color color2;
  Color color3;
  Color color4;

  DataFunnelingColumn(
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

dynamic toDynamic(List<ListRptAfterSalesFunneling> objList) {
  List<DataFunnelingColumn> barData = [];

  for (var i = 1; i < objList.length + 1; i++) {
    if (objList[objList.length - i].headerName != 'TOTAL') {
      barData.add(DataFunnelingColumn(
        objList[objList.length - i].headerName,
        objList[objList.length - i].data1,
        objList[objList.length - i].connected,
        objList[objList.length - i].contacted,
        objList[objList.length - i].cai,
        const Color.fromARGB(183, 0, 89, 255),
        const Color.fromARGB(155, 0, 255, 170),
        const Color.fromARGB(185, 255, 238, 2),
        const Color.fromARGB(192, 255, 81, 0),
      ));
    }
  }
  return barData;
}
