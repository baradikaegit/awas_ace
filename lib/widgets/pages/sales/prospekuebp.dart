import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspekUeBPPage extends StatefulWidget {
  const ProspekUeBPPage({super.key});
  static const String routeName = "/prospekUeBPPage";
  @override
  State<ProspekUeBPPage> createState() => _ProspekUeBPPageState();
}

class _ProspekUeBPPageState extends State<ProspekUeBPPage> {
  Widget titleBar = const Text(
    "Prospek UE BP to UE BP",
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
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: Text(
                            "Prospek UE BP to UE BP (TVHO)",
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 230,
                            minWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(69, 70, 70, 70),
                                blurRadius: 5.0,
                                offset: Offset(0, 0),
                                spreadRadius: 2.1,
                              ),
                            ],
                            border: Border.all(
                              color: Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromARGB(
                              255,
                              33,
                              44,
                              81,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 230,
                                  child: SfCircularChart(
                                    series: <CircularSeries>[
                                      DoughnutSeries<SalesData, String>(
                                        dataSource: getColumnData(),
                                        xValueMapper: (SalesData sales, _) =>
                                            sales.x,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.y,

                                        selectionBehavior:
                                            SelectionBehavior(enable: true),
                                        onPointTap: (pointInteractionDetails) {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => DetailPage(),
                                          //   ),
                                          // );
                                        },

                                        // untuk menampilkan label pada grafik
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          showZeroValue: true,
                                          isVisible: true,
                                          labelAlignment:
                                              ChartDataLabelAlignment.middle,
                                          overflowMode: OverflowMode.trim,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                      "PORESPECT UE BP",
                                      style: textStyleColorWhite,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "UE BP",
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
                                    Text(
                                      "data",
                                      style: textStyleColorWhite,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "data",
                                      style: textStyleColorWhite,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "data",
                                      style: textStyleColorWhite,
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

  SalesData(this.x, this.y);
}

// isi dari grafik
dynamic getColumnData() {
  List<SalesData> columnData = <SalesData>[
    SalesData("Toyota", 654),
    SalesData("Daihatsu", 575),
  ];
  return columnData;
}
