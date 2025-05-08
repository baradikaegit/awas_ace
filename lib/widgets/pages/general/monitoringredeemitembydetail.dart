// ignore_for_file: use_build_context_synchronously

import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemitemmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringRedeemItemByDetailPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitoringRedeemItemByDetailPage(
      {super.key, required this.linkPageObj});

  static const String routeName = "/monitoringRedeemItemByDetailPage";
  @override
  State<MonitoringRedeemItemByDetailPage> createState() =>
      _MonitoringRedeemItemByDetailPageState();
}

class _MonitoringRedeemItemByDetailPageState
    extends State<MonitoringRedeemItemByDetailPage> {
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
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 18.0, landscapeValue: 18.0),
          const Condition.largerThan(
              name: TABLET, value: 22.0, landscapeValue: 22.0, breakpoint: 800),
        ],
        defaultValue: 14.0,
      ).value,
    );

    var textStyleColorWhiteIH = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontStyle: FontStyle.italic,
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
                    var linkPageObj = widget.linkPageObj.toString();

                    final rptMonitoringRedeem =
                        ref.watch(reportMonitRedeemItemDetail(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                        reportMonitRedeemItemDetail(
                                            linkPageObj));
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
                                                    20,
                                                    20,
                                                    20,
                                                    0,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      for (int i = 0;
                                                          i <
                                                              dataMonitoringRedeemItem
                                                                  .listRptGeneralMonitoringRedeemItem!
                                                                  .length;
                                                          i++)
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: spacing,
                                                            vertical:
                                                                screenWidth *
                                                                    0.02,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/noimage.png',
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  dataMonitoringRedeemItem
                                                                      .listRptGeneralMonitoringRedeemItem![
                                                                          i]
                                                                      .title,
                                                                  style:
                                                                      textStyleColorWhiteBH,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  dataMonitoringRedeemItem
                                                                      .listRptGeneralMonitoringRedeemItem![
                                                                          i]
                                                                      .description,
                                                                  style:
                                                                      textStyleColorWhiteIH,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 10,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${dataMonitoringRedeemItem.listRptGeneralMonitoringRedeemItem![i].poinIDR} POIN',
                                                                    style:
                                                                        textStyleColorWhite,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 10,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      OutlinedButton(
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      fixedSize:
                                                                          Size(
                                                                        ResponsiveValue<
                                                                            double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                              name: TABLET,
                                                                              value: 300,
                                                                              landscapeValue: 300,
                                                                            ),
                                                                            const Condition.largerThan(
                                                                              name: TABLET,
                                                                              value: 500,
                                                                              landscapeValue: 500,
                                                                              breakpoint: 800,
                                                                            ),
                                                                          ],
                                                                          defaultValue:
                                                                              200,
                                                                        ).value,
                                                                        ResponsiveValue<
                                                                            double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 55,
                                                                                landscapeValue: 55),
                                                                            const Condition.largerThan(
                                                                              name: TABLET,
                                                                              value: 55,
                                                                              landscapeValue: 55,
                                                                              breakpoint: 800,
                                                                            ),
                                                                          ],
                                                                          defaultValue:
                                                                              50,
                                                                        ).value,
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          const Color
                                                                              .fromARGB(
                                                                        255,
                                                                        3,
                                                                        116,
                                                                        18,
                                                                      ),
                                                                    ).copyWith(
                                                                      overlayColor:
                                                                          MaterialStateProperty.resolveWith<
                                                                              Color?>(
                                                                        (Set<MaterialState>
                                                                            states) {
                                                                          if (states
                                                                              .contains(MaterialState.pressed)) {
                                                                            return const Color.fromARGB(
                                                                              255,
                                                                              1,
                                                                              209,
                                                                              29,
                                                                            );
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      int successCount =
                                                                          0;
                                                                      int failCount =
                                                                          0;
                                                                      String
                                                                          item =
                                                                          dataMonitoringRedeemItem
                                                                              .listRptGeneralMonitoringRedeemItem![i]
                                                                              .title;
                                                                      String
                                                                          idrPoin =
                                                                          dataMonitoringRedeemItem
                                                                              .listRptGeneralMonitoringRedeemItem![i]
                                                                              .poinIDR;

                                                                      int totalPoin = dataMonitoringRedeemItem
                                                                          .listRptGeneralMonitoringRedeemItem![
                                                                              i]
                                                                          .totalPoin;
                                                                      int poin = dataMonitoringRedeemItem
                                                                          .listRptGeneralMonitoringRedeemItem![
                                                                              i]
                                                                          .poin;

                                                                      if (totalPoin <
                                                                          poin) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            title:
                                                                                Text(
                                                                              "Info",
                                                                              style: TextStyle(
                                                                                fontSize: ResponsiveValue<double>(
                                                                                  context,
                                                                                  conditionalValues: [
                                                                                    const Condition.equals(name: TABLET, value: 17.0, landscapeValue: 17.0),
                                                                                    const Condition.largerThan(name: TABLET, value: 25.0, landscapeValue: 25.0, breakpoint: 800),
                                                                                  ],
                                                                                  defaultValue: 12.0,
                                                                                ).value,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            content:
                                                                                Text(
                                                                              "Redeem Poin Anda Tidak Mencukupi.",
                                                                              style: TextStyle(
                                                                                fontSize: ResponsiveValue<double>(
                                                                                  context,
                                                                                  conditionalValues: [
                                                                                    const Condition.equals(name: TABLET, value: 14.5, landscapeValue: 14.5),
                                                                                    const Condition.largerThan(name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
                                                                                  ],
                                                                                  defaultValue: 12.0,
                                                                                ).value,
                                                                              ),
                                                                            ),
                                                                            actionsPadding:
                                                                                const EdgeInsets.symmetric(
                                                                              horizontal: 0,
                                                                            ),
                                                                            actions: <Widget>[
                                                                              OutlinedButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: OutlinedButton.styleFrom(
                                                                                  side: BorderSide.none,
                                                                                ),
                                                                                child: const Text(
                                                                                  "OK",
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFF119D90),
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        var redeempoin =
                                                                            ListEntryRedeemPoin(
                                                                          redeemItemID: dataMonitoringRedeemItem
                                                                              .listRptGeneralMonitoringRedeemItem![i]
                                                                              .iD,
                                                                          poin: dataMonitoringRedeemItem
                                                                              .listRptGeneralMonitoringRedeemItem![i]
                                                                              .poin,
                                                                          title: dataMonitoringRedeemItem
                                                                              .listRptGeneralMonitoringRedeemItem![i]
                                                                              .title,
                                                                        );

                                                                        try {
                                                                          await ref
                                                                              .read(entryRedeemPoinFormProvider)
                                                                              .onSubmitRedeemPoin(redeempoin);
                                                                          successCount++;
                                                                        } catch (e) {
                                                                          failCount++;
                                                                        }

                                                                        Navigator.of(context).pushAndRemoveUntil(
                                                                            MaterialPageRoute(builder: (context) => const HomePage()),
                                                                            (route) => false);

                                                                        if (successCount >
                                                                                0 &&
                                                                            failCount ==
                                                                                0) {
                                                                          notifUpdated(
                                                                            context,
                                                                            "Redeem poin berhasil dilakukan untuk item $item sebesar $idrPoin poin",
                                                                            true,
                                                                          );
                                                                        } else {
                                                                          notifUpdated(
                                                                            context,
                                                                            "Redeem poin gagal",
                                                                            false,
                                                                          );
                                                                        }
                                                                      }

                                                                      // print(redeempoin
                                                                      //     .toString());
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      children: <Widget>[
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            "REDEEM POIN",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
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

  void notifUpdated(BuildContext context, String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: success
            ? const Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text(message),
      ),
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
