import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemhistorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MonitoringRedeemByHistoryPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitoringRedeemByHistoryPage({super.key, required this.linkPageObj});

  static const String routeName = "/monitoringRedeemByHistoryPage";
  @override
  State<MonitoringRedeemByHistoryPage> createState() =>
      _MonitoringRedeemByHistoryPageState();
}

class _MonitoringRedeemByHistoryPageState
    extends State<MonitoringRedeemByHistoryPage> {
  TextEditingController searchController = TextEditingController();

  Widget titleBar = const Text(
    "Monitoring Redeem",
    style: TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhiteBH = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 18.0, landscapeValue: 18.0),
          const Condition.largerThan(
              name: TABLET, value: 15.0, landscapeValue: 15.0, breakpoint: 800),
        ],
        defaultValue: 14.0,
      ).value,
    );

    var textStyleColorGrey = TextStyle(
      color: const Color.fromARGB(255, 134, 134, 134),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 18.0, landscapeValue: 18.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
    );

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

    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.04; // 4% dari lebar layar

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
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    final rptMonitoringRedeem =
                        ref.watch(reportMonitRedeemByHistory(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                      reportMonitRedeemByHistory(linkPageObj),
                                    );
                                  },
                                  child: rptMonitoringRedeem.when(
                                    data: (dataMonitoringRedeem) {
                                      return (dataMonitoringRedeem
                                                  .listRptGeneralMonitoringRedeemHistory !=
                                              null)
                                          ? dataMonitoringRedeem
                                                  .listRptGeneralMonitoringRedeemHistory!
                                                  .isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 20, 20, 0),
                                                  child: SearchableList<
                                                      ListRptGeneralMonitoringRedeemHistory>(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    initialList:
                                                        dataMonitoringRedeem
                                                            .listRptGeneralMonitoringRedeemHistory!,
                                                    itemBuilder: (item) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 10, 0, 10),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 100,
                                                            minWidth:
                                                                double.infinity,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Color
                                                                    .fromARGB(
                                                                  213,
                                                                  27,
                                                                  37,
                                                                  68,
                                                                ),
                                                                blurRadius: 3.0,
                                                                offset: Offset(
                                                                    0, 0),
                                                                spreadRadius:
                                                                    1.1,
                                                              ),
                                                            ],
                                                            border: Border.all(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color: const Color
                                                                .fromARGB(
                                                              213,
                                                              27,
                                                              37,
                                                              68,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      spacing,
                                                                  vertical:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/noimage.png',
                                                                        width:
                                                                            100,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: screenWidth *
                                                                              0.04,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              item.title,
                                                                              style: textStyleColorWhiteBH,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 6,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    '${item.poin} Poin',
                                                                                    style: textStyleColorGrey,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(right: 8),
                                                                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 2),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.grey,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Text(item.name, style: textStyleColorWhite),
                                                                                ),
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(right: 8),
                                                                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 2),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.grey,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Text(item.createdOn, style: textStyleColorWhite),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    searchTextController:
                                                        searchController,
                                                    filter: (searchController) {
                                                      return dataMonitoringRedeem
                                                          .listRptGeneralMonitoringRedeemHistory!
                                                          .where(
                                                            (element) =>
                                                                element.title
                                                                    .toLowerCase()
                                                                    .contains(
                                                                      searchController
                                                                          .toString()
                                                                          .toLowerCase(),
                                                                    ) ||
                                                                element
                                                                    .description
                                                                    .toString()
                                                                    .contains(
                                                                      searchController
                                                                          .toString()
                                                                          .toLowerCase(),
                                                                    ) ||
                                                                element.name
                                                                    .toString()
                                                                    .contains(
                                                                      searchController
                                                                          .toString()
                                                                          .toLowerCase(),
                                                                    ) ||
                                                                element
                                                                    .createdOn
                                                                    .toString()
                                                                    .contains(
                                                                      searchController
                                                                          .toString()
                                                                          .toLowerCase(),
                                                                    ),
                                                          )
                                                          .toList();
                                                    },
                                                    keyboardAction:
                                                        TextInputAction.search,
                                                    emptyWidget:
                                                        const EmptyView(),
                                                    inputDecoration:
                                                        InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8.0),
                                                      labelText: "Search..",
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          212,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        gapPadding: 15.0,
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            212,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                const Watermark(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.up,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Align(alignment: Alignment.center, child: Text('Data Not Found.!')),
        ],
      ),
    );
  }
}
