import 'package:awas_ace/provider/reportbodypaint_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportbpprospekbpuegrmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekBPtoUeGRBySANamePage extends StatefulWidget {
  final Object? linkPageObj;
  const ProspekBPtoUeGRBySANamePage({super.key, required this.linkPageObj});

  static const String routeName = "/prospekBPtoUeGRBySANamePage";
  @override
  State<ProspekBPtoUeGRBySANamePage> createState() =>
      _ProspekBPtoUeGRBySANamePageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _ProspekBPtoUeGRBySANamePageState
    extends State<ProspekBPtoUeGRBySANamePage> {
  Widget titleBar = const Text(
    "Prospek Ratio from BP to UE GR",
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

  List<ListRptBodyPaintProspekBPUeGRResponse> listRptProspekBPtoUeGRRes = [];

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
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    String monthNow = DateFormat('M').format(DateTime.now());
                    String yearNow = DateFormat('yyyy').format(DateTime.now());
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptProspekBPtoUeGR =
                        ref.watch(reportProspekBPtoUeGRBySAName(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptProspekBPtoUeGR.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt
                                              .listRptProspekBPtoUeGR !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptProspekBPtoUeGR!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptProspekBPtoUeGR![0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptProspekBPtoUeGR!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekBPtoUeGR![0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptProspekBPtoUeGR!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekBPtoUeGR![0]
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
                                                                          .listRptProspekBPtoUeGR![
                                                                              0]
                                                                          .month;
                                                                  var yearNow =
                                                                      dataSelectOpt
                                                                          .listRptProspekBPtoUeGR![
                                                                              0]
                                                                          .year;
                                                                  var branchCode =
                                                                      dataSelectOpt
                                                                          .listRptProspekBPtoUeGR![
                                                                              0]
                                                                          .headerCode;

                                                                  var linkResultPeriodTipe =
                                                                      '$monthNow/$yearNow/$tipePeriode/$branchCode';

                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                    context,
                                                                    ProspekBPtoUeGRBySANamePage
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
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .periodTipe;
                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .headerCode;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe/$branchCode';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  ProspekBPtoUeGRBySANamePage
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
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .periodTipe;
                                                                var branchCode =
                                                                    dataSelectOpt
                                                                        .listRptProspekBPtoUeGR![
                                                                            0]
                                                                        .headerCode;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe/$branchCode';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  ProspekBPtoUeGRBySANamePage
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
                                                      "Prospek Ratio from BP to UE GR",
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
                                                        "Periode : ${dataSelectOpt.listRptProspekBPtoUeGR![0].monthID} ${dataSelectOpt.listRptProspekBPtoUeGR![0].year}",
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
                                        reportProspekBPtoUeGRBySAName(
                                            linkPageObj.toString()));
                                  },
                                  child: rptProspekBPtoUeGR.when(
                                    data: (dataProspekBPtoUeGR) {
                                      listRptProspekBPtoUeGRRes.clear();
                                      listRptProspekBPtoUeGRRes
                                          .add(dataProspekBPtoUeGR);

                                      return (dataProspekBPtoUeGR
                                                  .listRptProspekBPtoUeGR !=
                                              null)
                                          ? dataProspekBPtoUeGR
                                                  .listRptProspekBPtoUeGR!
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
                                                                        DataProspekBPtoUeGR,
                                                                        String>(
                                                                      dataLabelMapper: (DataProspekBPtoUeGR data, _) => data
                                                                          .datalable
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptProspekBPtoUeGRRes[0].listRptProspekBPtoUeGR!),
                                                                      xValueMapper:
                                                                          (DataProspekBPtoUeGR data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataProspekBPtoUeGR data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataProspekBPtoUeGR data, _) =>
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
                                                                          "SA NAME",
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
                                                                        "UE BP",
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
                                                                        "GR LOCAL",
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
                                                                        "UE GR",
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
                                                                dataProspekBPtoUeGR
                                                                    .listRptProspekBPtoUeGR!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptProspekSaBP =
                                                                      dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                          indexObj];

                                                                  var perProspek = dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .ueBP >
                                                                          0
                                                                      ? (dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .prospek /
                                                                          dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![indexObj]
                                                                              .ueBP *
                                                                          100)
                                                                      : 0;

                                                                  var perGRLcl = dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .ueBP >
                                                                          0
                                                                      ? (dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .ueGRLcl /
                                                                          dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![indexObj]
                                                                              .ueBP *
                                                                          100)
                                                                      : 0;

                                                                  var perGR = dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .ueBP >
                                                                          0
                                                                      ? (dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![
                                                                                  indexObj]
                                                                              .ueGR /
                                                                          dataProspekBPtoUeGR
                                                                              .listRptProspekBPtoUeGR![indexObj]
                                                                              .ueBP *
                                                                          100)
                                                                      : 0;

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
                                                                              dataRptProspekSaBP.headerName,
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
                                                                            dataRptProspekSaBP.ueBP.toString(),
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
                                                                              text: dataRptProspekSaBP.prospek.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${perProspek.ceil()}%)', style: textStyleColorGold),
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
                                                                              text: dataRptProspekSaBP.ueGRLcl.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${perGRLcl.ceil()}%)', style: textStyleColorGold),
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
                                                                              text: dataRptProspekSaBP.ueGR.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${perGR.ceil()}%)', style: textStyleColorGold),
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

class DataProspekBPtoUeGR {
  String x;
  int y;
  int datalable;
  Color color;

  DataProspekBPtoUeGR(this.x, this.y, this.datalable, this.color);
}

dynamic toDynamic(List<ListRptProspekBPtoUeGR> objList) {
  List<DataProspekBPtoUeGR> chartData = <DataProspekBPtoUeGR>[
    DataProspekBPtoUeGR(
      "UeBP",
      objList[0].ueBP > 0 ||
              objList[0].prospek > 0 ||
              objList[0].ueGRLcl > 0 ||
              objList[0].ueGR > 0
          ? objList[0].ueBP
          : 50,
      objList[0].ueBP > 0 ? objList[0].ueBP : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
    DataProspekBPtoUeGR(
      "Prospek",
      objList[0].prospek > 0 ||
              objList[0].ueBP > 0 ||
              objList[0].ueGRLcl > 0 ||
              objList[0].ueGR > 0
          ? objList[0].prospek
          : 50,
      objList[0].prospek > 0 ? objList[0].prospek : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
    DataProspekBPtoUeGR(
      "GRLOCAL",
      objList[0].ueGRLcl > 0 ||
              objList[0].ueBP > 0 ||
              objList[0].prospek > 0 ||
              objList[0].ueGR > 0
          ? objList[0].ueGRLcl
          : 50,
      objList[0].ueGRLcl > 0 ? objList[0].ueGRLcl : 0,
      const Color.fromARGB(185, 255, 238, 2),
    ),
    DataProspekBPtoUeGR(
      "GR",
      objList[0].ueGR > 0 ||
              objList[0].ueBP > 0 ||
              objList[0].prospek > 0 ||
              objList[0].ueGRLcl > 0
          ? objList[0].ueGR
          : 50,
      objList[0].ueGR > 0 ? objList[0].ueGR : 0,
      const Color.fromARGB(192, 255, 81, 0),
    ),
  ];
  return chartData;
}
