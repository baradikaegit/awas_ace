import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportslstargetslsactmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TargetSalesActualBySalesPage extends StatefulWidget {
  final Object? linkPageObj;
  const TargetSalesActualBySalesPage({super.key, required this.linkPageObj});

  static const String routeName = "/targetSalesActualBySalesPage";
  @override
  State<TargetSalesActualBySalesPage> createState() =>
      _TargetSalesActualBySalesPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _TargetSalesActualBySalesPageState
    extends State<TargetSalesActualBySalesPage> with TickerProviderStateMixin {
  Widget titleBar = const Text(
    "Target Sales Actual vs Actual",
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

  List<ListRptTSalesActualResponse> listRptTSalesActualByModelRes = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5, initialIndex: 4);
    _tabController.addListener(_handleTabSelection);

    loadSharedPreference();
  }

  void _handleTabSelection() {
    setState(() {});
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

  Padding get _tabBar => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          height: 35,
          color: const Color.fromARGB(
            255,
            13,
            23,
            58,
          ),
          child: TabBar(
            controller: _tabController,
            indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // indicatorWeight: 10.0,
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.white,
            labelColor: const Color.fromARGB(
              255,
              33,
              44,
              81,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.amber,
            indicator: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2.0,
                  color: Color.fromARGB(
                    255,
                    33,
                    44,
                    81,
                  ),
                ),
                left: BorderSide(
                  width: 2.0,
                  color: Color.fromARGB(
                    255,
                    33,
                    44,
                    81,
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
              color: Colors.blue,
            ),
            tabs: [
              Tab(
                child: Text(
                  "Call",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 12.0, landscapeValue: 12.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Prospect",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 12.0, landscapeValue: 12.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "HOT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 12.0, landscapeValue: 12.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "SPK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 12.0, landscapeValue: 12.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "DO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 12.0, landscapeValue: 12.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
                const Watermark(),
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    String monthNow = DateFormat('M').format(DateTime.now());
                    String yearNow = DateFormat('yyyy').format(DateTime.now());
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptTSalesActual =
                        ref.watch(reportTargetSalesActualBySales(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptTSalesActual.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt.listRptTSalesActual !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptTSalesActual!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptTSalesActual![0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptTSalesActual!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptTSalesActual![0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptTSalesActual!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptTSalesActual![0]
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
                                                              setState(() {
                                                                tipePeriode =
                                                                    newValTp!;
                                                                var monthNow =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .month;
                                                                var yearNow =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .year;

                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .title;

                                                                var ssCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .headerCode2;

                                                                var linkResultPeriodTipe =
                                                                    '$monthNow/$yearNow/$tipePeriode/$branchCode/$ssCode';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  TargetSalesActualBySalesPage
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
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .periodTipe;

                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .title;

                                                                var ssCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .headerCode2;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe/$branchCode/$ssCode';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  TargetSalesActualBySalesPage
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
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .periodTipe;

                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .title;

                                                                var ssCode =
                                                                    dataSelectOpt
                                                                        .listRptTSalesActual![
                                                                            0]
                                                                        .headerCode2;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe/$branchCode/$ssCode';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  TargetSalesActualBySalesPage
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
                                                        0, 10, 0, 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Cabang ALL",
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
                                                        "Periode : ${dataSelectOpt.listRptTSalesActual![0].monthID} ${dataSelectOpt.listRptTSalesActual![0].year}",
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
                                    return ref.refresh(
                                        reportTargetSalesActualBySales(
                                            linkPageObj.toString()));
                                  },
                                  child: rptTSalesActual.when(
                                    data: (dataTSalesActual) {
                                      listRptTSalesActualByModelRes.clear();
                                      listRptTSalesActualByModelRes
                                          .add(dataTSalesActual);

                                      return (dataTSalesActual
                                                  .listRptTSalesActual !=
                                              null)
                                          ? dataTSalesActual
                                                  .listRptTSalesActual!
                                                  .isNotEmpty
                                              ? SingleChildScrollView(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 1350,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                0,
                                                                10,
                                                                0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 215,
                                                                    width: 220,
                                                                    child:
                                                                        SfCircularChart(
                                                                      tooltipBehavior:
                                                                          TooltipBehavior(
                                                                        enable:
                                                                            true,
                                                                      ),
                                                                      annotations: [
                                                                        CircularChartAnnotation(
                                                                          widget:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "Call",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(name: TABLET, value: 14.5, landscapeValue: 14.5),
                                                                                  const Condition.largerThan(name: TABLET, value: 17.5, landscapeValue: 17.5, breakpoint: 800),
                                                                                ],
                                                                                defaultValue: 11.0,
                                                                              ).value,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      series: <CircularSeries>[
                                                                        DoughnutSeries<
                                                                            DataTSalesActualCall,
                                                                            String>(
                                                                          dataLabelMapper: (DataTSalesActualCall data, _) => data
                                                                              .datalablecall
                                                                              .toString(),
                                                                          dataSource:
                                                                              toDynamicCall(listRptTSalesActualByModelRes[0].listRptTSalesActual!),
                                                                          xValueMapper: (DataTSalesActualCall data, _) =>
                                                                              data.x,
                                                                          yValueMapper: (DataTSalesActualCall data, _) =>
                                                                              data.y,
                                                                          pointColorMapper: (DataTSalesActualCall data, _) =>
                                                                              data.color,
                                                                          innerRadius:
                                                                              '60%',
                                                                          radius:
                                                                              '90%',
                                                                          explode:
                                                                              true,
                                                                          explodeGesture:
                                                                              ActivationMode.singleTap,
                                                                          explodeOffset:
                                                                              '5',
                                                                          explodeIndex:
                                                                              1,
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            showZeroValue:
                                                                                false,
                                                                            isVisible:
                                                                                true,
                                                                            labelAlignment:
                                                                                ChartDataLabelAlignment.middle,
                                                                            overflowMode:
                                                                                OverflowMode.trim,
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ],
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
                                                                0,
                                                                10,
                                                                0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 215,
                                                                    width: 220,
                                                                    child:
                                                                        SfCircularChart(
                                                                      tooltipBehavior:
                                                                          TooltipBehavior(
                                                                        enable:
                                                                            true,
                                                                      ),
                                                                      annotations: [
                                                                        CircularChartAnnotation(
                                                                          widget:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "Prospect",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(name: TABLET, value: 14.5, landscapeValue: 14.5),
                                                                                  const Condition.largerThan(name: TABLET, value: 17.5, landscapeValue: 17.5, breakpoint: 800),
                                                                                ],
                                                                                defaultValue: 11.0,
                                                                              ).value,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      series: <CircularSeries>[
                                                                        DoughnutSeries<
                                                                            DataTSalesActualProspect,
                                                                            String>(
                                                                          dataLabelMapper: (DataTSalesActualProspect data, _) => data
                                                                              .datalableprospect
                                                                              .toString(),
                                                                          dataSource:
                                                                              toDynamicProspect(listRptTSalesActualByModelRes[0].listRptTSalesActual!),
                                                                          xValueMapper: (DataTSalesActualProspect data, _) =>
                                                                              data.x,
                                                                          yValueMapper: (DataTSalesActualProspect data, _) =>
                                                                              data.y,
                                                                          pointColorMapper: (DataTSalesActualProspect data, _) =>
                                                                              data.color,
                                                                          innerRadius:
                                                                              '60%',
                                                                          radius:
                                                                              '90%',
                                                                          explode:
                                                                              true,
                                                                          explodeGesture:
                                                                              ActivationMode.singleTap,
                                                                          explodeOffset:
                                                                              '5',
                                                                          explodeIndex:
                                                                              1,
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            showZeroValue:
                                                                                false,
                                                                            isVisible:
                                                                                true,
                                                                            labelAlignment:
                                                                                ChartDataLabelAlignment.middle,
                                                                            overflowMode:
                                                                                OverflowMode.trim,
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
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
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                0,
                                                                10,
                                                                0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 215,
                                                                    width: 220,
                                                                    child:
                                                                        SfCircularChart(
                                                                      tooltipBehavior:
                                                                          TooltipBehavior(
                                                                        enable:
                                                                            true,
                                                                      ),
                                                                      annotations: [
                                                                        CircularChartAnnotation(
                                                                          widget:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "HOT",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(name: TABLET, value: 14.5, landscapeValue: 14.5),
                                                                                  const Condition.largerThan(name: TABLET, value: 17.5, landscapeValue: 17.5, breakpoint: 800),
                                                                                ],
                                                                                defaultValue: 11.0,
                                                                              ).value,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      series: <CircularSeries>[
                                                                        DoughnutSeries<
                                                                            DataTSalesActualHot,
                                                                            String>(
                                                                          dataLabelMapper: (DataTSalesActualHot data, _) => data
                                                                              .datalablehot
                                                                              .toString(),
                                                                          dataSource:
                                                                              toDynamicHot(listRptTSalesActualByModelRes[0].listRptTSalesActual!),
                                                                          xValueMapper: (DataTSalesActualHot data, _) =>
                                                                              data.x,
                                                                          yValueMapper: (DataTSalesActualHot data, _) =>
                                                                              data.y,
                                                                          pointColorMapper: (DataTSalesActualHot data, _) =>
                                                                              data.color,
                                                                          innerRadius:
                                                                              '60%',
                                                                          radius:
                                                                              '90%',
                                                                          explode:
                                                                              true,
                                                                          explodeGesture:
                                                                              ActivationMode.singleTap,
                                                                          explodeOffset:
                                                                              '5',
                                                                          explodeIndex:
                                                                              1,
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            showZeroValue:
                                                                                false,
                                                                            isVisible:
                                                                                true,
                                                                            labelAlignment:
                                                                                ChartDataLabelAlignment.middle,
                                                                            overflowMode:
                                                                                OverflowMode.trim,
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ],
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
                                                                0,
                                                                10,
                                                                0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 215,
                                                                    width: 220,
                                                                    child:
                                                                        SfCircularChart(
                                                                      tooltipBehavior:
                                                                          TooltipBehavior(
                                                                        enable:
                                                                            true,
                                                                      ),
                                                                      annotations: [
                                                                        CircularChartAnnotation(
                                                                          widget:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "SPK",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(name: TABLET, value: 14.5, landscapeValue: 14.5),
                                                                                  const Condition.largerThan(name: TABLET, value: 17.5, landscapeValue: 17.5, breakpoint: 800),
                                                                                ],
                                                                                defaultValue: 11.0,
                                                                              ).value,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      series: <CircularSeries>[
                                                                        DoughnutSeries<
                                                                            DataTSalesActualSpk,
                                                                            String>(
                                                                          dataLabelMapper: (DataTSalesActualSpk data, _) => data
                                                                              .datalablespk
                                                                              .toString(),
                                                                          dataSource:
                                                                              toDynamicSpk(listRptTSalesActualByModelRes[0].listRptTSalesActual!),
                                                                          xValueMapper: (DataTSalesActualSpk data, _) =>
                                                                              data.x,
                                                                          yValueMapper: (DataTSalesActualSpk data, _) =>
                                                                              data.y,
                                                                          pointColorMapper: (DataTSalesActualSpk data, _) =>
                                                                              data.color,
                                                                          innerRadius:
                                                                              '60%',
                                                                          radius:
                                                                              '90%',
                                                                          explode:
                                                                              true,
                                                                          explodeGesture:
                                                                              ActivationMode.singleTap,
                                                                          explodeOffset:
                                                                              '5',
                                                                          explodeIndex:
                                                                              1,
                                                                          dataLabelSettings:
                                                                              const DataLabelSettings(
                                                                            showZeroValue:
                                                                                false,
                                                                            isVisible:
                                                                                true,
                                                                            labelAlignment:
                                                                                ChartDataLabelAlignment.middle,
                                                                            overflowMode:
                                                                                OverflowMode.trim,
                                                                            textStyle:
                                                                                TextStyle(color: Colors.white),
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            10,
                                                            0,
                                                            10,
                                                            0,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 400,
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    SfCircularChart(
                                                                  tooltipBehavior:
                                                                      TooltipBehavior(
                                                                    enable:
                                                                        true,
                                                                  ),
                                                                  annotations: [
                                                                    CircularChartAnnotation(
                                                                      widget:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "DO",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 25.0, landscapeValue: 25.0),
                                                                              const Condition.largerThan(name: TABLET, value: 35.0, landscapeValue: 35.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                25.5,
                                                                          ).value,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  series: <CircularSeries>[
                                                                    DoughnutSeries<
                                                                        DataTSalesActualDO,
                                                                        String>(
                                                                      dataLabelMapper: (DataTSalesActualDO data, _) => data
                                                                          .datalabledo
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptTSalesActualByModelRes[0].listRptTSalesActual!),
                                                                      xValueMapper:
                                                                          (DataTSalesActualDO data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataTSalesActualDO data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataTSalesActualDO data, _) =>
                                                                              data.color,
                                                                      innerRadius:
                                                                          '60%',
                                                                      radius:
                                                                          '90%',
                                                                      explode:
                                                                          true,
                                                                      explodeGesture:
                                                                          ActivationMode
                                                                              .singleTap,
                                                                      explodeOffset:
                                                                          '5',
                                                                      explodeIndex:
                                                                          1,
                                                                      dataLabelSettings:
                                                                          const DataLabelSettings(
                                                                        showZeroValue:
                                                                            false,
                                                                        isVisible:
                                                                            true,
                                                                        labelAlignment:
                                                                            ChartDataLabelAlignment.middle,
                                                                        overflowMode:
                                                                            OverflowMode.trim,
                                                                        textStyle:
                                                                            TextStyle(color: Colors.white),
                                                                      ),
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .rectangle,
                                                                    ),
                                                                  ],
                                                                  legend:
                                                                      Legend(
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
                                                                              value: 14.0,
                                                                              landscapeValue: 14.0),
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
                                                                    isVisible:
                                                                        true,
                                                                    position:
                                                                        LegendPosition
                                                                            .bottom,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: [
                                                              _tabBar,
                                                              Expanded(
                                                                child:
                                                                    TabBarView(
                                                                  controller:
                                                                      _tabController,
                                                                  children: [
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const AlwaysScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          1,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                20,
                                                                                20,
                                                                                20,
                                                                                20,
                                                                              ),
                                                                              child: Container(
                                                                                constraints: const BoxConstraints(
                                                                                  minHeight: 600,
                                                                                  minWidth: double.infinity,
                                                                                ),
                                                                                child: DataTable(
                                                                                  border: const TableBorder(
                                                                                    horizontalInside: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        27,
                                                                                        37,
                                                                                        68,
                                                                                      ),
                                                                                      width: 2.5,
                                                                                    ),
                                                                                  ),
                                                                                  columnSpacing: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 20.0, landscapeValue: 20.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0)
                                                                                    ],
                                                                                    defaultValue: 10,
                                                                                  ).value,
                                                                                  horizontalMargin: ResponsiveValue<double>(context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 7.0, landscapeValue: 7.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 7.0, landscapeValue: 7.0, breakpoint: 800)
                                                                                          ],
                                                                                          defaultValue: 10.0)
                                                                                      .value,
                                                                                  headingRowHeight: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 35.0, landscapeValue: 35.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 50.0, landscapeValue: 50.0, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 30.0,
                                                                                  ).value,
                                                                                  columns: [
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: SizedBox(
                                                                                          width: 130,
                                                                                          child: Text(
                                                                                            "CABANG",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 110,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "TARGET",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 70,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "ACTUAL",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 55,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "%",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  rows: List<DataRow>.generate(
                                                                                    dataTSalesActual.listRptTSalesActual!.length,
                                                                                    (indexObj) {
                                                                                      final dataRptTSalesActual = dataTSalesActual.listRptTSalesActual![indexObj];

                                                                                      var textStyleDataTable = TextStyle(
                                                                                        color: dataTSalesActual.listRptTSalesActual![indexObj].headerCode == 'TOTAL' || dataTSalesActual.listRptTSalesActual![indexObj].tipe == 'Sales' || dataTSalesActual.listRptTSalesActual![indexObj].headerName == 'TOTAL'
                                                                                            ? const Color.fromARGB(
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                              )
                                                                                            : Colors.blue,
                                                                                        fontSize: ResponsiveValue<double>(
                                                                                          context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                          ],
                                                                                          defaultValue: 11.0,
                                                                                        ).value,
                                                                                      );

                                                                                      return DataRow(
                                                                                        color: MaterialStateColor.resolveWith(
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
                                                                                            Text(
                                                                                              dataRptTSalesActual.headerName,
                                                                                              style: textStyleDataTable,
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.tCall.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.call.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.perCall.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
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
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const AlwaysScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          1,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                20,
                                                                                20,
                                                                                20,
                                                                                20,
                                                                              ),
                                                                              child: Container(
                                                                                constraints: const BoxConstraints(
                                                                                  minHeight: 600,
                                                                                  minWidth: double.infinity,
                                                                                ),
                                                                                child: DataTable(
                                                                                  border: const TableBorder(
                                                                                    horizontalInside: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        27,
                                                                                        37,
                                                                                        68,
                                                                                      ),
                                                                                      width: 2.5,
                                                                                    ),
                                                                                  ),
                                                                                  columnSpacing: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 20.0, landscapeValue: 20.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0)
                                                                                    ],
                                                                                    defaultValue: 10,
                                                                                  ).value,
                                                                                  horizontalMargin: ResponsiveValue<double>(context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 7.0, landscapeValue: 7.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 7.0, landscapeValue: 7.0, breakpoint: 800)
                                                                                          ],
                                                                                          defaultValue: 10.0)
                                                                                      .value,
                                                                                  headingRowHeight: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 42.0, landscapeValue: 42.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 50.0, landscapeValue: 50.0, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 40.0,
                                                                                  ).value,
                                                                                  columns: [
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: SizedBox(
                                                                                          width: 130,
                                                                                          child: Text(
                                                                                            "CABANG",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 110,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "TARGET",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 70,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "ACTUAL",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 55,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "%",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  rows: List<DataRow>.generate(
                                                                                    dataTSalesActual.listRptTSalesActual!.length,
                                                                                    (indexObj) {
                                                                                      final dataRptTSalesActual = dataTSalesActual.listRptTSalesActual![indexObj];

                                                                                      var textStyleDataTable = TextStyle(
                                                                                        color: dataTSalesActual.listRptTSalesActual![indexObj].headerCode == 'TOTAL' || dataTSalesActual.listRptTSalesActual![indexObj].tipe == 'Sales' || dataTSalesActual.listRptTSalesActual![indexObj].headerName == 'TOTAL'
                                                                                            ? const Color.fromARGB(
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                              )
                                                                                            : Colors.blue,
                                                                                        fontSize: ResponsiveValue<double>(
                                                                                          context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                          ],
                                                                                          defaultValue: 11.0,
                                                                                        ).value,
                                                                                      );

                                                                                      return DataRow(
                                                                                        color: MaterialStateColor.resolveWith(
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
                                                                                            Text(
                                                                                              dataRptTSalesActual.headerName,
                                                                                              style: textStyleDataTable,
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.tProspek.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.prospek.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.perProspek.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
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
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const AlwaysScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          1,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                20,
                                                                                20,
                                                                                20,
                                                                                20,
                                                                              ),
                                                                              child: Container(
                                                                                constraints: const BoxConstraints(
                                                                                  minHeight: 600,
                                                                                  minWidth: double.infinity,
                                                                                ),
                                                                                child: DataTable(
                                                                                  border: const TableBorder(
                                                                                    horizontalInside: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        27,
                                                                                        37,
                                                                                        68,
                                                                                      ),
                                                                                      width: 2.5,
                                                                                    ),
                                                                                  ),
                                                                                  columnSpacing: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 20.0, landscapeValue: 20.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0)
                                                                                    ],
                                                                                    defaultValue: 10,
                                                                                  ).value,
                                                                                  horizontalMargin: ResponsiveValue<double>(context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 7.0, landscapeValue: 7.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 7.0, landscapeValue: 7.0, breakpoint: 800)
                                                                                          ],
                                                                                          defaultValue: 10.0)
                                                                                      .value,
                                                                                  headingRowHeight: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 42.0, landscapeValue: 42.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 50.0, landscapeValue: 50.0, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 40.0,
                                                                                  ).value,
                                                                                  columns: [
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: SizedBox(
                                                                                          width: 130,
                                                                                          child: Text(
                                                                                            "CABANG",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 110,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "TARGET",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 70,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "ACTUAL",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 55,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "%",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  rows: List<DataRow>.generate(
                                                                                    dataTSalesActual.listRptTSalesActual!.length,
                                                                                    (indexObj) {
                                                                                      final dataRptTSalesActual = dataTSalesActual.listRptTSalesActual![indexObj];

                                                                                      var textStyleDataTable = TextStyle(
                                                                                        color: dataTSalesActual.listRptTSalesActual![indexObj].headerCode == 'TOTAL' || dataTSalesActual.listRptTSalesActual![indexObj].tipe == 'Sales' || dataTSalesActual.listRptTSalesActual![indexObj].headerName == 'TOTAL'
                                                                                            ? const Color.fromARGB(
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                              )
                                                                                            : Colors.blue,
                                                                                        fontSize: ResponsiveValue<double>(
                                                                                          context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                          ],
                                                                                          defaultValue: 11.0,
                                                                                        ).value,
                                                                                      );

                                                                                      return DataRow(
                                                                                        color: MaterialStateColor.resolveWith(
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
                                                                                            Text(
                                                                                              dataRptTSalesActual.headerName,
                                                                                              style: textStyleDataTable,
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.tHot.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.hot.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.perHot.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
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
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const AlwaysScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          1,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                20,
                                                                                20,
                                                                                20,
                                                                                20,
                                                                              ),
                                                                              child: Container(
                                                                                constraints: const BoxConstraints(
                                                                                  minHeight: 600,
                                                                                  minWidth: double.infinity,
                                                                                ),
                                                                                child: DataTable(
                                                                                  border: const TableBorder(
                                                                                    horizontalInside: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        27,
                                                                                        37,
                                                                                        68,
                                                                                      ),
                                                                                      width: 2.5,
                                                                                    ),
                                                                                  ),
                                                                                  columnSpacing: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 20.0, landscapeValue: 20.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0)
                                                                                    ],
                                                                                    defaultValue: 10,
                                                                                  ).value,
                                                                                  horizontalMargin: ResponsiveValue<double>(context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 7.0, landscapeValue: 7.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 7.0, landscapeValue: 7.0, breakpoint: 800)
                                                                                          ],
                                                                                          defaultValue: 10.0)
                                                                                      .value,
                                                                                  headingRowHeight: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 42.0, landscapeValue: 42.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 50.0, landscapeValue: 50.0, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 40.0,
                                                                                  ).value,
                                                                                  columns: [
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: SizedBox(
                                                                                          width: 130,
                                                                                          child: Text(
                                                                                            "CABANG",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 110,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "TARGET",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 70,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "ACTUAL",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 55,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "%",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  rows: List<DataRow>.generate(
                                                                                    dataTSalesActual.listRptTSalesActual!.length,
                                                                                    (indexObj) {
                                                                                      final dataRptTSalesActual = dataTSalesActual.listRptTSalesActual![indexObj];

                                                                                      var textStyleDataTable = TextStyle(
                                                                                        color: dataTSalesActual.listRptTSalesActual![indexObj].headerCode == 'TOTAL' || dataTSalesActual.listRptTSalesActual![indexObj].tipe == 'Sales' || dataTSalesActual.listRptTSalesActual![indexObj].headerName == 'TOTAL'
                                                                                            ? const Color.fromARGB(
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                              )
                                                                                            : Colors.blue,
                                                                                        fontSize: ResponsiveValue<double>(
                                                                                          context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                          ],
                                                                                          defaultValue: 11.0,
                                                                                        ).value,
                                                                                      );

                                                                                      return DataRow(
                                                                                        color: MaterialStateColor.resolveWith(
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
                                                                                            Text(
                                                                                              dataRptTSalesActual.headerName,
                                                                                              style: textStyleDataTable,
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.tSpk.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.spk.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.perSpk.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
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
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const AlwaysScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          1,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                20,
                                                                                20,
                                                                                20,
                                                                                20,
                                                                              ),
                                                                              child: Container(
                                                                                constraints: const BoxConstraints(
                                                                                  minHeight: 600,
                                                                                  minWidth: double.infinity,
                                                                                ),
                                                                                child: DataTable(
                                                                                  border: const TableBorder(
                                                                                    horizontalInside: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        27,
                                                                                        37,
                                                                                        68,
                                                                                      ),
                                                                                      width: 2.5,
                                                                                    ),
                                                                                  ),
                                                                                  columnSpacing: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 20.0, landscapeValue: 20.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0)
                                                                                    ],
                                                                                    defaultValue: 10,
                                                                                  ).value,
                                                                                  horizontalMargin: ResponsiveValue<double>(context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 7.0, landscapeValue: 7.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 7.0, landscapeValue: 7.0, breakpoint: 800)
                                                                                          ],
                                                                                          defaultValue: 10.0)
                                                                                      .value,
                                                                                  headingRowHeight: ResponsiveValue<double>(
                                                                                    context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(name: TABLET, value: 42.0, landscapeValue: 42.0),
                                                                                      const Condition.largerThan(name: TABLET, value: 50.0, landscapeValue: 50.0, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 40.0,
                                                                                  ).value,
                                                                                  columns: [
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: SizedBox(
                                                                                          width: 130,
                                                                                          child: Text(
                                                                                            "CABANG",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 110,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "TARGET",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 70,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "ACTUAL",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    DataColumn(
                                                                                      label: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: SizedBox(
                                                                                          width: 55,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            "%",
                                                                                            style: textStyleColorWhiteB,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  rows: List<DataRow>.generate(
                                                                                    dataTSalesActual.listRptTSalesActual!.length,
                                                                                    (indexObj) {
                                                                                      final dataRptTSalesActual = dataTSalesActual.listRptTSalesActual![indexObj];

                                                                                      var textStyleDataTable = TextStyle(
                                                                                        color: dataTSalesActual.listRptTSalesActual![indexObj].headerCode == 'TOTAL' || dataTSalesActual.listRptTSalesActual![indexObj].tipe == 'Sales' || dataTSalesActual.listRptTSalesActual![indexObj].headerName == 'TOTAL'
                                                                                            ? const Color.fromARGB(
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                                255,
                                                                                              )
                                                                                            : Colors.blue,
                                                                                        fontSize: ResponsiveValue<double>(
                                                                                          context,
                                                                                          conditionalValues: [
                                                                                            const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                            const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                          ],
                                                                                          defaultValue: 11.0,
                                                                                        ).value,
                                                                                      );

                                                                                      return DataRow(
                                                                                        color: MaterialStateColor.resolveWith(
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
                                                                                            Text(
                                                                                              dataRptTSalesActual.headerName,
                                                                                              style: textStyleDataTable,
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.tDo.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.dO.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          DataCell(
                                                                                            Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                                                                dataRptTSalesActual.perDo.toString(),
                                                                                                textAlign: TextAlign.right,
                                                                                                style: textStyleColorWhite,
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
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DataTSalesActualCall {
  String x;
  int y;
  int datalablecall;
  Color color;

  DataTSalesActualCall(this.x, this.y, this.datalablecall, this.color);
}

dynamic toDynamicCall(List<ListRptTSalesActual> objList) {
  List<DataTSalesActualCall> chartDataCall = <DataTSalesActualCall>[
    DataTSalesActualCall(
      "Target",
      objList[0].tCall > 0 || objList[0].call > 0 ? objList[0].tCall : 50,
      objList[0].tCall > 0 ? objList[0].tCall : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataTSalesActualCall(
      "Actual",
      objList[0].call > 0 || objList[0].tCall > 0 ? objList[0].call : 50,
      objList[0].call > 0 ? objList[0].call : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
  ];
  return chartDataCall;
}

class DataTSalesActualProspect {
  String x;
  int y;
  int datalableprospect;
  Color color;

  DataTSalesActualProspect(this.x, this.y, this.datalableprospect, this.color);
}

dynamic toDynamicProspect(List<ListRptTSalesActual> objList) {
  List<DataTSalesActualProspect> chartDataProspect = <DataTSalesActualProspect>[
    DataTSalesActualProspect(
      "Target",
      objList[0].tProspek > 0 || objList[0].prospek > 0
          ? objList[0].tProspek
          : 50,
      objList[0].tProspek > 0 ? objList[0].tProspek : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataTSalesActualProspect(
      "Actual",
      objList[0].prospek > 0 || objList[0].tProspek > 0
          ? objList[0].prospek
          : 50,
      objList[0].prospek > 0 ? objList[0].prospek : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
  ];
  return chartDataProspect;
}

class DataTSalesActualHot {
  String x;
  int y;
  int datalablehot;
  Color color;

  DataTSalesActualHot(this.x, this.y, this.datalablehot, this.color);
}

dynamic toDynamicHot(List<ListRptTSalesActual> objList) {
  List<DataTSalesActualHot> chartDataHot = <DataTSalesActualHot>[
    DataTSalesActualHot(
      "Target",
      objList[0].tHot > 0 || objList[0].hot > 0 ? objList[0].tHot : 50,
      objList[0].tHot > 0 ? objList[0].tHot : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataTSalesActualHot(
      "Actual",
      objList[0].hot > 0 || objList[0].tHot > 0 ? objList[0].hot : 50,
      objList[0].hot > 0 ? objList[0].hot : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
  ];
  return chartDataHot;
}

class DataTSalesActualSpk {
  String x;
  int y;
  int datalablespk;
  Color color;

  DataTSalesActualSpk(this.x, this.y, this.datalablespk, this.color);
}

dynamic toDynamicSpk(List<ListRptTSalesActual> objList) {
  List<DataTSalesActualSpk> chartDataSpk = <DataTSalesActualSpk>[
    DataTSalesActualSpk(
      "Target",
      objList[0].tSpk > 0 || objList[0].spk > 0 ? objList[0].tSpk : 50,
      objList[0].tSpk > 0 ? objList[0].tSpk : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataTSalesActualSpk(
      "Actual",
      objList[0].spk > 0 || objList[0].tSpk > 0 ? objList[0].spk : 50,
      objList[0].spk > 0 ? objList[0].spk : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
  ];
  return chartDataSpk;
}

class DataTSalesActualDO {
  String x;
  int y;
  int datalabledo;
  Color color;

  DataTSalesActualDO(this.x, this.y, this.datalabledo, this.color);
}

dynamic toDynamic(List<ListRptTSalesActual> objList) {
  List<DataTSalesActualDO> chartData = <DataTSalesActualDO>[
    DataTSalesActualDO(
      "Target",
      objList[0].tDo > 0 || objList[0].dO > 0 ? objList[0].tDo : 50,
      objList[0].tDo > 0 ? objList[0].tDo : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataTSalesActualDO(
      "Actual",
      objList[0].dO > 0 || objList[0].tDo > 0 ? objList[0].dO : 50,
      objList[0].dO > 0 ? objList[0].dO : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
  ];
  return chartData;
}
