import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportslsstockmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockByModelPage extends StatefulWidget {
  const StockByModelPage({super.key});

  static const String routeName = "/stockByModelPage";

  @override
  State<StockByModelPage> createState() => _StockByModelPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _StockByModelPageState extends State<StockByModelPage> {
  Widget titleBar = const Text(
    "Total Stock By Model",
    style: TextStyle(color: Colors.white),
  );

  String? userName;
  String? roles;
  String? sid;
  String? branchID;

  List<ListRptStockByModelResponse> listRptStockByModelRes = [];

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
              name: TABLET, value: 12.5, landscapeValue: 12.5),
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
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptStockByModel = ref.watch(reportStockByModel);

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                child: rptStockByModel.when(
                                  data: (dataPeriod) => (dataPeriod
                                              .listRptStockByModel !=
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
                                          backgroundColor: Colors.transparent,
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
                                    return ref.refresh(reportStockByModel);
                                  },
                                  child: rptStockByModel.when(
                                    data: (dataStockByModel) {
                                      listRptStockByModelRes.clear();
                                      listRptStockByModelRes
                                          .add(dataStockByModel);

                                      return (dataStockByModel
                                                  .listRptStockByModel !=
                                              null)
                                          ? dataStockByModel
                                                  .listRptStockByModel!
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
                                                                height: 900,
                                                                child:
                                                                    SfCartesianChart(
                                                                  title:
                                                                      ChartTitle(
                                                                          text:
                                                                              ""),
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
                                                                  ),
                                                                  series: <ChartSeries>[
                                                                    //memanggil isi grafik

                                                                    StackedBarSeries<
                                                                        DataStockByModel,
                                                                        String>(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        183,
                                                                        0,
                                                                        89,
                                                                        255,
                                                                      ),
                                                                      name:
                                                                          "CALL",
                                                                      legendIconType:
                                                                          LegendIconType
                                                                              .circle,
                                                                      dataSource:
                                                                          toDynamic(
                                                                              listRptStockByModelRes[0].listRptStockByModel!),
                                                                      xValueMapper:
                                                                          (DataStockByModel data, _) =>
                                                                              data.x,

                                                                      yValueMapper:
                                                                          (DataStockByModel data, _) =>
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
                                                                          120,
                                                                      child:
                                                                          Text(
                                                                        "MODEL",
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
                                                                        "FREE",
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
                                                                        "MATCH",
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
                                                                        "BLOK",
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
                                                                        "TOTAL",
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
                                                                dataStockByModel
                                                                    .listRptStockByModel!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptStockByModel =
                                                                      dataStockByModel
                                                                              .listRptStockByModel![
                                                                          indexObj];

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: dataStockByModel.listRptStockByModel![indexObj].headerCode ==
                                                                            'ASTRIDO'
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
                                                                          onTap: dataStockByModel.listRptStockByModel![indexObj].headerName == 'ASTRIDO'
                                                                              ? () {}
                                                                              : () {
                                                                                  // var month = dataStockByModel.listRptStockByModel![indexObj].month.toString();
                                                                                  // var year = dataStockByModel.listRptStockByModel![indexObj].year.toString();
                                                                                  // var periodTipe = dataStockByModel.listRptStockByModel![indexObj].periodTipe;
                                                                                  // var branchCode = dataStockByModel.listRptStockByModel![indexObj].branchCode;

                                                                                  // Navigator.pushNamed(
                                                                                  //   context,
                                                                                  //   FunnelingSSPage.routeName,
                                                                                  //   arguments: '$month/$year/$periodTipe/$branchCode',
                                                                                  // );
                                                                                },
                                                                          child:
                                                                              Text(
                                                                            dataRptStockByModel.headerName,
                                                                            style:
                                                                                textStyleDataTable,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          dataRptStockByModel
                                                                              .data1
                                                                              .toString(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          dataRptStockByModel
                                                                              .data2
                                                                              .toString(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          dataRptStockByModel
                                                                              .data3
                                                                              .toString(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          dataRptStockByModel
                                                                              .data4
                                                                              .toString(),
                                                                          style:
                                                                              textStyleColorWhite,
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

class DataStockByModel {
  String x;
  double y;

  DataStockByModel(
    this.x,
    this.y,
  );
}

dynamic toDynamic(List<ListRptStockByModel> objList) {
  List<DataStockByModel> barData = [];

  for (var i = 1; i < objList.length + 1; i++) {
    if (objList[objList.length - i].headerName != 'ASTRIDO') {
      barData.add(DataStockByModel(
        objList[objList.length - i].headerName,
        objList[objList.length - i].data4.toDouble(),
      ));
    }
  }
  return barData;
}
