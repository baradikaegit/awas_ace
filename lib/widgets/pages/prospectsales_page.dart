// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/widgets/model/prospectsalesmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspectSalesPage extends ConsumerStatefulWidget {
  const ProspectSalesPage({super.key});

  static const String routeName = "/prospectSalesPage";

  @override
  _ProspectSalesPageState createState() => _ProspectSalesPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ProspectSalesPageState extends ConsumerState<ProspectSalesPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late TabController _tabController;

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? sid;
  String? branchID;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    loadSharedPreference();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Username');
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
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
      fontWeight: FontWeight.bold,
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Prospect Sales",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: const Color.fromARGB(
              255,
              3,
              116,
              18,
            ),
          ),
          backgroundColor: const Color.fromARGB(
            255,
            134,
            206,
            68,
          ),
          body: Center(
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final rptProspectSales = ref.watch(prospectSales);

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                      prospectSales,
                                    );
                                  },
                                  child: rptProspectSales.when(
                                    data: (dataProspectSales) {
                                      return ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              ResponsiveRowColumnItem(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: ResponsiveValue<
                                                          double>(
                                                        context,
                                                        conditionalValues: [
                                                          const Condition
                                                              .largerThan(
                                                            name: TABLET,
                                                            value: 20.0,
                                                            landscapeValue:
                                                                20.0,
                                                            breakpoint: 500,
                                                          ),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 32.0,
                                                              landscapeValue:
                                                                  32.0,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 19,
                                                      ).value,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.orange[400],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenWidth * 0.96,
                                                      height: 35,
                                                      decoration:
                                                          const BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                40, 208, 37),
                                                            Color.fromARGB(255,
                                                                106, 185, 44),
                                                            Color.fromARGB(255,
                                                                175, 231, 44),
                                                          ],
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "ON PROGRESS",
                                                          style:
                                                              textStyleColorWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.green[700],
                                                child: Column(
                                                  children: [
                                                    TabBar(
                                                      controller:
                                                          _tabController,
                                                      dividerHeight: 0,
                                                      indicatorColor:
                                                          Colors.orange,
                                                      labelColor: Colors.white,
                                                      unselectedLabelColor:
                                                          Colors.white70,
                                                      isScrollable: false,
                                                      indicatorPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 0,
                                                      ),
                                                      labelPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 0,
                                                      ),
                                                      tabs: [
                                                        for (int i = 0;
                                                            i < 3;
                                                            i++)
                                                          dataProspectSales
                                                                      .listProspectSales![
                                                                          i]
                                                                      .prospectStatusName ==
                                                                  'HOT'
                                                              ? _customTab(
                                                                  dataProspectSales
                                                                      .listProspectSales![
                                                                          i]
                                                                      .prospectStatus,
                                                                  " \nPELANGGAN \nHOT \nPROSPECT",
                                                                  const Color
                                                                      .fromARGB(
                                                                    255,
                                                                    40,
                                                                    208,
                                                                    37,
                                                                  ),
                                                                )
                                                              : dataProspectSales
                                                                          .listProspectSales![
                                                                              i]
                                                                          .prospectStatusName ==
                                                                      'MEDIUM'
                                                                  ? _customTab(
                                                                      dataProspectSales
                                                                          .listProspectSales![
                                                                              i]
                                                                          .prospectStatus,
                                                                      " \nPELANGGAN \nMEDIUM \nPROSPECT",
                                                                      const Color
                                                                          .fromARGB(
                                                                        255,
                                                                        106,
                                                                        185,
                                                                        44,
                                                                      ),
                                                                    )
                                                                  : _customTab(
                                                                      dataProspectSales
                                                                          .listProspectSales![
                                                                              i]
                                                                          .prospectStatus,
                                                                      " \nPELANGGAN \nLOW \nPROSPECT",
                                                                      const Color
                                                                          .fromARGB(
                                                                        255,
                                                                        175,
                                                                        231,
                                                                        44,
                                                                      ),
                                                                    ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    Scaffold.of(context)
                                                        .appBarMaxHeight! -
                                                    kToolbarHeight -
                                                    16,
                                                child: TabBarView(
                                                  controller: _tabController,
                                                  children: const <Widget>[
                                                    HotProspectTab(),

                                                    // MediumProspectTab(),
                                                    Center(
                                                      child: Text("data"),
                                                    ),
                                                    Center(
                                                      child: Text("data1"),
                                                    ),
                                                    // LowProspectTab(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
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
      ),
    );
  }

  Widget _customTab(String labelH, String label, Color backgroundColor) {
    return SizedBox(
      height: 150,
      child: Tab(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: labelH,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            //  Text(
            //   textAlign: TextAlign.center,
            //   label,
            //   style: const TextStyle(
            //     fontSize: 12,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   maxLines: 3,
            // ),
          ),
        ),
      ),
    );
  }
}

class HotProspectTab extends StatefulWidget {
  const HotProspectTab({super.key});

  @override
  State<HotProspectTab> createState() => _HotProspectTabState();
}

class _HotProspectTabState extends State<HotProspectTab> {
  List<ProspectSalesListResponse> listProspectSalesRes = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final rptProspectSalesGrafik = ref.watch(prospectSales);
        return Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: rptProspectSalesGrafik.when(
                      data: (dataGrafik) {
                        listProspectSalesRes.clear();
                        listProspectSalesRes.add(dataGrafik);

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    50,
                                    0,
                                  ),
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Text(
                                          textAlign: TextAlign.center,
                                          "4 \nPROSPECT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 25.0,
                                                    landscapeValue: 25.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 10.0,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    legend: Legend(
                                      isVisible: true,
                                      width: '300%',
                                      itemPadding: 0,
                                      position: LegendPosition.right,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll,
                                      textStyle:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: toDynamic(
                                            listProspectSalesRes[0]
                                                .listProspectSales!),
                                        legendIconType:
                                            LegendIconType.rectangle,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) => data
                                                    .x ==
                                                'Comunnity'
                                            ? data.colorCommunity
                                            : data.x == 'Walk In Customer'
                                                ? data.colorWalkIn
                                                : data.x == 'Mobile/Canvasing'
                                                    ? data.colorMobileCanvasing
                                                    : data.x == 'Reference'
                                                        ? data.colorReference
                                                        : data.x ==
                                                                'Moving Exhibition'
                                                            ? data.colorMovingEx
                                                            : data.x ==
                                                                    'Call In'
                                                                ? data
                                                                    .colorCallin
                                                                : data.x ==
                                                                        'Database'
                                                                    ? data
                                                                        .colorDatabase
                                                                    : data.x ==
                                                                            'Iklan & Media Sosial'
                                                                        ? data
                                                                            .colorIklanMedia
                                                                        : data.x ==
                                                                                'Repeat Order Retail'
                                                                            ? data.colorRepeatOrderRetail
                                                                            : data.colorRepeatOrderFleet,
                                        innerRadius: '60%',
                                        radius: '70%',
                                        explode: true,
                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          showZeroValue: false,
                                          isVisible: true,
                                          labelAlignment:
                                              ChartDataLabelAlignment.middle,
                                          overflowMode: OverflowMode.trim,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      error: (err, stack) => Text('Error $err'),
                      loading: () => const Center(
                        child: Column(
                          children: [loadingAnimation()],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// class MediumProspectTab extends StatelessWidget {
//   const MediumProspectTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromARGB(255, 134, 206, 68),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                           ),
//                           child: SfCircularChart(
//                             tooltipBehavior: TooltipBehavior(
//                               enable: true,
//                             ),
//                             annotations: [
//                               CircularChartAnnotation(
//                                 widget: Text(
//                                   textAlign: TextAlign.center,
//                                   "4 \nPROSPECT",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: ResponsiveValue<double>(
//                                       context,
//                                       conditionalValues: [
//                                         const Condition.equals(
//                                             name: TABLET,
//                                             value: 12.0,
//                                             landscapeValue: 12.0),
//                                         const Condition.largerThan(
//                                             name: TABLET,
//                                             value: 25.0,
//                                             landscapeValue: 25.0,
//                                             breakpoint: 800),
//                                       ],
//                                       defaultValue: 10.0,
//                                     ).value,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             legend: Legend(isVisible: true),
//                             series: <CircularSeries>[
//                               DoughnutSeries<ChartData, String>(
//                                 dataSource: chartData,
//                                 legendIconType: LegendIconType.rectangle,
//                                 xValueMapper: (ChartData data, _) => data.x,
//                                 yValueMapper: (ChartData data, _) => data.y,
//                                 pointColorMapper: (ChartData data, _) =>
//                                     data.color,
//                                 innerRadius: '60%',
//                                 radius: '110%',
//                                 explode: true,
//                                 explodeGesture: ActivationMode.singleTap,
//                                 explodeOffset: '5',
//                                 dataLabelSettings: const DataLabelSettings(
//                                   showZeroValue: false,
//                                   isVisible: true,
//                                   labelAlignment:
//                                       ChartDataLabelAlignment.middle,
//                                   overflowMode: OverflowMode.trim,
//                                   textStyle: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LowProspectTab extends StatelessWidget {
//   const LowProspectTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromARGB(255, 134, 206, 68),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                           ),
//                           child: SfCircularChart(
//                             tooltipBehavior: TooltipBehavior(
//                               enable: true,
//                             ),
//                             annotations: [
//                               CircularChartAnnotation(
//                                 widget: Text(
//                                   textAlign: TextAlign.center,
//                                   "4 \nPROSPECT",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: ResponsiveValue<double>(
//                                       context,
//                                       conditionalValues: [
//                                         const Condition.equals(
//                                             name: TABLET,
//                                             value: 12.0,
//                                             landscapeValue: 12.0),
//                                         const Condition.largerThan(
//                                             name: TABLET,
//                                             value: 25.0,
//                                             landscapeValue: 25.0,
//                                             breakpoint: 800),
//                                       ],
//                                       defaultValue: 10.0,
//                                     ).value,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             legend: Legend(isVisible: true),
//                             series: <CircularSeries>[
//                               DoughnutSeries<ChartData, String>(
//                                 dataSource: chartData,
//                                 legendIconType: LegendIconType.rectangle,
//                                 xValueMapper: (ChartData data, _) => data.x,
//                                 yValueMapper: (ChartData data, _) => data.y,
//                                 pointColorMapper: (ChartData data, _) =>
//                                     data.color,
//                                 innerRadius: '60%',
//                                 radius: '110%',
//                                 explode: true,
//                                 explodeGesture: ActivationMode.singleTap,
//                                 explodeOffset: '5',
//                                 dataLabelSettings: const DataLabelSettings(
//                                   showZeroValue: false,
//                                   isVisible: true,
//                                   labelAlignment:
//                                       ChartDataLabelAlignment.middle,
//                                   overflowMode: OverflowMode.trim,
//                                   textStyle: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ChartData {
  String x;
  int y;
  Color colorCommunity;
  Color colorWalkIn;
  Color colorMobileCanvasing;
  Color colorReference;
  Color colorMovingEx;
  Color colorCallin;
  Color colorDatabase;
  Color colorIklanMedia;
  Color colorRepeatOrderRetail;
  Color colorRepeatOrderFleet;

  ChartData(
    this.x,
    this.y,
    this.colorCommunity,
    this.colorWalkIn,
    this.colorMobileCanvasing,
    this.colorReference,
    this.colorMovingEx,
    this.colorCallin,
    this.colorDatabase,
    this.colorIklanMedia,
    this.colorRepeatOrderRetail,
    this.colorRepeatOrderFleet,
  );
}

dynamic toDynamic(List<ListProspectSales> objList) {
  List<ChartData> doughnutData = [];

  for (var i = 1; i < objList.length + 1; i++) {
    if (objList[objList.length - i].type == 'Grafik') {
      doughnutData.add(
        ChartData(
          objList[objList.length - i].referensi,
          int.parse(objList[objList.length - i].prospectStatus),
          const Color.fromARGB(183, 84, 0, 92),
          const Color.fromARGB(185, 255, 238, 2),
          const Color.fromARGB(192, 241, 144, 15),
          const Color.fromARGB(192, 0, 119, 83),
          const Color.fromARGB(192, 77, 159, 192),
          const Color.fromARGB(184, 131, 122, 1),
          const Color.fromARGB(184, 25, 26, 41),
          const Color.fromARGB(184, 255, 0, 0),
          const Color.fromARGB(184, 255, 255, 255),
          const Color.fromARGB(184, 156, 146, 146),
        ),
      );
    }
  }
  return doughnutData;
}

// final List<ChartData> chartData = [
//   ChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
//   ChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
//   ChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
//   ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
// ];
