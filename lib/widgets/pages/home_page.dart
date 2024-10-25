import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/grafikprospectsalesmodel.dart';
import 'package:awas_ace/widgets/pages/menu/menu_reminder.dart';
import 'package:awas_ace/widgets/pages/menu/menu_report.dart';
import 'package:awas_ace/widgets/pages/menu/menu_setting.dart';
import 'package:awas_ace/widgets/pages/prospect_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  Widget _getWidget() {
    if (currentIndex == 1) {
      return const ReportPage();
    } else if (currentIndex == 2) {
      return const ReminderPage();
    } else if (currentIndex == 3) {
      return const SettingPage();
    }
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async {
            return await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: const Text("Info"),
                content: const Text(
                  "Apakah anda yakin ingin keluar?",
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Text("Batal"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(
                255,
                3,
                116,
                18,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(
                      255,
                      3,
                      116,
                      18,
                    ),
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'USER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
            ),
            body: _getWidget(),
            bottomNavigationBar: FlashyTabBar(
              backgroundColor: const Color.fromARGB(
                255,
                3,
                116,
                18,
              ),
              iconSize: 30,
              items: [
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.dashboard_customize,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Report',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Reminder',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              selectedIndex: currentIndex!,
              showElevation: true,
              onItemSelected: (index) => changePage(index),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List menuRoles = [
    'Call',
    'Prospect Sales',
    'Prospect dari Bengkel',
    'Target Sales',
    'Prospect UE BP',
    'Lainnya',
  ];

  List image = [
    'call.png',
    'sales.png',
    'prospekbengkel.png',
    'sales.png',
    'sales.png',
    'lainnya.png'
  ];

  List linkPage = [
    '/callPage',
    '/prospectSalesPage',
    '/',
    '/targetSalesPage',
    '/prospectUEbpPage',
    '/lainnyaPage'
  ];

  String? userName;
  String? sid;
  String? branchID;

  final String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<ListGrafikProspectSalesResponse> listGrafik = [];

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Name');
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromARGB(
            255,
            3,
            116,
            18,
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
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
                    final grafikPs = ref.watch(grafikProspectSales);

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: grafikPs.when(
                                  data: (dataGrafik) {
                                    listGrafik.clear();
                                    listGrafik.add(dataGrafik);

                                    return (dataGrafik
                                                .listGrafikProspectSales !=
                                            null)
                                        ? dataGrafik.listGrafikProspectSales!
                                                .isNotEmpty
                                            ? ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                itemCount: 1,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          30,
                                                          10,
                                                          15,
                                                          5,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Prospect Pelanggan",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ResponsiveValue(
                                                                  context,
                                                                  conditionalValues: [
                                                                    const Condition
                                                                        .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          16.5,
                                                                      landscapeValue:
                                                                          18.5,
                                                                    ),
                                                                    const Condition
                                                                        .largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          16.5,
                                                                      landscapeValue:
                                                                          16.5,
                                                                    ),
                                                                  ],
                                                                  defaultValue:
                                                                      14.5,
                                                                ).value,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          15,
                                                          10,
                                                          15,
                                                          15,
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ProspectPage(),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 30,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    74,
                                                                    49,
                                                                    49,
                                                                    49,
                                                                  ),
                                                                  blurRadius:
                                                                      5.0,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  spreadRadius:
                                                                      2.1,
                                                                ),
                                                              ],
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                15.0,
                                                              ),
                                                              color: const Color
                                                                  .fromARGB(
                                                                214,
                                                                0,
                                                                170,
                                                                28,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                0,
                                                                0,
                                                                0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 200,
                                                                    child:
                                                                        SfFunnelChart(
                                                                      selectionGesture:
                                                                          ActivationMode
                                                                              .none,
                                                                      margin: const EdgeInsets
                                                                          .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0,
                                                                      ),
                                                                      series: FunnelSeries<
                                                                          DataGrafik,
                                                                          String>(
                                                                        neckHeight:
                                                                            '0%',
                                                                        neckWidth:
                                                                            '20%',
                                                                        gapRatio:
                                                                            0.1,
                                                                        dataSource:
                                                                            toDynamic(
                                                                          listGrafik[0]
                                                                              .listGrafikProspectSales!,
                                                                        ),
                                                                        xValueMapper:
                                                                            (DataGrafik sales, _) =>
                                                                                sales.x,
                                                                        yValueMapper:
                                                                            (DataGrafik sales, _) =>
                                                                                sales.y,
                                                                        textFieldMapper:
                                                                            (DataGrafik sales, _) =>
                                                                                sales.textField,
                                                                        pointColorMapper:
                                                                            (DataGrafik sales, _) =>
                                                                                sales.color,
                                                                        selectionBehavior:
                                                                            SelectionBehavior(enable: true),
                                                                        onPointTap:
                                                                            (pointInteractionDetails) {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const ProspectPage(),
                                                                            ),
                                                                          );
                                                                        },
                                                                        dataLabelSettings:
                                                                            DataLabelSettings(
                                                                          showZeroValue:
                                                                              true,
                                                                          isVisible:
                                                                              true,
                                                                          labelAlignment:
                                                                              ChartDataLabelAlignment.middle,
                                                                          overflowMode:
                                                                              OverflowMode.trim,
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                ResponsiveValue<double>(
                                                                              context,
                                                                              conditionalValues: [
                                                                                const Condition.equals(
                                                                                  name: TABLET,
                                                                                  value: 11.5,
                                                                                  landscapeValue: 11.5,
                                                                                ),
                                                                                const Condition.largerThan(
                                                                                  name: TABLET,
                                                                                  value: 14.0,
                                                                                  landscapeValue: 14.0,
                                                                                  breakpoint: 800,
                                                                                ),
                                                                              ],
                                                                              defaultValue: 11.0,
                                                                            ).value,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      legend:
                                                                          Legend(
                                                                        toggleSeriesVisibility:
                                                                            false,
                                                                        legendItemBuilder: (String name,
                                                                            dynamic
                                                                                series,
                                                                            dynamic
                                                                                point,
                                                                            int index) {
                                                                          return Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                20,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                SizedBox(
                                                                              height: 20,
                                                                              width: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(
                                                                                    name: TABLET,
                                                                                    value: 145.0,
                                                                                    landscapeValue: 145.0,
                                                                                  ),
                                                                                  const Condition.largerThan(name: TABLET, value: 150.0, landscapeValue: 150.0, breakpoint: 800),
                                                                                ],
                                                                                defaultValue: 140.0,
                                                                              ).value,
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => const ProspectPage(),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Text(
                                                                                  point.x.toString(),
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: ResponsiveValue<double>(
                                                                                      context,
                                                                                      conditionalValues: [
                                                                                        const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                                        const Condition.largerThan(name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
                                                                                      ],
                                                                                      defaultValue: 12.0,
                                                                                    ).value,
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 2,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        overflowMode:
                                                                            LegendItemOverflowMode.none,
                                                                        isResponsive:
                                                                            true,
                                                                        isVisible:
                                                                            true,
                                                                        position:
                                                                            LegendPosition.left,
                                                                        iconHeight:
                                                                            0,
                                                                        iconWidth:
                                                                            0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      AnimationLimiter(
                                                        child: GridView.builder(
                                                          primary: false,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                ResponsiveValue<
                                                                    int>(
                                                              context,
                                                              conditionalValues: [
                                                                const Condition
                                                                    .equals(
                                                                  name: TABLET,
                                                                  value: 4,
                                                                  landscapeValue:
                                                                      4,
                                                                ),
                                                                const Condition
                                                                    .largerThan(
                                                                  name: TABLET,
                                                                  value: 4,
                                                                  landscapeValue:
                                                                      4,
                                                                  breakpoint:
                                                                      800,
                                                                ),
                                                              ],
                                                              defaultValue: 4,
                                                            ).value,
                                                            childAspectRatio:
                                                                ResponsiveValue<
                                                                    double>(
                                                              context,
                                                              conditionalValues: [
                                                                const Condition
                                                                    .equals(
                                                                  name: TABLET,
                                                                  value: 5 / 5,
                                                                  landscapeValue:
                                                                      5 / 5,
                                                                ),
                                                                const Condition
                                                                    .largerThan(
                                                                  name: TABLET,
                                                                  value: 5 / 5,
                                                                  landscapeValue:
                                                                      5 / 5,
                                                                  breakpoint:
                                                                      800,
                                                                ),
                                                              ],
                                                              defaultValue:
                                                                  5 / 6,
                                                            ).value,
                                                          ),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              menuRoles.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return AnimationConfiguration
                                                                .staggeredGrid(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1500),
                                                              position: index,
                                                              columnCount: 2,
                                                              child:
                                                                  FlipAnimation(
                                                                child: InkWell(
                                                                  onTap: () => Navigator.pushNamed(
                                                                      context,
                                                                      linkPage[
                                                                          index],
                                                                      arguments: linkPage[index] ==
                                                                              '/callPage'
                                                                          ? dateNow
                                                                          : linkPage[index] == '/prospectUEbpPage'
                                                                              ? '1'
                                                                              : null),
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      CircleAvatar(
                                                                        backgroundColor: const Color
                                                                            .fromARGB(
                                                                            0,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        radius:
                                                                            ResponsiveValue<double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                              name: TABLET,
                                                                              value: 35,
                                                                              landscapeValue: 55,
                                                                            ),
                                                                            const Condition.largerThan(
                                                                              name: TABLET,
                                                                              value: 35,
                                                                              landscapeValue: 55,
                                                                              breakpoint: 800,
                                                                            ),
                                                                            const Condition.equals(
                                                                              name: DESKTOP,
                                                                              value: 75,
                                                                              landscapeValue: 75,
                                                                            ),
                                                                            const Condition.largerThan(
                                                                              name: DESKTOP,
                                                                              value: 75,
                                                                              landscapeValue: 75,
                                                                              breakpoint: 1920,
                                                                            ),
                                                                          ],
                                                                          defaultValue:
                                                                              30,
                                                                        ).value,
                                                                        child:
                                                                            Container(
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: const [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(0, 49, 49, 49),
                                                                                blurRadius: 5.0,
                                                                                offset: Offset(0, 0),
                                                                                spreadRadius: 2.1,
                                                                              ),
                                                                            ],
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.transparent,
                                                                              width: 2,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: const Color.fromARGB(
                                                                                0,
                                                                                255,
                                                                                255,
                                                                                255),
                                                                          ),
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              0.0),
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/menu/${image[index]}',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            5,
                                                                            10,
                                                                            5,
                                                                            0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            menuRoles[index],
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: ResponsiveValue<double>(
                                                                                context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(
                                                                                    name: TABLET,
                                                                                    value: 10.5,
                                                                                    landscapeValue: 14.5,
                                                                                  ),
                                                                                  const Condition.largerThan(
                                                                                    name: TABLET,
                                                                                    value: 10.5,
                                                                                    landscapeValue: 14.5,
                                                                                  ),
                                                                                ],
                                                                                defaultValue: 10.0,
                                                                              ).value,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            maxLines:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
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
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            // ListView(
            //   padding: const EdgeInsets.only(top: 10.0),
            //   children: [
            //     _buildComplexMarquee(),
            //   ].map(_wrapWithStuff).toList(),
            // ),
          ),
          floatingActionButton: FloatingActionButton(
            hoverColor: Colors.blue,
            backgroundColor: const Color.fromARGB(
              255,
              3,
              116,
              18,
            ),
            tooltip: 'Prospect Pelanggan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProspectPage(),
                ),
              );
            },
            child: const Icon(
              Icons.add_business,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildComplexMarquee() {
  //   return Marquee(
  //     text:
  //         'Buat Pelanggan Anda Happy & Loyal dan Dapatkan Referensi dari Mereka.',
  //     style: TextStyle(
  //       fontSize: ResponsiveValue<double>(
  //         context,
  //         conditionalValues: [
  //           const Condition.equals(
  //             name: TABLET,
  //             value: 17.0,
  //             landscapeValue: 17.0,
  //           ),
  //           const Condition.largerThan(
  //             name: TABLET,
  //             value: 17.0,
  //             landscapeValue: 17.0,
  //             breakpoint: 800,
  //           ),
  //         ],
  //         defaultValue: 12.5,
  //       ).value,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.blue,
  //     ),
  //     scrollAxis: Axis.horizontal,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     blankSpace: 20.0,
  //     velocity: 100.0,
  //     pauseAfterRound: const Duration(seconds: 1),
  //     showFadingOnlyWhenScrolling: true,
  //     fadingEdgeStartFraction: 0.1,
  //     fadingEdgeEndFraction: 0.1,
  //     numberOfRounds: null,
  //     startPadding: 10.0,
  //     accelerationDuration: const Duration(seconds: 2),
  //     accelerationCurve: Curves.linear,
  //     decelerationDuration: const Duration(milliseconds: 1000),
  //     decelerationCurve: Curves.easeOut,
  //   );
  // }

  // Styling the Marquee
  // Widget _wrapWithStuff(Widget child) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "Prospect Pelanggan",
  //                 style: TextStyle(
  //                   fontSize: ResponsiveValue(
  //                     context,
  //                     conditionalValues: [
  //                       const Condition.equals(
  //                         name: TABLET,
  //                         value: 16.5,
  //                         landscapeValue: 18.5,
  //                       ),
  //                       const Condition.largerThan(
  //                         name: TABLET,
  //                         value: 16.5,
  //                         landscapeValue: 16.5,
  //                       ),
  //                     ],
  //                     defaultValue: 14.5,
  //                   ).value,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
  //           child: Container(
  //             constraints: const BoxConstraints(
  //               minHeight: 230,
  //               minWidth: double.infinity,
  //             ),
  //             decoration: BoxDecoration(
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Color.fromARGB(74, 49, 49, 49),
  //                   blurRadius: 5.0,
  //                   offset: Offset(0, 0),
  //                   spreadRadius: 2.1,
  //                 ),
  //               ],
  //               border: Border.all(
  //                 color: Colors.transparent,
  //                 width: 2,
  //               ),
  //               borderRadius: BorderRadius.circular(15.0),
  //               color: const Color(0xFF00AA80),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
  //               child: Column(
  //                 children: [
  //                   SizedBox(
  //                     height: 230,
  //                     child: SfFunnelChart(
  //                       series: FunnelSeries<SalesData, String>(
  //                         neckHeight: '0%',
  //                         neckWidth: '20%',
  //                         gapRatio: 0.1,
  //                         dataSource: getColumnData(),
  //                         xValueMapper: (SalesData sales, _) => sales.x,
  //                         yValueMapper: (SalesData sales, _) => sales.y,
  //                         textFieldMapper: (SalesData sales, _) =>
  //                             sales.textField,
  //                         selectionBehavior: SelectionBehavior(enable: true),
  //                         onPointTap: (pointInteractionDetails) {
  //                           // Navigator.push(
  //                           //   context,
  //                           //   MaterialPageRoute(
  //                           //     builder: (context) => DetailPage(),
  //                           //   ),
  //                           // );
  //                         },
  //                         // untuk menampilkan label pada grafik
  //                         dataLabelSettings: const DataLabelSettings(
  //                           showZeroValue: true,
  //                           isVisible: true,
  //                           labelAlignment: ChartDataLabelAlignment.middle,
  //                           overflowMode: OverflowMode.trim,
  //                         ),
  //                       ),
  //                       legend: Legend(
  //                         isVisible: true,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Container(
  //             height: 20.0,
  //             color: Colors.white,
  //             child: child,
  //           ),
  //         ),
  //         AnimationLimiter(
  //           child: GridView.builder(
  //             primary: false,
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: ResponsiveValue<int>(
  //                 context,
  //                 conditionalValues: [
  //                   const Condition.equals(
  //                     name: TABLET,
  //                     value: 4,
  //                     landscapeValue: 4,
  //                   ),
  //                   const Condition.largerThan(
  //                     name: TABLET,
  //                     value: 4,
  //                     landscapeValue: 4,
  //                     breakpoint: 800,
  //                   ),
  //                 ],
  //                 defaultValue: 4,
  //               ).value,
  //               childAspectRatio: ResponsiveValue<double>(
  //                 context,
  //                 conditionalValues: [
  //                   const Condition.equals(
  //                     name: TABLET,
  //                     value: 5 / 5,
  //                     landscapeValue: 5 / 5,
  //                   ),
  //                   const Condition.largerThan(
  //                     name: TABLET,
  //                     value: 5 / 5,
  //                     landscapeValue: 5 / 5,
  //                     breakpoint: 800,
  //                   ),
  //                 ],
  //                 defaultValue: 5 / 6,
  //               ).value,
  //             ),
  //             shrinkWrap: true,
  //             itemCount: menuRoles.length,
  //             itemBuilder: (context, index) {
  //               return AnimationConfiguration.staggeredGrid(
  //                 duration: const Duration(milliseconds: 1500),
  //                 position: index,
  //                 columnCount: 2,
  //                 child: FlipAnimation(
  //                   child: InkWell(
  //                     onTap: () =>
  //                         Navigator.pushNamed(context, linkPage[index]),
  //                     child: Column(
  //                       children: <Widget>[
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         CircleAvatar(
  //                           backgroundColor:
  //                               const Color.fromARGB(0, 255, 255, 255),
  //                           radius: ResponsiveValue<double>(
  //                             context,
  //                             conditionalValues: [
  //                               const Condition.equals(
  //                                 name: TABLET,
  //                                 value: 35,
  //                                 landscapeValue: 55,
  //                               ),
  //                               const Condition.largerThan(
  //                                 name: TABLET,
  //                                 value: 35,
  //                                 landscapeValue: 55,
  //                                 breakpoint: 800,
  //                               ),
  //                               const Condition.equals(
  //                                 name: DESKTOP,
  //                                 value: 75,
  //                                 landscapeValue: 75,
  //                               ),
  //                               const Condition.largerThan(
  //                                 name: DESKTOP,
  //                                 value: 75,
  //                                 landscapeValue: 75,
  //                                 breakpoint: 1920,
  //                               ),
  //                             ],
  //                             defaultValue: 30,
  //                           ).value,
  //                           child: Container(
  //                             clipBehavior: Clip.antiAlias,
  //                             decoration: BoxDecoration(
  //                               boxShadow: const [
  //                                 BoxShadow(
  //                                   color: Color.fromARGB(0, 49, 49, 49),
  //                                   blurRadius: 5.0,
  //                                   offset: Offset(0, 0),
  //                                   spreadRadius: 2.1,
  //                                 ),
  //                               ],
  //                               border: Border.all(
  //                                 color: Colors.transparent,
  //                                 width: 2,
  //                               ),
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: const Color.fromARGB(0, 255, 255, 255),
  //                             ),
  //                             padding: const EdgeInsets.all(0.0),
  //                             child: Image.asset(
  //                               'assets/images/menu/${image[index]}',
  //                               fit: BoxFit.fill,
  //                             ),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
  //                           child: Center(
  //                             child: Text(
  //                               menuRoles[index],
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontSize: ResponsiveValue<double>(
  //                                   context,
  //                                   conditionalValues: [
  //                                     const Condition.equals(
  //                                       name: TABLET,
  //                                       value: 10.5,
  //                                       landscapeValue: 14.5,
  //                                     ),
  //                                     const Condition.largerThan(
  //                                       name: TABLET,
  //                                       value: 10.5,
  //                                       landscapeValue: 14.5,
  //                                     ),
  //                                   ],
  //                                   defaultValue: 10.0,
  //                                 ).value,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                               maxLines: 2,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class DataGrafik {
  String x;
  int y;
  String textField;
  Color color;

  DataGrafik(this.x, this.y, this.textField, this.color);
}

dynamic toDynamic(List<ListGrafikProspectSales> objList) {
  List<DataGrafik> funData = <DataGrafik>[
    DataGrafik(
      "Call (Today/MTD)",
      50,
      "${objList[3].today}/${objList[3].monthToDate}", //dataDO
      const Color.fromARGB(255, 230, 30, 30),
    ),
    DataGrafik(
      "Prospect (Today/MTD)",
      50,
      "${objList[2].today}/${objList[2].monthToDate}", //dataSpk
      const Color.fromARGB(255, 255, 183, 29),
    ),
    DataGrafik(
      "SPK (Today/MTD)",
      50,
      "${objList[1].today}/${objList[1].monthToDate}", //dataProspect
      const Color.fromARGB(255, 84, 84, 102),
    ),
    DataGrafik(
      "DO (Today/MTD)",
      50,
      "${objList[0].today}/${objList[0].monthToDate}", // dataCall
      const Color.fromARGB(255, 1, 185, 124),
    ),
  ];

  // List<DataGrafik> funData = [];

  // for (var i = 1; i < objList.length + 1; i++) {
  //   funData.add(
  //     DataGrafik(
  //       objList[objList.length - i].header,
  //       50,
  //       "${objList[objList.length - i].today}/${objList[objList.length - i].monthToDate}",
  //     ),
  //   );
  // }
  return funData;
}


// class SalesData {
//   String x;
//   double y;
//   String textField;

//   SalesData(this.x, this.y, this.textField);
// }

// // isi dari grafik
// dynamic getColumnData() {
//   List<SalesData> columnData = <SalesData>[
//     SalesData("Toyota", 654, "0/654"),
//     SalesData("Daihatsu", 575, "0/575"),
//     SalesData("Isuzu", 446, "0/446"),
//     SalesData("Honda", 341, "0/341"),
//     SalesData("Mitsubishi", 296, "0/296"),
//   ];
//   return columnData;
// }
