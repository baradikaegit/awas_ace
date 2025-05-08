import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemitemmodel.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeemitembydetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MonitoringRedeemItemPage extends StatefulWidget {
  const MonitoringRedeemItemPage({super.key});

  static const String routeName = "/monitoringRedeemItemPage";
  @override
  State<MonitoringRedeemItemPage> createState() =>
      _MonitoringRedeemItemPageState();
}

class _MonitoringRedeemItemPageState extends State<MonitoringRedeemItemPage> {
  TextEditingController searchController = TextEditingController();

  Widget titleBar = const Text(
    "Reward Poin",
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
      color: const Color.fromARGB(
        255,
        73,
        73,
        73,
      ),
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
                156,
                132,
                120,
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
                    final rptMonitoringRedeem =
                        ref.watch(reportMonitRedeemItem);

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(reportMonitRedeemItem);
                                  },
                                  child: rptMonitoringRedeem.when(
                                    data: (dataMonitoringRedeemItem) {
                                      return (dataMonitoringRedeemItem
                                                  .listRptGeneralMonitoringRedeemItem !=
                                              null)
                                          ? dataMonitoringRedeemItem
                                                  .listRptGeneralMonitoringRedeemItem!
                                                  .isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 20, 20, 0),
                                                  child: SearchableList<
                                                      ListRptGeneralMonitoringRedeemItem>(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    initialList:
                                                        dataMonitoringRedeemItem
                                                            .listRptGeneralMonitoringRedeemItem!,
                                                    itemBuilder: (item) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 10, 0, 10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            String iD = item.iD;

                                                            Navigator.pushNamed(
                                                              context,
                                                              MonitoringRedeemItemByDetailPage
                                                                  .routeName,
                                                              arguments: iD,
                                                            );
                                                          },
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 100,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    210,
                                                                    156,
                                                                    116,
                                                                    96,
                                                                  ),
                                                                  blurRadius:
                                                                      3.0,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  spreadRadius:
                                                                      1.1,
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
                                                                          10.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                210,
                                                                156,
                                                                116,
                                                                96,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
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
                                                                            BorderRadius.circular(4),
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
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                screenWidth * 0.04,
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
                                                                              Text(
                                                                                '${item.poinIDR} Poin',
                                                                                style: textStyleColorGrey,
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
                                                        ),
                                                      );
                                                    },
                                                    searchTextController:
                                                        searchController,
                                                    filter: (searchController) {
                                                      return dataMonitoringRedeemItem
                                                          .listRptGeneralMonitoringRedeemItem!
                                                          .where((element) =>
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
                                                              element.poin
                                                                  .toString()
                                                                  .contains(
                                                                    searchController
                                                                        .toString()
                                                                        .toLowerCase(),
                                                                  ))
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
