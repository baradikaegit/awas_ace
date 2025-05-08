// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/targetsales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/pages/targetsalesentry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';

class TargetsalesPage extends StatefulWidget {
  const TargetsalesPage({super.key});

  static const String routeName = "/targetSalesPage";

  @override
  State<TargetsalesPage> createState() => _TargetsalesPageState();
}

class _TargetsalesPageState extends State<TargetsalesPage> {
  Widget titleBar = const Text(
    "Target Sales",
    style: TextStyle(color: Colors.white),
  );

  TextEditingController searchController = TextEditingController();

  String monthNow = DateFormat('M').format(DateTime.now());
  String yearNow = DateFormat('yyyy').format(DateTime.now());

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleBar,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(
          255,
          3,
          116,
          18,
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(
        255,
        3,
        116,
        18,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
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
                final datatargetsales = ref.watch(targetSalesList);

                return Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: datatargetsales.when(
                              data: (datatargetsales) => (datatargetsales
                                          .listTargetSales !=
                                      null)
                                  ? datatargetsales.listTargetSales!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: SearchableList(
                                            initialList: datatargetsales
                                                .listTargetSales!,
                                            itemBuilder: (item) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    TargetsalesEntryPage
                                                        .routeName,
                                                    arguments:
                                                        "${item.bulanNum}/${item.tahun}/${item.iD}",
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    0,
                                                    10,
                                                    0,
                                                    10,
                                                  ),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minHeight: 195,
                                                      minWidth: double.infinity,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                            197,
                                                            3,
                                                            116,
                                                            18,
                                                          ),
                                                          blurRadius: 3.0,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 1.1,
                                                        ),
                                                      ],
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color:
                                                          const Color.fromARGB(
                                                        167,
                                                        19,
                                                        160,
                                                        0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            10,
                                                            10,
                                                            10,
                                                            0,
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Call = ${item.call}",
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Text(
                                                                      "${item.bulan} ${item.tahun}",
                                                                      style:
                                                                          textStyleColorWhite,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(10,
                                                                  10, 10, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Prospect = ${item.prospect}",
                                                              style:
                                                                  textStyleColorWhite,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(10,
                                                                  10, 10, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "HOT = 1",
                                                              style:
                                                                  textStyleColorWhite,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(10,
                                                                  10, 10, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "SPK = ${item.spk}",
                                                              style:
                                                                  textStyleColorWhite,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(10,
                                                                  10, 10, 0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "DO = ${item.dO}",
                                                              style:
                                                                  textStyleColorWhite,
                                                            ),
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
                                              return datatargetsales
                                                  .listTargetSales!
                                                  .where((element) => element
                                                      .bulan
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ))
                                                  .toList();
                                            },
                                            keyboardAction:
                                                TextInputAction.search,
                                            emptyWidget: const EmptyView(),
                                            inputDecoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              labelText: "Search..",
                                              labelStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                  255,
                                                  3,
                                                  116,
                                                  18,
                                                ),
                                              ),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                gapPadding: 15.0,
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    3,
                                                    116,
                                                    18,
                                                  ),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const MyAlertDialog()
                                  : const notActivetoken(),
                              error: (err, stack) => Text('Error $err'),
                              loading: () => const Center(
                                child: Column(
                                  children: [loadingAnimation()],
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
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blue,
        backgroundColor: const Color.fromARGB(
          255,
          3,
          116,
          18,
        ),
        tooltip: 'Prospect Pelanggan',
        onPressed: () {
          Navigator.pushNamed(
            context,
            TargetsalesEntryPage.routeName,
            arguments: "$monthNow/$yearNow/0",
          );
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.white,
          size: 50,
        ),
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
