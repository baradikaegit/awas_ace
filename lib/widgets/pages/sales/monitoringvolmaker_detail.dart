import 'package:awas_ace/provider/reportsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitVolProfitMakerDetailPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitVolProfitMakerDetailPage({super.key, required this.linkPageObj});

  static const String routeName = "/monitVolProfitMakerDetailPage";
  @override
  State<MonitVolProfitMakerDetailPage> createState() =>
      _MonitVolProfitMakerDetailPageState();
}

class _MonitVolProfitMakerDetailPageState
    extends State<MonitVolProfitMakerDetailPage> {
  Widget titleBar = const Text(
    "Monitoring Volume Maker",
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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 16.0, landscapeValue: 16.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    var textStyleBlackWhiteB = TextStyle(
      color: const Color.fromARGB(255, 0, 0, 0),
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

    var textStyleColorGold = TextStyle(
      color: const Color.fromARGB(255, 250, 158, 19),
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

    var textStyleColorGold1 = TextStyle(
      color: const Color.fromARGB(255, 253, 250, 41),
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

                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());
                    final int yearNow =
                        int.parse(DateFormat('yyyy').format(DateTime.now()));

                    var header1 = (yearNow - 1);
                    var header2 = (yearNow - 2);

                    final rptMonitoring = ref.watch(
                      reportMonitoringVolProfitMakerDetail(linkPageObj),
                    );

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                child: rptMonitoring.when(
                                  data: (dataPeriod) => (dataPeriod
                                              .listMonitoringVolProfitMaker !=
                                          null)
                                      ? Column(
                                          children: [
                                            AppBar(
                                              automaticallyImplyLeading: false,
                                              centerTitle: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Monitoring Volume Maker",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
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
                                                                  12.0,
                                                            ),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11,
                                                        ).value,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "VELOZ, AVANZA, RAIZE, RUSH, AGYA & CALYA",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
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
                                                                  12.0,
                                                            ),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11.0,
                                                        ).value,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Cabang ${dataPeriod.listMonitoringVolProfitMaker![0].title}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
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
                                                                  12.0,
                                                            ),
                                                            const Condition
                                                                .largerThan(
                                                                name: TABLET,
                                                                value: 17.0,
                                                                landscapeValue:
                                                                    17.0,
                                                                breakpoint:
                                                                    800),
                                                          ],
                                                          defaultValue: 11.0,
                                                        ).value,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                255,
                                                33,
                                                44,
                                                81,
                                              ),
                                            ),
                                            AppBar(
                                              automaticallyImplyLeading: false,
                                              centerTitle: false,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Periode : $yearNow",
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          fontSize:
                                                              ResponsiveValue<
                                                                  double>(
                                                            context,
                                                            conditionalValues: [
                                                              const Condition
                                                                  .equals(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.5,
                                                          ).value,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Tanggal Hari ini : $dateNow",
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          fontSize:
                                                              ResponsiveValue<
                                                                  double>(
                                                            context,
                                                            conditionalValues: [
                                                              const Condition
                                                                  .equals(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.5,
                                                          ).value,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                  loading: () => const Center(child: Text('')),
                                ),
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                      reportMonitoringVolProfitMakerDetail(
                                          linkPageObj),
                                    );
                                  },
                                  child: rptMonitoring.when(
                                    data: (dataMonitoring) {
                                      return (dataMonitoring
                                                  .listMonitoringVolProfitMaker !=
                                              null)
                                          ? dataMonitoring
                                                  .listMonitoringVolProfitMaker!
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
                                                                  .all(0),
                                                          child: Image.asset(
                                                            dataMonitoring
                                                                        .listMonitoringVolProfitMaker![
                                                                            0]
                                                                        .title ==
                                                                    'TVBDG'
                                                                ? 'assets/images/peta/ATBDG.png'
                                                                : dataMonitoring
                                                                            .listMonitoringVolProfitMaker![
                                                                                0]
                                                                            .title ==
                                                                        'TVBKS'
                                                                    ? 'assets/images/peta/ATBKS.png'
                                                                    : dataMonitoring.listMonitoringVolProfitMaker![0].title ==
                                                                            'TVBTG'
                                                                        ? 'assets/images/peta/ATBTG.png'
                                                                        : dataMonitoring.listMonitoringVolProfitMaker![0].title ==
                                                                                'TVBTL'
                                                                            ? 'assets/images/peta/ATBTL.png'
                                                                            : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVCLI'
                                                                                ? 'assets/images/peta/ATCLI.png'
                                                                                : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVFWT'
                                                                                    ? 'assets/images/peta/ATFWT.png'
                                                                                    : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVHMN'
                                                                                        ? 'assets/images/peta/ATHMN.png'
                                                                                        : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKCI'
                                                                                            ? 'assets/images/peta/ATKCI.png'
                                                                                            : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKGD'
                                                                                                ? 'assets/images/peta/ATKGD.png'
                                                                                                : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKGV'
                                                                                                    ? 'assets/images/peta/ATKGV.png'
                                                                                                    : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVGVOld'
                                                                                                        ? 'assets/images/peta/ATGVOld.png'
                                                                                                        : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKJR'
                                                                                                            ? 'assets/images/peta/ATKJR.png'
                                                                                                            : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKLD'
                                                                                                                ? 'assets/images/peta/ATKLD.png'
                                                                                                                : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVKRW'
                                                                                                                    ? 'assets/images/peta/ATKRW.png'
                                                                                                                    : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVPDC'
                                                                                                                        ? 'assets/images/peta/ATPDC.png'
                                                                                                                        : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVPDG'
                                                                                                                            ? 'assets/images/peta/ATPDG.png'
                                                                                                                            : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVPIN'
                                                                                                                                ? 'assets/images/peta/ATPIN.png'
                                                                                                                                : dataMonitoring.listMonitoringVolProfitMaker![0].title == 'TVTGR'
                                                                                                                                    ? 'assets/images/peta/ATTGR.png'
                                                                                                                                    : 'assets/images/peta/ATYOS.png',
                                                            width: 600,
                                                            height: 600,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            10,
                                                            20,
                                                            10,
                                                            0,
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 200,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            child: DataTable(
                                                              headingRowColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith<
                                                                          Color?>(
                                                                (Set<MaterialState>
                                                                    states) {
                                                                  return const Color(
                                                                    0xFFFFFFFF,
                                                                  );
                                                                },
                                                              ),
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
                                                                            .centerLeft,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10.0,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "TOTAL",
                                                                          style:
                                                                              textStyleBlackWhiteB,
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
                                                                            .center,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 30,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "$header2",
                                                                        style:
                                                                            textStyleBlackWhiteB,
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
                                                                            .center,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 30,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "$header1",
                                                                        style:
                                                                            textStyleBlackWhiteB,
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
                                                                            .center,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 60,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "GROWTH",
                                                                        style:
                                                                            textStyleBlackWhiteB,
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
                                                                            .center,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 30,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "$yearNow",
                                                                        style:
                                                                            textStyleBlackWhiteB,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: List<
                                                                  DataRow>.generate(
                                                                dataMonitoring
                                                                    .listMonitoringVolProfitMaker!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptMonitoring =
                                                                      dataMonitoring
                                                                              .listMonitoringVolProfitMaker![
                                                                          indexObj];

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
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
                                                                                12.0,
                                                                            landscapeValue:
                                                                                12.0),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                14.0,
                                                                            landscapeValue:
                                                                                14.0,
                                                                            breakpoint:
                                                                                800),
                                                                      ],
                                                                      defaultValue:
                                                                          11.0,
                                                                    ).value,
                                                                  );

                                                                  return DataRow(
                                                                    color: MaterialStateColor
                                                                        .resolveWith(
                                                                      (states) => indexObj
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
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            dataRptMonitoring.isiHeader,
                                                                            style:
                                                                                textStyleDataTable,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptMonitoring.data1.toString(),
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
                                                                            dataRptMonitoring.data2.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment: dataRptMonitoring.growth == 0
                                                                              ? Alignment.center
                                                                              : Alignment.centerLeft,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              dataRptMonitoring.growth == 0
                                                                                  ? const Column(
                                                                                      children: [],
                                                                                    )
                                                                                  : dataRptMonitoring.growth <= 0
                                                                                      ? const Icon(
                                                                                          Icons.arrow_drop_down,
                                                                                          size: 25.0,
                                                                                          color: Colors.red,
                                                                                        )
                                                                                      : const Icon(
                                                                                          Icons.arrow_drop_up,
                                                                                          size: 25.0,
                                                                                          color: Colors.green,
                                                                                        ),
                                                                              Text(
                                                                                textAlign: dataRptMonitoring.growth == 0 ? TextAlign.center : TextAlign.left,
                                                                                "${dataRptMonitoring.growth.toString()}%",
                                                                                style: textStyleColorGold,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptMonitoring.data3.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorGold1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                10,
                                                                10,
                                                                0,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              child: Text(
                                                                "TOP 3",
                                                                style:
                                                                    textStyleColorWhiteB,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                10,
                                                                0,
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
                                                                  headingRowColor:
                                                                      MaterialStateProperty
                                                                          .resolveWith<
                                                                              Color?>(
                                                                    (Set<MaterialState>
                                                                        states) {
                                                                      return const Color(
                                                                        0xFFFFFFFF,
                                                                      );
                                                                    },
                                                                  ),
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
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              200,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10.0,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "TOTAL",
                                                                              style: textStyleBlackWhiteB,
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
                                                                            Alignment.center,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              30,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "$header2",
                                                                            style:
                                                                                textStyleBlackWhiteB,
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
                                                                            Alignment.center,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              30,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "$header1",
                                                                            style:
                                                                                textStyleBlackWhiteB,
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
                                                                            Alignment.center,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "GROWTH",
                                                                            style:
                                                                                textStyleBlackWhiteB,
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
                                                                            Alignment.center,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              30,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            "$yearNow",
                                                                            style:
                                                                                textStyleBlackWhiteB,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: List<
                                                                      DataRow>.generate(
                                                                    dataMonitoring
                                                                        .listMonitoringVolProfitMaker!
                                                                        .length,
                                                                    (indexObj) {
                                                                      final dataRptMonitoring =
                                                                          dataMonitoring
                                                                              .listMonitoringVolProfitMaker![indexObj];

                                                                      var textStyleDataTable =
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            ResponsiveValue<double>(
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
                                                                          defaultValue:
                                                                              11.0,
                                                                        ).value,
                                                                      );

                                                                      return DataRow(
                                                                        color: MaterialStateColor
                                                                            .resolveWith(
                                                                          (states) => indexObj.isEven
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
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                left: 10,
                                                                              ),
                                                                              child: Text(
                                                                                dataRptMonitoring.isiHeader,
                                                                                style: textStyleDataTable,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                dataRptMonitoring.data1.toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: textStyleColorWhite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                dataRptMonitoring.data2.toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: textStyleColorWhite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: dataRptMonitoring.growth == 0 ? Alignment.center : Alignment.centerLeft,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  dataRptMonitoring.growth == 0
                                                                                      ? const Column(
                                                                                          children: [],
                                                                                        )
                                                                                      : dataRptMonitoring.growth <= 0
                                                                                          ? const Icon(
                                                                                              Icons.arrow_drop_down,
                                                                                              size: 25.0,
                                                                                              color: Colors.red,
                                                                                            )
                                                                                          : const Icon(
                                                                                              Icons.arrow_drop_up,
                                                                                              size: 25.0,
                                                                                              color: Colors.green,
                                                                                            ),
                                                                                  Text(
                                                                                    textAlign: dataRptMonitoring.growth == 0 ? TextAlign.center : TextAlign.left,
                                                                                    "${dataRptMonitoring.growth.toString()}%",
                                                                                    style: textStyleColorGold,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                dataRptMonitoring.data3.toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: textStyleColorGold1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
