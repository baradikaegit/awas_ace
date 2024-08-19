// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    _tabController = TabController(vsync: this, length: 4);
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

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        indicatorPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        indicatorWeight: 150.0,
        dividerColor: Colors.brown,
        unselectedLabelColor: Colors.amberAccent,
        labelColor: const Color.fromARGB(
          255,
          9,
          155,
          28,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: _tabController.index == 0
              ? const Color.fromARGB(255, 134, 134, 134)
              : _tabController.index == 1
                  ? const Color.fromARGB(255, 1, 53, 131)
                  : _tabController.index == 2
                      ? const Color.fromARGB(255, 202, 109, 2)
                      : const Color.fromARGB(255, 146, 2, 2),

          // gradient: LinearGradient(
          //   // begin: Alignment.topRight,
          //   // end: Alignment.bottomLeft,
          //   // stops: [
          //   //   0.1,
          //   //   0.4,
          //   //   0.6,
          //   //   0.9,
          //   // ],
          //   colors: [
          //     Colors.yellow,
          //     Colors.red,
          //     Colors.indigo,
          //     Colors.teal,
          //   ],
          // ),
        ),
        tabs: [
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sticky_note_2_outlined,
                  color:
                      _tabController.index == 0 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  " STEP 1",
                  style: TextStyle(
                    color:
                        _tabController.index == 0 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt_outlined,
                  color:
                      _tabController.index == 1 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  " STEP 2",
                  style: TextStyle(
                    color:
                        _tabController.index == 1 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car,
                  color:
                      _tabController.index == 2 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  "STEP 3",
                  style: TextStyle(
                    color:
                        _tabController.index == 2 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.handshake_outlined,
                  color:
                      _tabController.index == 3 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  "STEP 4",
                  style: TextStyle(
                    color:
                        _tabController.index == 3 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
        ],
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

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Prospect Sales",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(255, 4, 248, 37),
                child: Theme(
                  data: ThemeData().copyWith(
                    splashColor: const Color.fromARGB(
                      255,
                      3,
                      116,
                      18,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "ON PROGRESS",
                        style: textStyleColorWhite,
                      ),
                      _tabBar,
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(
              255,
              164,
              165,
              164,
            ),
            elevation: 0,
          ),
          backgroundColor: const Color.fromARGB(
            255,
            3,
            116,
            18,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    134,
                    134,
                    134,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "PROSPECTING",
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
                                      defaultValue: 12.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    1,
                    53,
                    131,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "GREETING & QUALIFYING",
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
                                      defaultValue: 12.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    202,
                    109,
                    2,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "PERSENTATION",
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
                                      defaultValue: 12.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    146,
                    2,
                    2,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "NEGOTIATION & CLOSING",
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
                                      defaultValue: 12.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
