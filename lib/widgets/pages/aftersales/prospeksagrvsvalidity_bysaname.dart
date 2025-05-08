import 'package:awas_ace/provider/reportaftersales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksagrmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekSaGRBySANamePage extends StatefulWidget {
  final Object? linkPageObj;
  const ProspekSaGRBySANamePage({super.key, required this.linkPageObj});

  static const String routeName = "/prospekSaGRBySANamePage";
  @override
  State<ProspekSaGRBySANamePage> createState() =>
      _ProspekSaGRBySANamePageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _ProspekSaGRBySANamePageState extends State<ProspekSaGRBySANamePage> {
  Widget titleBar = const Text(
    "Prospek SA GR VS Validity",
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

  List<ListRptAfterSlsProspekSaGRResponse> listRptProspekSaGRRes = [];

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

                    final rptProspekSaGR =
                        ref.watch(reportProspekSaGRBySAName(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptProspekSaGR.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt.listRptProspekSaGR !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptProspekSaGR!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptProspekSaGR![0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptProspekSaGR!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSaGR![0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptProspekSaGR!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSaGR![0].year
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
                                                                          .listRptProspekSaGR![
                                                                              0]
                                                                          .month;
                                                                  var yearNow =
                                                                      dataSelectOpt
                                                                          .listRptProspekSaGR![
                                                                              0]
                                                                          .year;
                                                                  var branch =
                                                                      dataSelectOpt
                                                                          .listRptProspekSaGR![
                                                                              0]
                                                                          .headerCode;

                                                                  var linkResultPeriodTipe =
                                                                      '$monthNow/$yearNow/$tipePeriode/$branch';

                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                    context,
                                                                    ProspekSaGRBySANamePage
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
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .periodTipe;
                                                                var branch =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .headerCode;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe/$branch';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  ProspekSaGRBySANamePage
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
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .periodTipe;
                                                                var branch =
                                                                    dataSelectOpt
                                                                        .listRptProspekSaGR![
                                                                            0]
                                                                        .headerCode;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe/$branch';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  ProspekSaGRBySANamePage
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
                                                        "Periode : ${dataSelectOpt.listRptProspekSaGR![0].monthID} ${dataSelectOpt.listRptProspekSaGR![0].year}",
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
                                        reportProspekSaGRBySAName(
                                            linkPageObj.toString()));
                                  },
                                  child: rptProspekSaGR.when(
                                    data: (dataProspekSaGR) {
                                      listRptProspekSaGRRes.clear();
                                      listRptProspekSaGRRes
                                          .add(dataProspekSaGR);

                                      return (dataProspekSaGR
                                                  .listRptProspekSaGR !=
                                              null)
                                          ? dataProspekSaGR.listRptProspekSaGR!
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
                                                                        DataProspekSaGR,
                                                                        String>(
                                                                      dataLabelMapper: (DataProspekSaGR data, _) => data
                                                                          .datalable
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptProspekSaGRRes[0].listRptProspekSaGR!),
                                                                      xValueMapper:
                                                                          (DataProspekSaGR data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataProspekSaGR data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataProspekSaGR data, _) =>
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
                                                                dataProspekSaGR
                                                                    .listRptProspekSaGR!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptProspekSaGR =
                                                                      dataProspekSaGR
                                                                              .listRptProspekSaGR![
                                                                          indexObj];

                                                                  var perValidAll = dataProspekSaGR
                                                                              .listRptProspekSaGR![
                                                                                  indexObj]
                                                                              .prospekAll >
                                                                          0
                                                                      ? (dataProspekSaGR
                                                                              .listRptProspekSaGR![
                                                                                  indexObj]
                                                                              .validAll /
                                                                          dataProspekSaGR
                                                                              .listRptProspekSaGR![indexObj]
                                                                              .prospekAll *
                                                                          100)
                                                                      : 0;

                                                                  var perValidSA = dataProspekSaGR
                                                                              .listRptProspekSaGR![
                                                                                  indexObj]
                                                                              .prospekSA >
                                                                          0
                                                                      ? (dataProspekSaGR
                                                                              .listRptProspekSaGR![
                                                                                  indexObj]
                                                                              .validSA /
                                                                          dataProspekSaGR
                                                                              .listRptProspekSaGR![indexObj]
                                                                              .prospekSA *
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
                                                                              dataRptProspekSaGR.headerName,
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
                                                                            dataRptProspekSaGR.prospekAll.toString(),
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
                                                                            dataRptProspekSaGR.prospekSA.toString(),
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
                                                                              text: dataRptProspekSaGR.validAll.toString(),
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
                                                                              text: dataRptProspekSaGR.validSA.toString(),
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

class DataProspekSaGR {
  String x;
  int y;
  int datalable;
  Color color;

  DataProspekSaGR(this.x, this.y, this.datalable, this.color);
}

dynamic toDynamic(List<ListRptProspekSaGR> objList) {
  List<DataProspekSaGR> chartData = <DataProspekSaGR>[
    DataProspekSaGR(
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
    DataProspekSaGR(
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
    DataProspekSaGR(
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
    DataProspekSaGR(
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
