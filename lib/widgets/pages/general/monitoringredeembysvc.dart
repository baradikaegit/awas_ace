import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeembyhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringRedeemBySvcPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitoringRedeemBySvcPage({super.key, required this.linkPageObj});

  static const String routeName = "/monitoringRedeemBySvcPage";
  @override
  State<MonitoringRedeemBySvcPage> createState() =>
      _MonitoringRedeemBySvcPageState();
}

class _MonitoringRedeemBySvcPageState extends State<MonitoringRedeemBySvcPage>
    with TickerProviderStateMixin {
  Widget titleBar = const Text(
    "Monitoring Redeem",
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
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                255,
                33,
                44,
                81,
              ),
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
                    var linkPageObj = widget.linkPageObj.toString();
                    final rptMonitoringRedeem =
                        ref.watch(reportMonitRedeemBySvc(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptMonitoringRedeem.when(
                                    data: (data) =>
                                        (data.listRptGeneralMonitoringRedeem !=
                                                null)
                                            ? Column(
                                                children: [
                                                  AppBar(
                                                    automaticallyImplyLeading:
                                                        false,
                                                    centerTitle: true,
                                                    title: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            0,
                                                            5,
                                                            0,
                                                            0,
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "CABANG ${data.listRptGeneralMonitoringRedeem![0].title.replaceAll('\\n', '\n')}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ResponsiveValue<
                                                                        double>(
                                                                  context,
                                                                  conditionalValues: [
                                                                    const Condition
                                                                        .equals(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            14.0,
                                                                        landscapeValue:
                                                                            14.0),
                                                                    const Condition
                                                                        .largerThan(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            14.5,
                                                                        landscapeValue:
                                                                            14.5,
                                                                        breakpoint:
                                                                            800),
                                                                  ],
                                                                  defaultValue:
                                                                      12.0,
                                                                ).value,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                      255,
                                                      33,
                                                      44,
                                                      81,
                                                    ),
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
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                      reportMonitRedeemBySvc(linkPageObj),
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
                                                      fontSize: ResponsiveValue<
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
                                                              breakpoint: 800),
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
                                                              minHeight: 600,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            child: DataTable(
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
                                                                  width: 2.5,
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
                                                                        const Condition
                                                                            .equals(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                5.0,
                                                                            landscapeValue:
                                                                                5.0),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                5.0,
                                                                            landscapeValue:
                                                                                5.0,
                                                                            breakpoint:
                                                                                800)
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
                                                                  const Condition.largerThan(
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 65,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10.0,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          "NIK",
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
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          100,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        "NAMA",
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        "JABATAN",
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
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 60,
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
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 75,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "SISA REDEEM POIN",
                                                                        style:
                                                                            textStyleColorWhiteB,
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: [
                                                                for (int i = 0;
                                                                    i <
                                                                        dataMonitoringRedeem
                                                                            .listRptGeneralMonitoringRedeem!
                                                                            .length;
                                                                    i++)
                                                                  DataRow(
                                                                    color: MaterialStateColor
                                                                        .resolveWith(
                                                                      (states) => i
                                                                              .isEven
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              213,
                                                                              27,
                                                                              37,
                                                                              68,
                                                                            )
                                                                          : Colors
                                                                              .transparent,
                                                                    ),
                                                                    cells: <DataCell>[
                                                                      DataCell(
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            String
                                                                                userCode =
                                                                                dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerCode;

                                                                            Navigator.pushNamed(
                                                                              context,
                                                                              MonitoringRedeemByHistoryPage.routeName,
                                                                              arguments: userCode,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10,
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerCode,
                                                                                textAlign: TextAlign.center,
                                                                                style: textStyleDataTable,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerName,
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].headerGroup,
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data3,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataMonitoringRedeem.listRptGeneralMonitoringRedeem![i].data2,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
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
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
