import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeembyss.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeembysvc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringRedeemPage extends StatefulWidget {
  const MonitoringRedeemPage({super.key});

  static const String routeName = "/monitoringRedeemPage";
  @override
  State<MonitoringRedeemPage> createState() => _MonitoringRedeemPageState();
}

class _MonitoringRedeemPageState extends State<MonitoringRedeemPage>
    with TickerProviderStateMixin {
  Widget titleBar = const Text(
    "Monitoring Redeem",
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
                color: const Color.fromARGB(255, 44, 197, 13),
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
                      fontWeight: FontWeight.bold,
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
                color: const Color.fromARGB(255, 19, 42, 173),
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
                      fontWeight: FontWeight.bold,
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
                        final rptMonitoringRedeem =
                            ref.watch(reportMonitRedeem);

                        return Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        return ref.refresh(
                                          reportMonitRedeem,
                                        );
                                      },
                                      child: rptMonitoringRedeem.when(
                                        data: (dataMonitoringRedeem) {
                                          return (dataMonitoringRedeem
                                                      .listRptGeneralMonitoringRedeem !=
                                                  null)
                                              ? dataMonitoringRedeem
                                                      .listRptGeneralMonitoringRedeem!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var textStyleDataTable =
                                                            TextStyle(
                                                          color: Colors.blue,
                                                          fontSize:
                                                              ResponsiveValue<
                                                                  double>(
                                                            context,
                                                            conditionalValues: [
                                                              const Condition
                                                                  .equals(
                                                                  name: TABLET,
                                                                  value: 12.0,
                                                                  landscapeValue:
                                                                      12.0),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 14.0,
                                                                  landscapeValue:
                                                                      14.0,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.0,
                                                          ).value,
                                                        );

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
                                                                              80,
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
                                                                              60,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "POIN",
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
                                                                              120,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "SISA REDEEM POIN",
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
                                                                            "REDEEM POIN",
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
                                                                            dataMonitoringRedeem
                                                                                .listRptGeneralMonitoringRedeem!.length;
                                                                        i++)
                                                                      if (dataMonitoringRedeem
                                                                              .listRptGeneralMonitoringRedeem![i]
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
                                                                                  String branchCode = dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerCode;

                                                                                  Navigator.pushNamed(
                                                                                    context,
                                                                                    MonitoringRedeemBySSPage.routeName,
                                                                                    arguments: branchCode,
                                                                                  );
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 10,
                                                                                  ),
                                                                                  child: Text(
                                                                                    dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerName,
                                                                                    style: textStyleDataTable,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data1,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data2,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data3,
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
                        final rptMonitoringRedeem =
                            ref.watch(reportMonitRedeem);

                        return Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        return ref.refresh(
                                          reportMonitRedeem,
                                        );
                                      },
                                      child: rptMonitoringRedeem.when(
                                        data: (dataMonitoringRedeem) {
                                          return (dataMonitoringRedeem
                                                      .listRptGeneralMonitoringRedeem !=
                                                  null)
                                              ? dataMonitoringRedeem
                                                      .listRptGeneralMonitoringRedeem!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var textStyleDataTable =
                                                            TextStyle(
                                                          color: Colors.blue,
                                                          fontSize:
                                                              ResponsiveValue<
                                                                  double>(
                                                            context,
                                                            conditionalValues: [
                                                              const Condition
                                                                  .equals(
                                                                  name: TABLET,
                                                                  value: 12.0,
                                                                  landscapeValue:
                                                                      12.0),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 14.0,
                                                                  landscapeValue:
                                                                      14.0,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.0,
                                                          ).value,
                                                        );

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
                                                                              80,
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
                                                                              60,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "POIN",
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
                                                                              120,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "SISA REDEEM POIN",
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
                                                                            "REDEEM POIN",
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
                                                                            dataMonitoringRedeem
                                                                                .listRptGeneralMonitoringRedeem!.length;
                                                                        i++)
                                                                      if (dataMonitoringRedeem
                                                                              .listRptGeneralMonitoringRedeem![i]
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
                                                                                  String branchCode = dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerCode;

                                                                                  Navigator.pushNamed(
                                                                                    context,
                                                                                    MonitoringRedeemBySvcPage.routeName,
                                                                                    arguments: branchCode,
                                                                                  );
                                                                                  print(branchCode);
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 10,
                                                                                  ),
                                                                                  child: Text(
                                                                                    dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerName,
                                                                                    style: textStyleDataTable,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data1,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data2,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: textStyleColorWhite,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data3,
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
