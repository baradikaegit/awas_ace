// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/svckendaraan_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/svckendaraanmodel.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/bodyrepairslsdetail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';

class BodyRepairSlsPage extends StatefulWidget {
  const BodyRepairSlsPage({super.key});

  static const String routeName = "/bodyRepairSlsPage";

  @override
  State<BodyRepairSlsPage> createState() => _BodyRepairSlsPageState();
}

class _BodyRepairSlsPageState extends State<BodyRepairSlsPage> {
  Widget titleBar = const Text(
    "Body Repair (Sales)",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

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
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: titleBar,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(
            255,
            53,
            104,
            159,
          ),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(
          255,
          53,
          104,
          159,
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
                builder: (context, WidgetRef ref, child) {
                  final dataBodyRepair = ref.watch(bodyRepairSls);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: dataBodyRepair.when(
                                data: (data) => (data.listSvcKendaraan != null)
                                    ? data.listSvcKendaraan!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            child: SearchableList<
                                                ListSvcKendaraan>(
                                              initialList:
                                                  data.listSvcKendaraan!,
                                              itemBuilder: (item) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      BodyRepariSlsDetailPage
                                                          .routeName,
                                                      arguments: item.iD,
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 10, 0, 10),
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 90,
                                                        minWidth:
                                                            double.infinity,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                              167,
                                                              53,
                                                              104,
                                                              159,
                                                            ),
                                                            blurRadius: 3.0,
                                                            offset:
                                                                Offset(0, 0),
                                                            spreadRadius: 1.1,
                                                          ),
                                                        ],
                                                        border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: const Color
                                                            .fromARGB(
                                                          167,
                                                          15,
                                                          70,
                                                          128,
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
                                                                    item.policeNumber,
                                                                    style:
                                                                        textStyleColorWhite,
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        item.statusName,
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
                                                                    .fromLTRB(
                                                              10,
                                                              10,
                                                              10,
                                                              0,
                                                            ),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                item.vtype,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ),
                                                          ),
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
                                                              child: Text(
                                                                item.taskDateView,
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                              10,
                                                              10,
                                                              10,
                                                              10,
                                                            ),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                item.custName,
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
                                                return data.listSvcKendaraan!
                                                    .where(
                                                      (element) =>
                                                          element.custName
                                                              .toLowerCase()
                                                              .contains(
                                                                searchController
                                                                    .toString()
                                                                    .toLowerCase(),
                                                              ) ||
                                                          element.vtype
                                                              .toLowerCase()
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
                                              emptyWidget: const EmptyView(),
                                              inputDecoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                labelText: "Search..",
                                                labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    53,
                                                    104,
                                                    159,
                                                  ),
                                                ),
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  gapPadding: 15.0,
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                      255,
                                                      53,
                                                      104,
                                                      159,
                                                    ),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.0,
                                                  ),
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
