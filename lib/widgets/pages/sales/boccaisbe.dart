import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BocCaiSBEPage extends StatefulWidget {
  const BocCaiSBEPage({super.key});
  static const String routeName = "/bocCaiSBEPage";
  @override
  State<BocCaiSBEPage> createState() => _BocCaiSBEPageState();
}

class _BocCaiSBEPageState extends State<BocCaiSBEPage> {
  Widget titleBar = const Text(
    "BOC & CAI SBE By Sales",
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

    var contacted = 50;

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
                            "BOC & CAI (TVHO)",
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
                      SizedBox(
                        height: 200,
                        width: 220,
                        child: SfRadialGauge(
                          // title: const GaugeTitle(
                          //   alignment: GaugeAlignment.center,
                          //   text: 'Speedometer',
                          //   textStyle: TextStyle(
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //     decoration: TextDecoration.underline,
                          //   ),
                          // ),
                          enableLoadingAnimation: true,
                          animationDuration: 4500,
                          axes: <RadialAxis>[
                            RadialAxis(
                              axisLineStyle: const AxisLineStyle(
                                thicknessUnit: GaugeSizeUnit.factor,
                                thickness: 0.08,
                              ),
                              majorTickStyle: MajorTickStyle(
                                length: 8,
                                thickness: 2,
                                color:
                                    contacted == 50 ? Colors.red : Colors.blue,
                              ),
                              minorTickStyle: const MinorTickStyle(
                                length: 4,
                                thickness: 2,
                                color: Colors.white,
                              ),
                              axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              //onLabelCreated: labelCreated,
                              // labelFormat: "DATA",
                              //axisLabelStyle: GaugeTextStyle(),
                              labelsPosition: ElementsPosition.inside,
                              useRangeColorForAxis: true,
                              minimum: 0,
                              maximum: 100,
                              interval: 25.0,
                              labelOffset: 15,
                              showLastLabel: true,

                              ranges: <GaugeRange>[
                                GaugeRange(
                                  startWidth: 6,
                                  endWidth: 6,
                                  startValue: 0,
                                  endValue: 20,
                                  color: const Color.fromARGB(255, 0, 211, 165),
                                ),
                                GaugeRange(
                                  startWidth: 6,
                                  endWidth: 6,
                                  startValue: 20,
                                  endValue: 40,
                                  color: const Color.fromARGB(255, 0, 148, 116),
                                ),
                                GaugeRange(
                                  startWidth: 6,
                                  endWidth: 6,
                                  startValue: 40,
                                  endValue: 60,
                                  color:
                                      const Color.fromARGB(255, 245, 206, 101),
                                ),
                                GaugeRange(
                                  startWidth: 6,
                                  endWidth: 6,
                                  startValue: 60,
                                  endValue: 80,
                                  color: const Color.fromARGB(255, 247, 182, 3),
                                ),
                                GaugeRange(
                                  startWidth: 6,
                                  endWidth: 6,
                                  startValue: 80,
                                  endValue: 100,
                                  color: Colors.red,
                                ),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: 50,
                                  needleLength: 0.95,
                                  enableAnimation: true,
                                  animationType: AnimationType.ease,
                                  needleStartWidth: 0.3,
                                  needleEndWidth: 6,
                                  needleColor: contacted == 50
                                      ? const Color.fromARGB(255, 245, 206, 101)
                                      : Colors.red,
                                  knobStyle: KnobStyle(
                                    knobRadius: 0.1,
                                    color: contacted == 50
                                        ? const Color.fromARGB(
                                            255, 245, 206, 101)
                                        : Colors.red,
                                  ),
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: const TextSpan(
                                          text: 'Contacted \n',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 80, 0, 0),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '50%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  positionFactor: 0.4,
                                  angle: 90,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 220,
                            child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 4500,
                              axes: <RadialAxis>[
                                RadialAxis(
                                  axisLineStyle: const AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    thickness: 0.08,
                                  ),
                                  majorTickStyle: const MajorTickStyle(
                                    length: 8,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  minorTickStyle: const MinorTickStyle(
                                    length: 4,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  axisLabelStyle: const GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  labelsPosition: ElementsPosition.inside,
                                  useRangeColorForAxis: true,
                                  minimum: 0,
                                  maximum: 100,
                                  interval: 25.0,
                                  labelOffset: 15,
                                  showLastLabel: true,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 0,
                                      endValue: 20,
                                      color: const Color.fromARGB(
                                          255, 0, 211, 165),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 20,
                                      endValue: 40,
                                      color: const Color.fromARGB(
                                          255, 0, 148, 116),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 40,
                                      endValue: 60,
                                      color: const Color.fromARGB(
                                          255, 245, 206, 101),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 60,
                                      endValue: 80,
                                      color: const Color.fromARGB(
                                          255, 247, 182, 3),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 80,
                                      endValue: 100,
                                      color: Colors.red,
                                    ),
                                  ],
                                  pointers: const <GaugePointer>[
                                    NeedlePointer(
                                      value: 70,
                                      needleLength: 0.95,
                                      enableAnimation: true,
                                      animationType: AnimationType.ease,
                                      needleStartWidth: 0.3,
                                      needleEndWidth: 6,
                                      needleColor: 75 == 75
                                          ? Color.fromARGB(255, 247, 182, 3)
                                          : Colors.red,
                                      knobStyle: KnobStyle(
                                        knobRadius: 0.1,
                                        color: 75 == 75
                                            ? Color.fromARGB(255, 247, 182, 3)
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: const TextSpan(
                                              text: 'BOC \n',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 80, 0, 0),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '70%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      positionFactor: 0.4,
                                      angle: 90,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            width: 220,
                            child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 4500,
                              axes: <RadialAxis>[
                                RadialAxis(
                                  axisLineStyle: const AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    thickness: 0.08,
                                  ),
                                  majorTickStyle: const MajorTickStyle(
                                    length: 8,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  minorTickStyle: const MinorTickStyle(
                                    length: 4,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  axisLabelStyle: const GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  //onLabelCreated: labelCreated,
                                  // labelFormat: "DATA",
                                  //axisLabelStyle: GaugeTextStyle(),
                                  labelsPosition: ElementsPosition.inside,
                                  useRangeColorForAxis: true,
                                  minimum: 0,
                                  maximum: 100,
                                  interval: 25.0,
                                  labelOffset: 15,
                                  showLastLabel: true,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 0,
                                      endValue: 20,
                                      color: const Color.fromARGB(
                                          255, 0, 211, 165),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 20,
                                      endValue: 40,
                                      color: const Color.fromARGB(
                                          255, 0, 148, 116),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 40,
                                      endValue: 60,
                                      color: const Color.fromARGB(
                                          255, 245, 206, 101),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 60,
                                      endValue: 80,
                                      color: const Color.fromARGB(
                                          255, 247, 182, 3),
                                    ),
                                    GaugeRange(
                                      startWidth: 6,
                                      endWidth: 6,
                                      startValue: 80,
                                      endValue: 100,
                                      color: Colors.red,
                                    ),
                                  ],
                                  pointers: const <GaugePointer>[
                                    NeedlePointer(
                                      value: 0,
                                      needleLength: 0.95,
                                      enableAnimation: true,
                                      animationType: AnimationType.ease,
                                      needleStartWidth: 0.3,
                                      needleEndWidth: 6,
                                      needleColor: 0 == 0
                                          ? Color.fromARGB(255, 0, 211, 165)
                                          : Colors.red,
                                      knobStyle: KnobStyle(
                                        knobRadius: 0.1,
                                        color: 0 == 0
                                            ? Color.fromARGB(255, 0, 211, 165)
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: const TextSpan(
                                              text: 'CAI \n',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 80, 0, 0),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '0%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      positionFactor: 0.4,
                                      angle: 90,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
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
                            columnSpacing: ResponsiveValue<double>(context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 5,
                                          landscapeValue: 5),
                                      const Condition.largerThan(
                                        name: TABLET,
                                        value: 5,
                                        landscapeValue: 5,
                                        breakpoint: 800,
                                      )
                                    ],
                                    defaultValue: 10)
                                .value,
                            horizontalMargin: 5,
                            minWidth: 350,
                            headingRowHeight: 40.0,
                            columns: [
                              DataColumn2(
                                label: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "CABANG",
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
                                  "DATA",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "CONTACTED",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "BOC",
                                  style: textStyleColorWhite,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              DataColumn2(
                                  label: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "CAI",
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
    SalesData("Isuzu", 446),
    SalesData("Honda", 341),
  ];
  return columnData;
}
