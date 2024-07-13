import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitProfitMakerPage extends StatefulWidget {
  const MonitProfitMakerPage({super.key});
  static const String routeName = "/monitProfitMakerPage";
  @override
  State<MonitProfitMakerPage> createState() => _MonitProfitMakerPageState();
}

class _MonitProfitMakerPageState extends State<MonitProfitMakerPage> {
  Widget titleBar = const Text(
    "Monitoring Profit Maker",
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
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
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
                            "Monitoring Profit Maker",
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
                            maxLines: 2,
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
                                            value: 17.0,
                                            landscapeValue: 17.0),
                                        const Condition.largerThan(
                                            name: TABLET,
                                            value: 17.0,
                                            landscapeValue: 17.0,
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
                                            value: 17.0,
                                            landscapeValue: 17.0),
                                        const Condition.largerThan(
                                            name: TABLET,
                                            value: 17.0,
                                            landscapeValue: 17.0,
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
                            columnSpacing: 5,
                            horizontalMargin: 12,
                            minWidth: 350,
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
                                      "2022",
                                      style: textStyleColorWhite,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "2023",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "GROWTH",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "2024",
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
