import 'package:awas_ace/provider/reportbodypaint_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportbpprospeksabpmodel.dart';
import 'package:awas_ace/widgets/pages/bodypaint/prospeksabpvsvalidity_bysaname.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekSaBPPage extends StatefulWidget {
  final Object? linkPageObj;
  const ProspekSaBPPage({super.key, required this.linkPageObj});

  static const String routeName = "/prospekSaBPPage";
  @override
  State<ProspekSaBPPage> createState() => _ProspekSaBPPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _ProspekSaBPPageState extends State<ProspekSaBPPage> {
  Widget titleBar = const Text(
    "Prospek SA BP & Receiver VS Validity",
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

  List<ListRptBodyPaintProspekSaBPResponse> listRptProspekSaBPRes = [];

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

                    final rptProspekSaBP =
                        ref.watch(reportProspekSaBP(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptProspekSaBP.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt.listRptProspekSaBP !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptProspekSaBP!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptProspekSaBP![0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptProspekSaBP!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSaBP![0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptProspekSaBP!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSaBP![0].year
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
                                                                          .listRptProspekSaBP![
                                                                              0]
                                                                          .month;
                                                                  var yearNow =
                                                                      dataSelectOpt
                                                                          .listRptProspekSaBP![
                                                                              0]
                                                                          .year;
                                                                  var linkResultPeriodTipe =
                                                                      '$monthNow/$yearNow/$tipePeriode';

                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                    context,
                                                                    ProspekSaBPPage
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
                                                                        .listRptProspekSaBP![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaBP![
                                                                            0]
                                                                        .periodTipe;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  ProspekSaBPPage
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
                                                                        .listRptProspekSaBP![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaBP![
                                                                            0]
                                                                        .periodTipe;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  ProspekSaBPPage
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
                                                      "Prospek SA GR VS Validity",
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
                                                        "Periode : ${dataSelectOpt.listRptProspekSaBP![0].monthID} ${dataSelectOpt.listRptProspekSaBP![0].year}",
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
                                    return ref.refresh(reportProspekSaBP(
                                        linkPageObj.toString()));
                                  },
                                  child: rptProspekSaBP.when(
                                    data: (dataProspekSaBP) {
                                      listRptProspekSaBPRes.clear();
                                      listRptProspekSaBPRes
                                          .add(dataProspekSaBP);

                                      return (dataProspekSaBP
                                                  .listRptProspekSaBP !=
                                              null)
                                          ? dataProspekSaBP.listRptProspekSaBP!
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
                                                            10,
                                                            20,
                                                            10,
                                                            20,
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
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          "ASTRIDO",
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
                                                                              defaultValue: 25.5,
                                                                            ).value,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  series: <CircularSeries>[
                                                                    DoughnutSeries<
                                                                        DataProspekSaBP,
                                                                        String>(
                                                                      dataLabelMapper: (DataProspekSaBP data, _) => data
                                                                          .datalable
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptProspekSaBPRes[0].listRptProspekSaBP!),
                                                                      xValueMapper:
                                                                          (DataProspekSaBP data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataProspekSaBP data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataProspekSaBP data, _) =>
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
                                                                      // explodeIndex: 1,

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
                                                                      width: 80,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "CABANG",
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
                                                                        "PROS.ALL",
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
                                                                      width: 60,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "PROS.SA",
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
                                                                        "VALIDALL",
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
                                                                        "VALIDSA",
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
                                                                dataProspekSaBP
                                                                    .listRptProspekSaBP!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptProspekSaBP =
                                                                      dataProspekSaBP
                                                                              .listRptProspekSaBP![
                                                                          indexObj];

                                                                  var perValidAll = dataProspekSaBP
                                                                              .listRptProspekSaBP![
                                                                                  indexObj]
                                                                              .prospekAll >
                                                                          0
                                                                      ? (dataProspekSaBP
                                                                              .listRptProspekSaBP![
                                                                                  indexObj]
                                                                              .validAll /
                                                                          dataProspekSaBP
                                                                              .listRptProspekSaBP![indexObj]
                                                                              .prospekAll *
                                                                          100)
                                                                      : 0;

                                                                  var perValidSA = dataProspekSaBP
                                                                              .listRptProspekSaBP![
                                                                                  indexObj]
                                                                              .prospekSA >
                                                                          0
                                                                      ? (dataProspekSaBP
                                                                              .listRptProspekSaBP![
                                                                                  indexObj]
                                                                              .validSA /
                                                                          dataProspekSaBP
                                                                              .listRptProspekSaBP![indexObj]
                                                                              .prospekSA *
                                                                          100)
                                                                      : 0;

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: dataProspekSaBP.listRptProspekSaBP![indexObj].headerName ==
                                                                            'TOTAL'
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255,
                                                                          )
                                                                        : Colors
                                                                            .blue,
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
                                                                          onTap: dataProspekSaBP.listRptProspekSaBP![indexObj].headerName == 'TOTAL'
                                                                              ? () {}
                                                                              : () {
                                                                                  var month = dataProspekSaBP.listRptProspekSaBP![indexObj].month.toString();
                                                                                  var year = dataProspekSaBP.listRptProspekSaBP![indexObj].year.toString();
                                                                                  var periodTipe = dataProspekSaBP.listRptProspekSaBP![indexObj].periodTipe;
                                                                                  var branchCode = dataProspekSaBP.listRptProspekSaBP![indexObj].headerName;

                                                                                  Navigator.pushNamed(
                                                                                    context,
                                                                                    ProspekSaBPBySANamePage.routeName,
                                                                                    arguments: '$month/$year/$periodTipe/$branchCode',
                                                                                  );
                                                                                  print('$month/$year/$periodTipe/$branchCode');
                                                                                },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              dataRptProspekSaBP.headerCode,
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
                                                                            dataRptProspekSaBP.prospekAll.toString(),
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
                                                                              Text(
                                                                            dataRptProspekSaBP.prospekSA.toString(),
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
                                                                              text: dataRptProspekSaBP.validAll.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${perValidAll.ceil()}%)', style: textStyleColorGold),
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
                                                                              text: dataRptProspekSaBP.validSA.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${perValidSA.ceil()}%)', style: textStyleColorGold),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DataProspekSaBP {
  String x;
  int y;
  int datalable;
  Color color;

  DataProspekSaBP(this.x, this.y, this.datalable, this.color);
}

dynamic toDynamic(List<ListRptProspekSaBP> objList) {
  List<DataProspekSaBP> chartData = <DataProspekSaBP>[
    DataProspekSaBP(
      "Prospek ALL",
      objList[0].prospekAll > 0 ||
              objList[0].prospekSA > 0 ||
              objList[0].validAll > 0 ||
              objList[0].validSA > 0
          ? objList[0].prospekAll
          : 50,
      objList[0].prospekAll > 0 ? objList[0].prospekAll : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataProspekSaBP(
      "Prospek SA",
      objList[0].prospekSA > 0 ||
              objList[0].prospekAll > 0 ||
              objList[0].validSA > 0 ||
              objList[0].validAll > 0
          ? objList[0].prospekSA
          : 50,
      objList[0].prospekSA > 0 ? objList[0].prospekSA : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
    DataProspekSaBP(
      "ValidSA",
      objList[0].validSA > 0 ||
              objList[0].validAll > 0 ||
              objList[0].prospekAll > 0 ||
              objList[0].prospekSA > 0
          ? objList[0].validSA
          : 50,
      objList[0].validSA > 0 ? objList[0].validSA : 0,
      const Color.fromARGB(185, 255, 238, 2),
    ),
    DataProspekSaBP(
      "ValidAll",
      objList[0].validAll > 0 ||
              objList[0].validSA > 0 ||
              objList[0].prospekAll > 0 ||
              objList[0].prospekSA > 0
          ? objList[0].validAll
          : 50,
      objList[0].validAll > 0 ? objList[0].validAll : 0,
      const Color.fromARGB(192, 255, 81, 0),
    ),
  ];
  return chartData;
}
