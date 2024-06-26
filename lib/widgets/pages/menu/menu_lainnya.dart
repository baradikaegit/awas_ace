import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({super.key});
  static const String routeName = "/lainnyaPage";

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 500,
              child: SfFunnelChart(
                title: ChartTitle(
                  text: "Car sales",
                ),
                series: FunnelSeries<SalesData, String>(
                  neckHeight: '0%',
                  neckWidth: '20%',
                  gapRatio: 0.1,
                  //label nama legend
                  name: "Cars",
                  dataSource: getColumnData(),
                  xValueMapper: (SalesData sales, _) => sales.x,
                  yValueMapper: (SalesData sales, _) => sales.y,
                  textFieldMapper: (SalesData sales, _) => sales.textField,

                  // selectionBehavior: SelectionBehavior(enable: true),
                  // onPointTap: (pointInteractionDetails) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => DetailPage(),
                  //     ),
                  //   );
                  // },

                  // untuk menampilkan label pada grafik
                  dataLabelSettings: const DataLabelSettings(
                    showZeroValue: true,
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.middle,
                    overflowMode: OverflowMode.trim,
                  ),
                ),
                legend: Legend(
                  isVisible: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  String x;
  double y;
  String textField;

  SalesData(this.x, this.y, this.textField);
}

// isi dari grafik
dynamic getColumnData() {
  List<SalesData> columnData = <SalesData>[
    SalesData("Toyota", 654, "0/654"),
    SalesData("Daihatsu", 575, "0/575"),
    SalesData("Isuzu", 446, "0/446"),
    SalesData("Honda", 341, "0/341"),
    SalesData("Mitsubishi", 296, "0/296"),
  ];
  return columnData;
}
