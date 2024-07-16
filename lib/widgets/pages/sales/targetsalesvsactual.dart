import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TargetSalesActualPage extends StatefulWidget {
  const TargetSalesActualPage({super.key});
  static const String routeName = "/targetSalesActualPage";
  @override
  State<TargetSalesActualPage> createState() => _TargetSalesActualPageState();
}

class _TargetSalesActualPageState extends State<TargetSalesActualPage> {
  Widget titleBar = const Text(
    "Target Sales vs Actual",
    style: TextStyle(color: Colors.white),
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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
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
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: Text(
                            "Cabang TVHO",
                            style: TextStyle(
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
                                      name: TABLET,
                                      value: 17.0,
                                      landscapeValue: 17.0),
                                  const Condition.largerThan(
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
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 25),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Periode : Juli 2024",
                                  style: TextStyle(
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
                                            name: TABLET,
                                            value: 12.5,
                                            landscapeValue: 12.5),
                                        const Condition.largerThan(
                                            name: TABLET,
                                            value: 12.5,
                                            landscapeValue: 12.5,
                                            breakpoint: 800),
                                      ],
                                      defaultValue: 11.5,
                                    ).value,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Tanggal Hari ini : ",
                                  style: TextStyle(
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
                                            name: TABLET,
                                            value: 12.5,
                                            landscapeValue: 12.5),
                                        const Condition.largerThan(
                                            name: TABLET,
                                            value: 12.5,
                                            landscapeValue: 12.5,
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
                      ),
                      SingleChildScrollView(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 250,
                                  width: 230,
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: const Text(
                                          "CALL",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      DoughnutSeries<SalesData, String>(
                                        dataSource: getColumnData(),
                                        xValueMapper: (SalesData sales, _) =>
                                            sales.x,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.y,
                                        pointColorMapper:
                                            (SalesData sales, _) => sales.color,

                                        innerRadius: '60%',
                                        radius: '90%',
                                        explode: true,

                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        // explodeIndex: 1,

                                        // untuk menampilkan label pada grafik
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                showZeroValue: true,
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment
                                                        .middle,
                                                overflowMode: OverflowMode.trim,
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  width: 230,
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: const Text(
                                          "PROSPECT",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      DoughnutSeries<SalesData, String>(
                                        dataSource: getColumnData(),
                                        xValueMapper: (SalesData sales, _) =>
                                            sales.x,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.y,
                                        pointColorMapper:
                                            (SalesData sales, _) => sales.color,

                                        innerRadius: '60%',
                                        radius: '90%',
                                        explode: true,

                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        // explodeIndex: 1,

                                        // untuk menampilkan label pada grafik
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                showZeroValue: true,
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment
                                                        .middle,
                                                overflowMode: OverflowMode.trim,
                                                textStyle: TextStyle(
                                                    color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 400,
                                  width: double.infinity,
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: const Text(
                                          "ASTRIDO",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      DoughnutSeries<SalesData, String>(
                                        dataSource: getColumnData(),
                                        xValueMapper: (SalesData sales, _) =>
                                            sales.x,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.y,
                                        pointColorMapper:
                                            (SalesData sales, _) => sales.color,

                                        innerRadius: '60%',
                                        radius: '90%',
                                        explode: true,

                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        // explodeIndex: 1,

                                        // untuk menampilkan label pada grafik
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                showZeroValue: true,
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment
                                                        .middle,
                                                overflowMode: OverflowMode.trim,
                                                textStyle: TextStyle(
                                                    color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Text("data")),
                          ],
                        ),
                      ),
                      Column(
                        children: [],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                          child: DataTable2(
                            border: const TableBorder(
                              bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(
                                  30,
                                  255,
                                  255,
                                  255,
                                ),
                              ),
                            ),
                            columnSpacing: 0,
                            horizontalMargin: 5,
                            minWidth: 400,
                            headingRowHeight: 40.0,
                            columns: [
                              DataColumn2(
                                label: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "CABANG",
                                    style: textStyleColorWhite,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataColumn2(
                                  size: ColumnSize.L,
                                  label: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "GATEPASS",
                                      style: textStyleColorWhite,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "SBI",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "%",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "data",
                                      style: textStyleColorWhite,
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "data",
                                        style: textStyleColorWhite,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "data",
                                        style: textStyleColorWhite,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "data",
                                        style: textStyleColorWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SalesData {
  String x;
  double y;
  Color color;
  SalesData(this.x, this.y, this.color);
}

// isi dari grafik
dynamic getColumnData() {
  List<SalesData> columnData = <SalesData>[
    SalesData("Toyota", 127, Colors.blue.shade700),
    SalesData("Daihatsu", 77, Colors.greenAccent.shade700),
  ];
  return columnData;
}
