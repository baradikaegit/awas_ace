import 'dart:js_interop';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FunnelingPage extends StatefulWidget {
  const FunnelingPage({super.key});
  static const String routeName = "/funnelingPage";
  @override
  State<FunnelingPage> createState() => _FunnelingPageState();
}

class _FunnelingPageState extends State<FunnelingPage> {
  Widget titleBar = const Text(
    "Funneling",
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
                            "Data Corong (TVHO)",
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
                            columnSpacing: ResponsiveValue<double>(
                              context,
                              conditionalValues: [
                                const Condition.equals(
                                    name: TABLET,
                                    value: 0.0,
                                    landscapeValue: 0.0),
                                const Condition.largerThan(
                                    name: TABLET,
                                    value: 0.0,
                                    landscapeValue: 0.0)
                              ],
                              defaultValue: 10,
                            ).value,
                            horizontalMargin: ResponsiveValue<double>(context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 5.0,
                                          landscapeValue: 5.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 5.0,
                                          landscapeValue: 5.0,
                                          breakpoint: 800)
                                    ],
                                    defaultValue: 12.0)
                                .value,
                            minWidth: ResponsiveValue<double>(context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 470.0,
                                          landscapeValue: 470.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 470.0,
                                          landscapeValue: 470.0,
                                          breakpoint: 800),
                                    ],
                                    defaultValue: 350.0)
                                .value,
                            headingRowHeight: ResponsiveValue<double>(
                              context,
                              conditionalValues: [
                                const Condition.equals(
                                    name: TABLET,
                                    value: 50.0,
                                    landscapeValue: 50.0),
                                const Condition.largerThan(
                                    name: TABLET,
                                    value: 50.0,
                                    landscapeValue: 50.0,
                                    breakpoint: 800),
                              ],
                              defaultValue: 40.0,
                            ).value,
                            columns: [
                              DataColumn2(
                                  label: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "SS",
                                      style: textStyleColorWhite,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  size: ColumnSize.L),
                              DataColumn2(
                                label: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "CALL",
                                    style: textStyleColorWhite,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataColumn2(
                                label: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "PROGRESS",
                                    style: textStyleColorWhite,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "HOT",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "SPK",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "DO",
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
