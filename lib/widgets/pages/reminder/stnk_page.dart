// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/reminder_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/remindergetsalesmodel.dart';
import 'package:awas_ace/widgets/model/remindermodel.dart';
import 'package:awas_ace/widgets/pages/reminder/stnkdetail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderSTNKPage extends StatefulWidget {
  const ReminderSTNKPage({super.key});

  static const String routeName = "/reminderSTNKPage";

  @override
  State<ReminderSTNKPage> createState() => _ReminderSTNKPageState();
}

class _ReminderSTNKPageState extends State<ReminderSTNKPage> {
  Widget titleBar = const Text(
    "STNK",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  List<ListReminderResponse> listReminderRes = [];
  List<bool> checkedItems = [];
  List<TextEditingController> checkControllers = [];
  List<TextEditingController> taskControllers = [];
  TextEditingController searchControllerDrawer = TextEditingController();
  int? currentIndex;

  String? userName;
  String? sid;
  String? branchID;
  String? roles;

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Username');
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');
      roles = prefs.getString('Roles');
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
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(
            255,
            253,
            181,
            19,
          ),
          elevation: 0,
        ),
        endDrawer: Drawer(
          child: Stack(
            children: [
              Consumer(builder: (context, WidgetRef ref, child) {
                final dataSales = ref.watch(getSales);

                return Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                return ref.refresh(getSales);
                              },
                              child: dataSales.when(
                                data: (dataSendTask) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      5,
                                      20,
                                      5,
                                      0,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SearchableList<
                                              ListReminderGetSales>(
                                            initialList: dataSendTask
                                                .listReminderGetSales!,
                                            itemBuilder: (item) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minHeight: 20,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x50D6D6D6),
                                                        blurRadius: 8.0,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 5.1,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFDEDEE2),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    color:
                                                        const Color(0x5AF2F2F2),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                item.salesName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        subtitle: Text(
                                                          item.kodeJabatan,
                                                        ),
                                                        onTap: () async {
                                                          List<TextEditingController>
                                                              selectedProspects =
                                                              [];

                                                          for (int i = 0;
                                                              i <
                                                                  checkControllers
                                                                      .length;
                                                              i++) {
                                                            if (checkControllers[
                                                                        i]
                                                                    .text ==
                                                                "1") {
                                                              selectedProspects.add(
                                                                  TextEditingController(
                                                                text:
                                                                    taskControllers[
                                                                            i]
                                                                        .text,
                                                              ));
                                                            }
                                                          }

                                                          for (var controller
                                                              in selectedProspects) {
                                                            print(
                                                                '${controller.text} - ${item.salesName}');
                                                            //   var upSendProspect =
                                                            //       ListSendProspect(
                                                            //     prospectCode:
                                                            //         controller
                                                            //             .text,
                                                            //     salesCode: item
                                                            //         .salesCode,
                                                            //   );
                                                            //   try {
                                                            //     await ref
                                                            //         .read(
                                                            //             updateSendProspectFormProvider)
                                                            //         .onUpdateSendProspect(
                                                            //             upSendProspect);
                                                            //   } catch (e) {
                                                            //     Navigator.of(
                                                            //             context)
                                                            //         .pushAndRemoveUntil(
                                                            //       MaterialPageRoute(
                                                            //         builder:
                                                            //             (context) =>
                                                            //                 const HomePage(),
                                                            //       ),
                                                            //       (route) =>
                                                            //           false,
                                                            //     );

                                                            //     catchError(
                                                            //       context,
                                                            //       e,
                                                            //     );
                                                            //   }
                                                          }
                                                          // Navigator.of(context)
                                                          //     .pushAndRemoveUntil(
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) =>
                                                          //         const HomePage(),
                                                          //   ),
                                                          //   (route) => false,
                                                          // );

                                                          // notifUpdated(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            searchTextController:
                                                searchControllerDrawer,
                                            filter: (query) {
                                              return dataSendTask
                                                  .listReminderGetSales!
                                                  .where(
                                                    (element) =>
                                                        element.salesCode
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()) ||
                                                        element.salesName
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()),
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
                                                    255, 146, 138, 138),
                                              ),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                gapPadding: 15.0,
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    153,
                                                    153,
                                                    153,
                                                  ),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
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
              }),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(
          255,
          253,
          181,
          19,
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
                  final dataSTNK = ref.watch(stnk);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            roles == 'SALESMAN'
                                ? Expanded(
                                    child: dataSTNK.when(
                                      data: (data) => (data.listReminder !=
                                              null)
                                          ? data.listReminder!.isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 20, 20, 0),
                                                  child: SearchableList<
                                                      ListReminder>(
                                                    initialList:
                                                        data.listReminder!,
                                                    itemBuilder: (item) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                            context,
                                                            ReminderSTNKDetailPage
                                                                .routeName,
                                                            arguments: item.iD,
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 10, 0, 10),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 90,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    167,
                                                                    253,
                                                                    183,
                                                                    19,
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
                                                                167,
                                                                235,
                                                                182,
                                                                68,
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
                                                                    alignment:
                                                                        Alignment
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
                                                                            color:
                                                                                Colors.grey,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.grey,
                                                                            ),
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                5,
                                                                                0,
                                                                                5,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              item.statusName,
                                                                              style: textStyleColorWhite,
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
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
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
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
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
                                                                          10),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
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
                                                      return data.listReminder!
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
                                                          255,
                                                          253,
                                                          181,
                                                          19,
                                                        ),
                                                      ),
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        gapPadding: 15.0,
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            253,
                                                            181,
                                                            19,
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
                                          : const notActivetoken(),
                                      error: (err, stack) => Text('Error $err'),
                                      loading: () => const Center(
                                        child: Column(
                                          children: [loadingAnimation()],
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: dataSTNK.when(
                                      data: (dataReminderSTNK) {
                                        listReminderRes.clear();
                                        listReminderRes.add(dataReminderSTNK);

                                        final listReminderSTNK =
                                            dataReminderSTNK.listReminder ?? [];

                                        // Jika checkedItems masih kosong atau lengthnya tidak sesuai, perbarui lengthnya
                                        if (checkedItems.isEmpty ||
                                            checkedItems.length !=
                                                listReminderSTNK.length) {
                                          checkedItems = List<bool>.filled(
                                              listReminderSTNK.length, false);
                                          checkControllers = List.generate(
                                            listReminderSTNK.length,
                                            (index) => TextEditingController(
                                                text: "0"),
                                          );
                                        }

                                        if (taskControllers.isEmpty ||
                                            taskControllers.length !=
                                                listReminderSTNK.length) {
                                          taskControllers = List.generate(
                                            listReminderSTNK.length,
                                            (index) => TextEditingController(
                                              text: listReminderSTNK[index].iD,
                                            ),
                                          );
                                        }

                                        return (dataReminderSTNK.listReminder !=
                                                null)
                                            ? dataReminderSTNK
                                                    .listReminder!.isNotEmpty
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20, 20, 20, 0),
                                                    child: SearchableList<
                                                        ListReminder>(
                                                      initialList:
                                                          dataReminderSTNK
                                                              .listReminder!,
                                                      itemBuilder: (item) {
                                                        if (dataReminderSTNK
                                                                    .listReminder ==
                                                                null ||
                                                            dataReminderSTNK
                                                                .listReminder!
                                                                .isEmpty) {
                                                          return const Center(
                                                            child: Text(
                                                                "Tidak ada data"),
                                                          );
                                                        }

                                                        int index =
                                                            dataReminderSTNK
                                                                .listReminder!
                                                                .indexWhere(
                                                          (element) =>
                                                              element.iD ==
                                                              item.iD,
                                                        );

                                                        if (index == -1 ||
                                                            index >=
                                                                checkedItems
                                                                    .length ||
                                                            index >=
                                                                checkControllers
                                                                    .length) {
                                                          return const SizedBox(); // Hindari error index out of range
                                                        }

                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                              context,
                                                              ReminderSTNKDetailPage
                                                                  .routeName,
                                                              arguments:
                                                                  item.iD,
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    10, 0, 10),
                                                            child: Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                minHeight: 90,
                                                                minWidth: double
                                                                    .infinity,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                      167,
                                                                      253,
                                                                      183,
                                                                      19,
                                                                    ),
                                                                    blurRadius:
                                                                        3.0,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
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
                                                                  167,
                                                                  235,
                                                                  182,
                                                                  68,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      10,
                                                                      0,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        children: <Widget>[
                                                                          Checkbox(
                                                                            activeColor:
                                                                                Colors.white,
                                                                            checkColor:
                                                                                const Color.fromARGB(
                                                                              176,
                                                                              115,
                                                                              184,
                                                                              51,
                                                                            ),
                                                                            side:
                                                                                const BorderSide(color: Colors.white),
                                                                            value: (index < checkedItems.length)
                                                                                ? checkedItems[index]
                                                                                : false,
                                                                            onChanged:
                                                                                (bool? value) {
                                                                              setState(() {
                                                                                if (index < checkControllers.length && index < checkedItems.length) {
                                                                                  checkedItems[index] = value!;
                                                                                  checkControllers[index].text = value ? "1" : "0";
                                                                                  currentIndex = index; // Pastikan currentIndex diperbarui dan tidak hilang setelah rebuild

                                                                                  print("Checkbox diubah: ${dataReminderSTNK.listReminder![index].taskDateView} -> ${checkControllers[index].text}");
                                                                                  print("currentIndex setelah checkbox diklik: $currentIndex");
                                                                                } else {
                                                                                  print("Index tidak valid: $index (checkControllers.length: ${checkControllers.length})");
                                                                                }
                                                                              });
                                                                              Future.delayed(const Duration(milliseconds: 50), () {
                                                                                if (mounted) {
                                                                                  setState(() {});
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              'Check to send',
                                                                              style: textStyleColorWhite,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
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
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            item.policeNumber,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.grey,
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                              ),
                                                                              borderRadius: const BorderRadius.all(
                                                                                Radius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                              child: Text(
                                                                                item.statusName,
                                                                                style: textStyleColorWhite,
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
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
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
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
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
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
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
                                                      filter:
                                                          (searchController) {
                                                        return dataReminderSTNK
                                                            .listReminder!
                                                            .where(
                                                              (element) =>
                                                                  element
                                                                      .custName
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
                                                          TextInputAction
                                                              .search,
                                                      emptyWidget:
                                                          const EmptyView(),
                                                      inputDecoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        labelText: "Search..",
                                                        labelStyle:
                                                            const TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            253,
                                                            181,
                                                            19,
                                                          ),
                                                        ),
                                                        fillColor: Colors.white,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          gapPadding: 15.0,
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              253,
                                                              181,
                                                              19,
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
