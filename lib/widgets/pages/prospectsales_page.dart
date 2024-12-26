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

    print(screenWidth);

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
            3,
            116,
            18,
          ),
          body: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    ResponsiveRowColumnItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: ResponsiveValue<double>(
                              context,
                              conditionalValues: [
                                const Condition.largerThan(
                                  name: TABLET,
                                  value: 20.0,
                                  landscapeValue: 20.0,
                                  breakpoint: 500,
                                ),
                                const Condition.largerThan(
                                    name: TABLET,
                                    value: 32.0,
                                    landscapeValue: 32.0,
                                    breakpoint: 800),
                              ],
                              defaultValue: 19,
                            ).value,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.orange[400],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.96,
                            height: 35,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 40, 208, 37),
                                  Color.fromARGB(255, 106, 185, 44),
                                  Color.fromARGB(255, 175, 231, 44),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "ON PROGRESS",
                                style: textStyleColorWhite,
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
                            controller: _tabController,
                            dividerHeight: 0,
                            indicatorColor: Colors.orange,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white70,
                            isScrollable: false,
                            indicatorPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            tabs: [
                              _customTab("PELANGGAN \nHOT \nPROSPECT",
                                  const Color.fromARGB(255, 40, 208, 37)),
                              _customTab("MEDIUM PROSPECT",
                                  const Color.fromARGB(255, 106, 185, 44)),
                              _customTab("LOW PROSPECT",
                                  const Color.fromARGB(255, 175, 231, 44)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          HotProspectTab(),
                          Center(child: Text("Medium Prospect Content")),
                          Center(child: Text("Low Prospect Content")),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTab(String label, Color backgroundColor) {
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
            child: Text(
              textAlign: TextAlign.center,
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}

class HotProspectTab extends StatelessWidget {
  const HotProspectTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: Column(
        children: [
          Container(
            color: Colors.green[700],
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statusBox("1", "PELANGGAN\nHOT PROSPECT", Colors.red),
                    _statusBox(
                        "0", "PELANGGAN\nMEDIUM PROSPECT", Colors.yellow),
                    _statusBox("0", "PELANGGAN\nLOW PROSPECT", Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBox(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
