import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportslsprospeuebpmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekUeBPSalesPage extends StatefulWidget {
  final Object? linkPageObj;
  const ProspekUeBPSalesPage({super.key, required this.linkPageObj});

  static const String routeName = "/prospekUeBPSalesPage";
  @override
  State<ProspekUeBPSalesPage> createState() => _ProspekUeBPSalesPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _ProspekUeBPSalesPageState extends State<ProspekUeBPSalesPage> {
  Widget titleBar = const Text(
    "Prospek UE BP to UE BP",
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

  List<ListRptProspekUeBpResponse> listRptProspekUeBPByModelRes = [];

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

                    final rptProspekUeBP =
                        ref.watch(reportProspekUeBPBySales(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: SizedBox(
                                  child: rptProspekUeBP.when(
                                    data: (dataSelectOpt) {
                                      String tipePeriode = dataSelectOpt
                                              .listRptProspekUeBp!.isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? 'MTD'
                                              : dataSelectOpt
                                                  .listRptProspekUeBp![0]
                                                  .periodTipe
                                          : '';

                                      String monthSelected = dataSelectOpt
                                              .listRptProspekUeBp!.isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? DateFormat('M')
                                                  .format(DateTime.now())
                                              : dataSelectOpt
                                                  .listRptProspekUeBp![0].month
                                                  .toString()
                                          : '';

                                      String yearSelected = dataSelectOpt
                                              .listRptProspekUeBp!.isNotEmpty
                                          ? (linkPageObj ==
                                                  '$monthNow/$yearNow')
                                              ? DateFormat('yyyy')
                                                  .format(DateTime.now())
                                              : dataSelectOpt
                                                  .listRptProspekUeBp![0].year
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
                                                          0, 15, 0, 0),
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
                                                          onChanged: (String?
                                                              newValTp) {
                                                            setState(() {
                                                              tipePeriode =
                                                                  newValTp!;
                                                              var monthNow =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .month;
                                                              var yearNow =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .year;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .headerCode2;

                                                              var linkResultPeriodTipe =
                                                                  '$monthNow/$yearNow/$tipePeriode/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                context,
                                                                ProspekUeBPSalesPage
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
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .year;
                                                              var periodTipe =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .periodTipe;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .headerCode2;

                                                              var linkResultMonth =
                                                                  '$monthSelected/$yearNow/$periodTipe/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                context,
                                                                ProspekUeBPSalesPage
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
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .month;
                                                              var periodTipe =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .periodTipe;
                                                              var branchCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .title;
                                                              var ssCode =
                                                                  dataSelectOpt
                                                                      .listRptProspekUeBp![
                                                                          0]
                                                                      .headerCode2;

                                                              var linkResultYear =
                                                                  '$monthNow/$yearSelected/$periodTipe/$branchCode/$ssCode';

                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                ProspekUeBPSalesPage
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
                                                    "Prospek Ue Bp to Ue Bp",
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
                                                    "(${dataSelectOpt.listRptProspekUeBp![0].title})",
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
                                                5,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Periode : ${dataSelectOpt.listRptProspekUeBp![0].monthID} ${dataSelectOpt.listRptProspekUeBp![0].year}",
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
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5,
                                                                breakpoint:
                                                                    800),
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
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 12.5,
                                                                landscapeValue:
                                                                    12.5,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11.5,
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
                                    return ref.refresh(reportProspekUeBPBySales(
                                        linkPageObj.toString()));
                                  },
                                  child: rptProspekUeBP.when(
                                    data: (dataProspekUeBP) {
                                      listRptProspekUeBPByModelRes.clear();
                                      listRptProspekUeBPByModelRes
                                          .add(dataProspekUeBP);

                                      return (dataProspekUeBP
                                                  .listRptProspekUeBp !=
                                              null)
                                          ? dataProspekUeBP.listRptProspekUeBp!
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
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "ASTRIDO \n${dataProspekUeBP.listRptProspekUeBp![0].persen}%",
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
                                                                        DataProspekUeBP,
                                                                        String>(
                                                                      dataLabelMapper: (DataProspekUeBP data, _) => data
                                                                          .dataLabel
                                                                          .toString(),
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptProspekUeBPByModelRes[0].listRptProspekUeBp!),
                                                                      xValueMapper:
                                                                          (DataProspekUeBP data, _) =>
                                                                              data.x,
                                                                      yValueMapper:
                                                                          (DataProspekUeBP data, _) =>
                                                                              data.y,
                                                                      pointColorMapper:
                                                                          (DataProspekUeBP data, _) =>
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
                                                                      width:
                                                                          130,
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
                                                                      width:
                                                                          110,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "PROSPEK UE BP",
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
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "%",
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
                                                                dataProspekUeBP
                                                                    .listRptProspekUeBp!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptProspekUeBP =
                                                                      dataProspekUeBP
                                                                              .listRptProspekUeBp![
                                                                          indexObj];

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: dataProspekUeBP.listRptProspekUeBp![indexObj].headerCode == 'TOTAL' ||
                                                                            dataProspekUeBP.listRptProspekUeBp![indexObj].tipe ==
                                                                                'Sales' ||
                                                                            dataProspekUeBP.listRptProspekUeBp![indexObj].headerName ==
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
                                                                        Text(
                                                                          dataRptProspekUeBP
                                                                              .headerName,
                                                                          style:
                                                                              textStyleDataTable,
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptProspekUeBP.prospekUeBp.toString(),
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
                                                                            dataRptProspekUeBP.ueBp.toString(),
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
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptProspekUeBP.persen.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorGold,
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

class DataProspekUeBP {
  String x;
  int y;
  int dataLabel;
  Color color;

  DataProspekUeBP(this.x, this.y, this.dataLabel, this.color);
}

dynamic toDynamic(List<ListRptProspekUeBp> objList) {
  List<DataProspekUeBP> chartData = <DataProspekUeBP>[
    DataProspekUeBP(
      "Prospek UE BP",
      objList[0].prospekUeBp > 0 || objList[0].ueBp > 0
          ? objList[0].prospekUeBp
          : 50,
      objList[0].prospekUeBp > 0 ? objList[0].prospekUeBp : 0,
      const Color.fromARGB(155, 0, 255, 170),
    ),
    DataProspekUeBP(
      "UE BP",
      objList[0].ueBp > 0 || objList[0].prospekUeBp > 0 ? objList[0].ueBp : 50,
      objList[0].prospekUeBp > 0 ? objList[0].prospekUeBp : 0,
      const Color.fromARGB(183, 0, 89, 255),
    ),
  ];
  return chartData;
}
