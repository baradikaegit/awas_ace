import 'package:awas_ace/widgets/main_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
      return const HistoryScreen();
    } else if (currentIndex == 2) {
      return const FolderScreen();
    } else if (currentIndex == 3) {
      return const GalleryScreen();
    }
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          1,
          209,
          29,
        ),
        title: const Text('HOME'),
      ),
      body: _getWidget(),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: const Color.fromARGB(
          255,
          1,
          209,
          29,
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
    'Call (Today/MTD)',
    'Prospect (Today/MTD)',
    'SPK (Today/MTD)',
    'DO (Today/MTD)',
    'Lainnya',
  ];

  List image = ['call.png', 'prospect.png', 'Spk.png', 'do.png', 'lainnya.png'];

  List linkPage = ['/', '/', '/', '/', '/lainnyaPage'];

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MainPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                  ),
                  child: const Text("Ok"),
                ),
              ],
            ),
          ) ??
          false;
    }

    return Stack(
      children: [
        WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.only(top: 15.0),
              children: [
                _buildComplexMarquee(),
              ].map(_wrapWithStuff).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              hoverColor: Colors.blue,
              backgroundColor: const Color.fromARGB(255, 1, 209, 29),
              tooltip: 'Prospect Pelanggan',
              onPressed: () {},
              child: const Icon(
                Icons.add_business,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplexMarquee() {
    return Marquee(
      text:
          'Buat Pelanggan Anda Happy & Loyal dan Dapatkan Referensi dari Mereka.',
      style: TextStyle(
        fontSize: ResponsiveValue<double>(
          context,
          conditionalValues: [
            const Condition.equals(
              name: TABLET,
              value: 17.0,
              landscapeValue: 17.0,
            ),
            const Condition.largerThan(
              name: TABLET,
              value: 17.0,
              landscapeValue: 17.0,
              breakpoint: 800,
            ),
          ],
          defaultValue: 12.5,
        ).value,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: const Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: null,
      startPadding: 10.0,
      accelerationDuration: const Duration(seconds: 2),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 1000),
      decelerationCurve: Curves.easeOut,
    );
  }

  // Styling the Marquee
  Widget _wrapWithStuff(Widget child) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prospect Pelanggan",
                  style: TextStyle(
                    fontSize: ResponsiveValue(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                          name: TABLET,
                          value: 16.5,
                          landscapeValue: 18.5,
                        ),
                        const Condition.largerThan(
                          name: TABLET,
                          value: 16.5,
                          landscapeValue: 16.5,
                        ),
                      ],
                      defaultValue: 14.5,
                    ).value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                    color: Color.fromARGB(74, 49, 49, 49),
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
                color: const Color(0xFF00AA80),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 230,
                      child: SfFunnelChart(
                        series: FunnelSeries<SalesData, String>(
                          neckHeight: '0%',
                          neckWidth: '20%',
                          gapRatio: 0.1,

                          dataSource: getColumnData(),
                          xValueMapper: (SalesData sales, _) => sales.x,
                          yValueMapper: (SalesData sales, _) => sales.y,
                          textFieldMapper: (SalesData sales, _) =>
                              sales.textField,

                          selectionBehavior: SelectionBehavior(enable: true),
                          onPointTap: (pointInteractionDetails) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailPage(),
                            //   ),
                            // );
                          },

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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 20.0,
              color: Colors.white,
              child: child,
            ),
          ),
          AnimationLimiter(
            child: GridView.builder(
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveValue<int>(
                  context,
                  conditionalValues: [
                    const Condition.equals(
                      name: TABLET,
                      value: 4,
                      landscapeValue: 4,
                    ),
                    const Condition.largerThan(
                      name: TABLET,
                      value: 4,
                      landscapeValue: 4,
                      breakpoint: 800,
                    ),
                  ],
                  defaultValue: 4,
                ).value,
                childAspectRatio: 4 / 5,
              ),
              shrinkWrap: true,
              itemCount: menuRoles.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  duration: const Duration(milliseconds: 1500),
                  position: index,
                  columnCount: 2,
                  child: FlipAnimation(
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, linkPage[index]),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            radius: ResponsiveValue<double>(
                              context,
                              conditionalValues: [
                                const Condition.equals(
                                  name: TABLET,
                                  value: 45,
                                  landscapeValue: 65,
                                ),
                                const Condition.largerThan(
                                  name: TABLET,
                                  value: 45,
                                  landscapeValue: 65,
                                  breakpoint: 800,
                                ),
                                const Condition.equals(
                                  name: DESKTOP,
                                  value: 85,
                                  landscapeValue: 85,
                                ),
                                const Condition.largerThan(
                                  name: DESKTOP,
                                  value: 85,
                                  landscapeValue: 85,
                                  breakpoint: 1920,
                                ),
                              ],
                              defaultValue: 35,
                            ).value,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(74, 49, 49, 49),
                                    blurRadius: 5.0,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2.1,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(242, 255, 255, 255),
                              ),
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'assets/images/menu/${image[index]}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Center(
                              child: Text(
                                menuRoles[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                                maxLines: 2,
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

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.deepPurple[100],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            size: 50,
          ),
          Text('History Screen')
        ],
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.green[200],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 50,
            ),
            Text('Image Screen')
          ],
        ));
  }
}

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.orange,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 50,
            ),
            Text('Folders Screen')
          ],
        ));
  }
}
