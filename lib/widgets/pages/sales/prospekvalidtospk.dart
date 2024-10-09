import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportslsprospekvsmodel.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_byss.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekVtoSpkPage extends StatefulWidget {
  final Object? linkPageObj;
  const ProspekVtoSpkPage({super.key, required this.linkPageObj});

  static const String routeName = "/prospekVtoSpkPage";
  @override
  State<ProspekVtoSpkPage> createState() => _ProspekVtoSpkPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _ProspekVtoSpkPageState extends State<ProspekVtoSpkPage> {
  Widget titleBar = const Text(
    "Prospek Valid vs SPK",
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

  List<ListRptProspekVsResponse> listRptProspekVsByModelRes = [];

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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
    );

    var textStyleColorGold = TextStyle(
      color: const Color.fromARGB(255, 250, 158, 19),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
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

                    final rptProspekVSpk =
                        ref.watch(reportProspekVspk(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: SizedBox(
                                  child: rptProspekVSpk.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt.listRptProspekSpk !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptProspekSpk!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptProspekSpk![0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptProspekSpk!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSpk![0].month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptProspekSpk!.isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptProspekSpk![0].year
                                                    .toString()
                                            : '';

                                        return AppBar(
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
                                                        .fromLTRB(0, 15, 0, 0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
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
                                                        onChanged:
                                                            (String? newValTp) {
                                                          setState(() {
                                                            tipePeriode =
                                                                newValTp!;
                                                            var monthNow =
                                                                dataSelectOpt
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .month;
                                                            var yearNow =
                                                                dataSelectOpt
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .year;
                                                            var linkResultPeriodTipe =
                                                                '$monthNow/$yearNow/$tipePeriode';

                                                            Navigator
                                                                .pushReplacementNamed(
                                                              context,
                                                              ProspekVtoSpkPage
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
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              33,
                                                              44,
                                                              81,
                                                            ),
                                                          ),
                                                          maxHeight: 250,
                                                          offset: const Offset(
                                                              0, 0),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                MaterialStateProperty
                                                                    .all(5),
                                                            thumbVisibility:
                                                                MaterialStateProperty
                                                                    .all(true),
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
                                                            .map((valueMonth) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: valueMonth.id
                                                                .toString(),
                                                            child: Text(
                                                              valueMonth.value,
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
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .year;
                                                            var periodTipe =
                                                                dataSelectOpt
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .periodTipe;

                                                            var linkResultMonth =
                                                                '$monthSelected/$yearNow/$periodTipe';

                                                            Navigator
                                                                .pushReplacementNamed(
                                                              context,
                                                              ProspekVtoSpkPage
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
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              33,
                                                              44,
                                                              81,
                                                            ),
                                                          ),
                                                          maxHeight: 250,
                                                          offset: const Offset(
                                                              0, 0),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                MaterialStateProperty
                                                                    .all(5),
                                                            thumbVisibility:
                                                                MaterialStateProperty
                                                                    .all(true),
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
                                                        items: yearOPtions.map(
                                                            (String valueYear) {
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
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .month;
                                                            var periodTipe =
                                                                dataSelectOpt
                                                                    .listRptProspekSpk![
                                                                        0]
                                                                    .periodTipe;

                                                            var linkResultYear =
                                                                '$monthNow/$yearSelected/$periodTipe';

                                                            Navigator.pushNamed(
                                                              context,
                                                              ProspekVtoSpkPage
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
                                                            color:
                                                                Color.fromARGB(
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
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            33,
                                            44,
                                            81,
                                          ),
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
                              Padding(
                                padding: roles == 'OD' || roles == 'PD'
                                    ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
                                    : const EdgeInsets.fromLTRB(0, 10, 0, 15),
                                child: rptProspekVSpk.when(
                                  data: (dataHeader) => (dataHeader
                                              .listRptProspekSpk !=
                                          null)
                                      ? AppBar(
                                          automaticallyImplyLeading: false,
                                          centerTitle: true,
                                          title: Column(
                                            children: [
                                              Text(
                                                "Prospek Valid to SPK",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255,
                                                  ),
                                                  fontSize:
                                                      ResponsiveValue<double>(
                                                    context,
                                                    conditionalValues: [
                                                      const Condition.equals(
                                                          name: TABLET,
                                                          value: 17.0,
                                                          landscapeValue: 17.0),
                                                      const Condition
                                                          .largerThan(
                                                          name: TABLET,
                                                          value: 17.0,
                                                          landscapeValue: 17.0,
                                                          breakpoint: 800),
                                                    ],
                                                    defaultValue: 14.5,
                                                  ).value,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            33,
                                            44,
                                            81,
                                          ),
                                        )
                                      : null,
                                  error: (err, stack) => Text('Error $err'),
                                  loading: () => const Center(child: Text('')),
                                ),
                              ),
                              SizedBox(
                                child: rptProspekVSpk.when(
                                  data: (dataPeriod) => (dataPeriod
                                              .listRptProspekSpk !=
                                          null)
                                      ? AppBar(
                                          automaticallyImplyLeading: false,
                                          centerTitle: false,
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Periode : ${dataPeriod.listRptProspekSpk![0].monthID} ${dataPeriod.listRptProspekSpk![0].year}",
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
                                                              value: 12.5,
                                                              landscapeValue:
                                                                  12.5),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 12.5,
                                                              landscapeValue:
                                                                  12.5,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 11.5,
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
                                                              value: 12.5,
                                                              landscapeValue:
                                                                  12.5),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 12.5,
                                                              landscapeValue:
                                                                  12.5,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 11.5,
                                                      ).value,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            33,
                                            44,
                                            81,
                                          ),
                                        )
                                      : const Column(
                                          children: [],
                                        ),
                                  error: (err, stack) => Text('Error $err'),
                                  loading: () => const Center(child: Text('')),
                                ),
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(reportProspekVspk(
                                        linkPageObj.toString()));
                                  },
                                  child: rptProspekVSpk.when(
                                    data: (dataProspekVSpk) {
                                      listRptProspekVsByModelRes.clear();
                                      listRptProspekVsByModelRes
                                          .add(dataProspekVSpk);

                                      return (dataProspekVSpk
                                                  .listRptProspekSpk !=
                                              null)
                                          ? dataProspekVSpk
                                                  .listRptProspekSpk!.isNotEmpty
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
                                                                          Text(
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
                                                                        DataProspekVspk,
                                                                        String>(
                                                                      dataLabelMapper: (DataProspekVspk data, _) => data
                                                                          .dataLabel
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptProspekVsByModelRes[0].listRptProspekSpk!),
                                                                      xValueMapper:
                                                                          (DataProspekVspk data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataProspekVspk data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataProspekVspk data, _) =>
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
                                                                          42.0,
                                                                      landscapeValue:
                                                                          42.0),
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
                                                                    40.0,
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
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 90,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "PROSPEK ALL",
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
                                                                      width: 95,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "PROSPEK VALID",
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
                                                                      width: 40,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 40,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
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
                                                                dataProspekVSpk
                                                                    .listRptProspekSpk!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptProspekVSpk =
                                                                      dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                          indexObj];

                                                                  var persenValid = dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .prospek >
                                                                          0
                                                                      ? (dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .prospekValid /
                                                                          dataProspekVSpk
                                                                              .listRptProspekSpk![indexObj]
                                                                              .prospek *
                                                                          100)
                                                                      : 0;

                                                                  var persenSpk = dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .prospekValid >
                                                                          0
                                                                      ? (dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .spk /
                                                                          dataProspekVSpk
                                                                              .listRptProspekSpk![indexObj]
                                                                              .prospekValid *
                                                                          100)
                                                                      : 0;

                                                                  var persenDO = dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .spk >
                                                                          0
                                                                      ? (dataProspekVSpk
                                                                              .listRptProspekSpk![
                                                                                  indexObj]
                                                                              .dO /
                                                                          dataProspekVSpk
                                                                              .listRptProspekSpk![indexObj]
                                                                              .spk *
                                                                          100)
                                                                      : 0;

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: dataProspekVSpk.listRptProspekSpk![indexObj].headerCode == 'TOTAL' ||
                                                                            dataProspekVSpk.listRptProspekSpk![indexObj].tipe ==
                                                                                'Sales' ||
                                                                            dataProspekVSpk.listRptProspekSpk![indexObj].headerName ==
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
                                                                                14.0,
                                                                            landscapeValue:
                                                                                14.0),
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
                                                                          12.5,
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
                                                                          onTap: dataProspekVSpk.listRptProspekSpk![indexObj].headerCode == 'TOTAL' || dataProspekVSpk.listRptProspekSpk![indexObj].tipe == 'Sales' || dataProspekVSpk.listRptProspekSpk![indexObj].headerName == 'TOTAL'
                                                                              ? () {}
                                                                              : dataProspekVSpk.listRptProspekSpk![indexObj].tipe == 'SS'
                                                                                  ? () {
                                                                                      var month = dataProspekVSpk.listRptProspekSpk![indexObj].month.toString();
                                                                                      var year = dataProspekVSpk.listRptProspekSpk![indexObj].year.toString();
                                                                                      var periodTipe = dataProspekVSpk.listRptProspekSpk![indexObj].periodTipe;
                                                                                      var branchCode = dataProspekVSpk.listRptProspekSpk![indexObj].title;
                                                                                      var ssCode = dataProspekVSpk.listRptProspekSpk![indexObj].headerCode;

                                                                                      Navigator.pushNamed(
                                                                                        context,
                                                                                        ProspekVtoSpkSalesPage.routeName,
                                                                                        arguments: '$month/$year/$periodTipe/$branchCode/$ssCode',
                                                                                      );
                                                                                    }
                                                                                  : () {
                                                                                      var month = dataProspekVSpk.listRptProspekSpk![indexObj].month.toString();
                                                                                      var year = dataProspekVSpk.listRptProspekSpk![indexObj].year.toString();
                                                                                      var periodTipe = dataProspekVSpk.listRptProspekSpk![indexObj].periodTipe;
                                                                                      var branchCode = dataProspekVSpk.listRptProspekSpk![indexObj].headerCode;

                                                                                      Navigator.pushNamed(
                                                                                        context,
                                                                                        ProspekVtoSpkSsPage.routeName,
                                                                                        arguments: '$month/$year/$periodTipe/$branchCode',
                                                                                      );
                                                                                    },
                                                                          child:
                                                                              Text(
                                                                            roles == 'SALES SUPERVISOR' || roles == 'KACAB'
                                                                                ? dataRptProspekVSpk.headerName
                                                                                : dataRptProspekVSpk.headerCode,
                                                                            style:
                                                                                textStyleDataTable,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Text(
                                                                            dataRptProspekVSpk.prospek.toString(),
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              RichText(
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptProspekVSpk.prospekValid.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: ' (${persenValid.floor()}%)', style: textStyleColorGold),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              RichText(
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptProspekVSpk.spk.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: ' (${persenSpk.floor()}%)', style: textStyleColorGold),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              RichText(
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptProspekVSpk.dO.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: ' (${persenDO.floor()}%)', style: textStyleColorGold),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DataProspekVspk {
  String x;
  int y;
  int dataLabel;
  Color color;

  DataProspekVspk(this.x, this.y, this.dataLabel, this.color);
}

dynamic toDynamic(List<ListRptProspekSpk> objList) {
  List<DataProspekVspk> chartData = <DataProspekVspk>[
    DataProspekVspk(
      "DO",
      objList[0].dO > 0 ||
              objList[0].spk > 0 ||
              objList[0].prospekValid > 0 ||
              objList[0].prospek > 0
          ? objList[0].dO
          : 50,
      objList[0].dO > 0 ? objList[0].dO : 0,
      const Color.fromARGB(192, 255, 81, 0),
    ),
    DataProspekVspk(
      "SPK",
      objList[0].spk > 0 ||
              objList[0].dO > 0 ||
              objList[0].prospekValid > 0 ||
              objList[0].prospek > 0
          ? objList[0].spk
          : 50,
      objList[0].spk > 0 ? objList[0].spk : 0,
      const Color.fromARGB(185, 255, 238, 2),
    ),
    DataProspekVspk(
      "Prospek Valid",
      objList[0].prospekValid > 0 ||
              objList[0].dO > 0 ||
              objList[0].spk > 0 ||
              objList[0].prospek > 0
          ? objList[0].prospekValid
          : 50,
      objList[0].prospekValid > 0 ? objList[0].prospekValid : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
    DataProspekVspk(
      "Prospek ALL",
      objList[0].prospek > 0 ||
              objList[0].dO > 0 ||
              objList[0].spk > 0 ||
              objList[0].prospekValid > 0
          ? objList[0].prospek
          : 50,
      objList[0].prospek > 0 ? objList[0].prospek : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
  ];
  return chartData;
}
