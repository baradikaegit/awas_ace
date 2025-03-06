import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/pages/general/monitoringpoinbyss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringPoinPage extends StatefulWidget {
  const MonitoringPoinPage({super.key});

  static const String routeName = "/monitoringPoinPage";
  @override
  State<MonitoringPoinPage> createState() => _MonitoringPoinPageState();
}

class _MonitoringPoinPageState extends State<MonitoringPoinPage>
    with TickerProviderStateMixin {
  Widget titleBar = const Text(
    "Monitoring Poin",
    style: TextStyle(color: Colors.white),
  );

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        dividerHeight: 0,
        indicatorColor: const Color.fromARGB(
          255,
          33,
          44,
          81,
        ),
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
          Tab(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  134,
                  134,
                  134,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Showroom ",
                    style: TextStyle(
                      color: _tabController.index == 0
                          ? Colors.white
                          : Colors.grey,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
                          const Condition.largerThan(
                              name: TABLET,
                              value: 20.0,
                              landscapeValue: 20.0,
                              breakpoint: 800),
                        ],
                        defaultValue: 12.0,
                      ).value,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  134,
                  134,
                  134,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Service ",
                    style: TextStyle(
                      color: _tabController.index == 1
                          ? Colors.white
                          : Colors.grey,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
                          const Condition.largerThan(
                              name: TABLET,
                              value: 20.0,
                              landscapeValue: 20.0,
                              breakpoint: 800),
                        ],
                        defaultValue: 12.0,
                      ).value,
                    ),
                  ),
                ),
              ),
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
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
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(
                  255,
                  134,
                  134,
                  134,
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    splashColor: const Color.fromARGB(
                      255,
                      3,
                      116,
                      18,
                    ),
                  ),
                  child: _tabBar,
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    33,
                    44,
                    81,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Stack(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final rptMonitoringPoin = ref.watch(reportMonitPoin);

                        return Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    child: rptMonitoringPoin.when(
                                      data: (dataTop) => (dataTop
                                                  .listRptGeneralMonitoringPoin !=
                                              null)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            dataTop
                                                                .listRptGeneralMonitoringPoin!
                                                                .length;
                                                        i++)
                                                      if (dataTop
                                                              .listRptGeneralMonitoringPoin![
                                                                  i]
                                                              .tipe ==
                                                          'SHW TOP')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            15,
                                                            10,
                                                            15,
                                                            20,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                  255,
                                                                  3,
                                                                  116,
                                                                  18,
                                                                ),
                                                                minRadius: 30,
                                                                maxRadius: 50,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/user.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .data3,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .headerCode,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .data2,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const Column(
                                              children: [],
                                            ),
                                      error: (err, stack) => Text('Error $err'),
                                      loading: () =>
                                          const Center(child: Text('')),
                                    ),
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        return ref.refresh(
                                          reportMonitPoin,
                                        );
                                      },
                                      child: rptMonitoringPoin.when(
                                        data: (dataMonitoringPoin) {
                                          var textStyleDataTable = TextStyle(
                                            color: Colors.blue,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 14.0,
                                                    landscapeValue: 14.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 11.0,
                                            ).value,
                                          );
                                          return (dataMonitoringPoin
                                                      .listRptGeneralMonitoringPoin !=
                                                  null)
                                              ? dataMonitoringPoin
                                                      .listRptGeneralMonitoringPoin!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                20,
                                                                10,
                                                                20,
                                                              ),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight:
                                                                      600,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                child:
                                                                    DataTable(
                                                                  border:
                                                                      const TableBorder(
                                                                    horizontalInside:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        27,
                                                                        37,
                                                                        68,
                                                                      ),
                                                                      width:
                                                                          2.5,
                                                                    ),
                                                                  ),
                                                                  columnSpacing:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              20.0,
                                                                          landscapeValue:
                                                                              20.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              0.0,
                                                                          landscapeValue:
                                                                              0.0)
                                                                    ],
                                                                    defaultValue:
                                                                        10,
                                                                  ).value,
                                                                  horizontalMargin: ResponsiveValue<
                                                                              double>(
                                                                          context,
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
                                                                          defaultValue:
                                                                              12.0)
                                                                      .value,
                                                                  headingRowHeight:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              35.0,
                                                                          landscapeValue:
                                                                              35.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              50.0,
                                                                          landscapeValue:
                                                                              50.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        30.0,
                                                                  ).value,
                                                                  columns: [
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              95,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10.0,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "CABANG",
                                                                              style: textStyleColorWhiteB,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TERTINGGI",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TERENDAH",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              80,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TOTAL POIN",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            dataMonitoringPoin
                                                                                .listRptGeneralMonitoringPoin!.length;
                                                                        i++)
                                                                      if (dataMonitoringPoin
                                                                              .listRptGeneralMonitoringPoin![i]
                                                                              .tipe ==
                                                                          'SHW')
                                                                        DataRow(
                                                                          color:
                                                                              MaterialStateColor.resolveWith(
                                                                            (states) => i.isEven
                                                                                ? const Color.fromARGB(
                                                                                    213,
                                                                                    27,
                                                                                    37,
                                                                                    68,
                                                                                  )
                                                                                : Colors.transparent,
                                                                          ),
                                                                          cells: <DataCell>[
                                                                            DataCell(
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  String branchCode = dataMonitoringPoin.listRptGeneralMonitoringPoin![i].headerCode;

                                                                                  Navigator.pushNamed(
                                                                                    context,
                                                                                    MonitoringPoinBySSPage.routeName,
                                                                                    arguments: branchCode,
                                                                                  );
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 10,
                                                                                  ),
                                                                                  child: Text(
                                                                                    dataMonitoringPoin.listRptGeneralMonitoringPoin![i].headerCode,
                                                                                    style: textStyleDataTable,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data1.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data2.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data3.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : const MyAlertDialog()
                                              : const notActivetoken();
                                        },
                                        error: (err, stack) =>
                                            Text('Error $err'),
                                        loading: () => const Center(
                                          child: Column(
                                            children: [loadingAnimation()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const Watermark(),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    33,
                    44,
                    81,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Stack(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final rptMonitoringPoin = ref.watch(reportMonitPoin);

                        return Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    child: rptMonitoringPoin.when(
                                      data: (dataTop) => (dataTop
                                                  .listRptGeneralMonitoringPoin !=
                                              null)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            dataTop
                                                                .listRptGeneralMonitoringPoin!
                                                                .length;
                                                        i++)
                                                      if (dataTop
                                                              .listRptGeneralMonitoringPoin![
                                                                  i]
                                                              .tipe ==
                                                          'SVC TOP')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            15,
                                                            10,
                                                            15,
                                                            20,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                  255,
                                                                  3,
                                                                  116,
                                                                  18,
                                                                ),
                                                                minRadius: 30,
                                                                maxRadius: 50,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/user.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .data3,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .headerCode,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                              Text(
                                                                dataTop
                                                                    .listRptGeneralMonitoringPoin![
                                                                        i]
                                                                    .data2,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const Column(
                                              children: [],
                                            ),
                                      error: (err, stack) => Text('Error $err'),
                                      loading: () =>
                                          const Center(child: Text('')),
                                    ),
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        return ref.refresh(
                                          reportMonitPoin,
                                        );
                                      },
                                      child: rptMonitoringPoin.when(
                                        data: (dataMonitoringPoin) {
                                          var textStyleDataTable = TextStyle(
                                            color: Colors.blue,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 14.0,
                                                    landscapeValue: 14.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 11.0,
                                            ).value,
                                          );
                                          return (dataMonitoringPoin
                                                      .listRptGeneralMonitoringPoin !=
                                                  null)
                                              ? dataMonitoringPoin
                                                      .listRptGeneralMonitoringPoin!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                20,
                                                                10,
                                                                20,
                                                              ),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight:
                                                                      600,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                child:
                                                                    DataTable(
                                                                  border:
                                                                      const TableBorder(
                                                                    horizontalInside:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        27,
                                                                        37,
                                                                        68,
                                                                      ),
                                                                      width:
                                                                          2.5,
                                                                    ),
                                                                  ),
                                                                  columnSpacing:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              20.0,
                                                                          landscapeValue:
                                                                              20.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              0.0,
                                                                          landscapeValue:
                                                                              0.0)
                                                                    ],
                                                                    defaultValue:
                                                                        10,
                                                                  ).value,
                                                                  horizontalMargin: ResponsiveValue<
                                                                              double>(
                                                                          context,
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
                                                                          defaultValue:
                                                                              12.0)
                                                                      .value,
                                                                  headingRowHeight:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              35.0,
                                                                          landscapeValue:
                                                                              35.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              50.0,
                                                                          landscapeValue:
                                                                              50.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        30.0,
                                                                  ).value,
                                                                  columns: [
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              95,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10.0,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "CABANG",
                                                                              style: textStyleColorWhiteB,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TERTINGGI",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TERENDAH",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              80,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "TOTAL POIN",
                                                                            style:
                                                                                textStyleColorWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            dataMonitoringPoin
                                                                                .listRptGeneralMonitoringPoin!.length;
                                                                        i++)
                                                                      if (dataMonitoringPoin
                                                                              .listRptGeneralMonitoringPoin![i]
                                                                              .tipe ==
                                                                          'SVC')
                                                                        DataRow(
                                                                          color:
                                                                              MaterialStateColor.resolveWith(
                                                                            (states) => i.isEven
                                                                                ? const Color.fromARGB(
                                                                                    213,
                                                                                    27,
                                                                                    37,
                                                                                    68,
                                                                                  )
                                                                                : Colors.transparent,
                                                                          ),
                                                                          cells: <DataCell>[
                                                                            DataCell(
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  String branchCode = dataMonitoringPoin.listRptGeneralMonitoringPoin![i].headerCode;

                                                                                  // Navigator.pushNamed(
                                                                                  //   context,
                                                                                  //   MonitoringPoinBySSPage.routeName,
                                                                                  //   arguments: branchCode,
                                                                                  // );
                                                                                  print(branchCode);
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 10,
                                                                                  ),
                                                                                  child: Text(
                                                                                    dataMonitoringPoin.listRptGeneralMonitoringPoin![i].headerName,
                                                                                    style: textStyleDataTable,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data1.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data2.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringPoin.listRptGeneralMonitoringPoin![i].data3.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : const MyAlertDialog()
                                              : const notActivetoken();
                                        },
                                        error: (err, stack) =>
                                            Text('Error $err'),
                                        loading: () => const Center(
                                          child: Column(
                                            children: [loadingAnimation()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const Watermark(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
