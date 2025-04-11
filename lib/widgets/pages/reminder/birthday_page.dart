// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/reminder_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/remindergetsalesmodel.dart';
import 'package:awas_ace/widgets/model/remindermodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:awas_ace/widgets/pages/reminder/birthdaydetail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderBirthdayPage extends StatefulWidget {
  const ReminderBirthdayPage({super.key});

  static const String routeName = "/reminderBirthdayPage";

  @override
  State<ReminderBirthdayPage> createState() => _ReminderBirthdayPageState();
}

class _ReminderBirthdayPageState extends State<ReminderBirthdayPage> {
  Widget titleBar = const Text(
    "Birthday",
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
            90,
            1,
            181,
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
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  right: 8,
                                                                ),
                                                                child: Text(
                                                                  item.kodeJabatan,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        5,
                                                                        2,
                                                                        5,
                                                                        2),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .assignment_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            " ${item.totalStatus1.toString()}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255,
                                                                          ),
                                                                          fontSize:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        5,
                                                                        2,
                                                                        5,
                                                                        2),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .assignment_turned_in_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            " ${item.totalStatus2.toString()}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255,
                                                                          ),
                                                                          fontSize:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        5,
                                                                        2,
                                                                        5,
                                                                        2),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .attach_money_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            "0",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255,
                                                                          ),
                                                                          fontSize:
                                                                              ResponsiveValue<double>(
                                                                            context,
                                                                            conditionalValues: [
                                                                              const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                              const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                            ],
                                                                            defaultValue:
                                                                                12.0,
                                                                          ).value,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        onTap: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              title: Text(
                                                                "Send Task",
                                                                style:
                                                                    TextStyle(
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
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              25.0,
                                                                          landscapeValue:
                                                                              25.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        12.0,
                                                                  ).value,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              content: Text(
                                                                "Task ini akan dikirim ke ${item.salesName.toUpperCase()}",
                                                                style:
                                                                    TextStyle(
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
                                                                              14.5,
                                                                          landscapeValue:
                                                                              14.5),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        12.0,
                                                                  ).value,
                                                                ),
                                                              ),
                                                              actionsPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 0,
                                                              ),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        side: BorderSide
                                                                            .none,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "BATAL",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF119D90),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    OutlinedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        List<TextEditingController>
                                                                            selectedProspects =
                                                                            [];

                                                                        for (int i =
                                                                                0;
                                                                            i < checkControllers.length;
                                                                            i++) {
                                                                          if (checkControllers[i].text ==
                                                                              "1") {
                                                                            selectedProspects.add(TextEditingController(
                                                                              text: taskControllers[i].text,
                                                                            ));
                                                                          }
                                                                        }

                                                                        int successCount =
                                                                            0;
                                                                        int failCount =
                                                                            0;

                                                                        for (var controller
                                                                            in selectedProspects) {
                                                                          String
                                                                              taskStatusACEID =
                                                                              '';
                                                                          String
                                                                              taskBranch =
                                                                              '';
                                                                          String
                                                                              taskView =
                                                                              '';

                                                                          final reminderState =
                                                                              ref.read(birthday);

                                                                          if (reminderState
                                                                              is AsyncData) {
                                                                            final list =
                                                                                reminderState.value?.listReminder ?? [];
                                                                            try {
                                                                              final match = list.firstWhere((e) => e.iD == controller.text);
                                                                              taskStatusACEID = match.taskStatusACEID;
                                                                              taskBranch = match.taskBranchID;
                                                                              taskView = match.taskView;
                                                                            } catch (_) {}
                                                                          }

                                                                          // print(
                                                                          //   '${controller.text} - $taskStatusACEID - $taskBranch - ${item.salesCode} - Send By $taskView to ${item.salesCode}',
                                                                          // );

                                                                          String
                                                                              taskNote =
                                                                              'Send By $taskView to ${item.salesCode}';

                                                                          var upSendTask =
                                                                              ListSendTask(
                                                                            iD: controller.text,
                                                                            taskStatusACEID:
                                                                                taskStatusACEID,
                                                                            taskBranchID:
                                                                                taskBranch,
                                                                            taskView:
                                                                                item.salesCode,
                                                                            taskNote:
                                                                                taskNote,
                                                                          );

                                                                          try {
                                                                            await ref.read(updateSendTaskFormProvider).onUpdateSendTask(upSendTask);
                                                                            successCount++;
                                                                          } catch (e) {
                                                                            failCount++;
                                                                          }
                                                                        }
                                                                        Navigator.of(context)
                                                                            .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage(),
                                                                          ),
                                                                          (route) =>
                                                                              false,
                                                                        );

                                                                        if (successCount >
                                                                                0 &&
                                                                            failCount ==
                                                                                0) {
                                                                          notifUpdated(
                                                                              context,
                                                                              "Send Berhasil",
                                                                              true);
                                                                        } else if (successCount >
                                                                                0 &&
                                                                            failCount >
                                                                                0) {
                                                                          notifUpdated(
                                                                              context,
                                                                              "Send sebagian berhasil, Send sebagian gagal",
                                                                              false);
                                                                        } else {
                                                                          notifUpdated(
                                                                              context,
                                                                              "Send gagal dikirim",
                                                                              false);
                                                                        }
                                                                      },
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        side: BorderSide
                                                                            .none,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "KIRIM",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF119D90),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
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
          90,
          1,
          181,
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
                  final databirthday = ref.watch(birthday);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            roles == 'SALESMAN'
                                ? Expanded(
                                    child: databirthday.when(
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
                                                            ReminderBirthdayDetailPage
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
                                                              minHeight: 70,
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
                                                                    91,
                                                                    1,
                                                                    181,
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
                                                                90,
                                                                1,
                                                                181,
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
                                                                          item.taskDateView,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey,
                                                                            border:
                                                                                Border.all(color: Colors.grey),
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
                                                          90,
                                                          1,
                                                          181,
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
                                                            90,
                                                            1,
                                                            181,
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
                                    child: databirthday.when(
                                      data: (dataReminderBirthday) {
                                        listReminderRes.clear();
                                        listReminderRes
                                            .add(dataReminderBirthday);

                                        final listReminderBirhtday =
                                            dataReminderBirthday.listReminder ??
                                                [];

                                        // Jika checkedItems masih kosong atau lengthnya tidak sesuai, perbarui lengthnya
                                        if (checkedItems.isEmpty ||
                                            checkedItems.length !=
                                                listReminderBirhtday.length) {
                                          checkedItems = List<bool>.filled(
                                              listReminderBirhtday.length,
                                              false);
                                          checkControllers = List.generate(
                                            listReminderBirhtday.length,
                                            (index) => TextEditingController(
                                                text: "0"),
                                          );
                                        }

                                        if (taskControllers.isEmpty ||
                                            taskControllers.length !=
                                                listReminderBirhtday.length) {
                                          taskControllers = List.generate(
                                            listReminderBirhtday.length,
                                            (index) => TextEditingController(
                                              text: listReminderBirhtday[index]
                                                  .iD,
                                            ),
                                          );
                                        }

                                        return (dataReminderBirthday
                                                    .listReminder !=
                                                null)
                                            ? dataReminderBirthday
                                                    .listReminder!.isNotEmpty
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20, 20, 20, 0),
                                                    child: SearchableList<
                                                        ListReminder>(
                                                      initialList:
                                                          dataReminderBirthday
                                                              .listReminder!,
                                                      itemBuilder: (item) {
                                                        if (dataReminderBirthday
                                                                    .listReminder ==
                                                                null ||
                                                            dataReminderBirthday
                                                                .listReminder!
                                                                .isEmpty) {
                                                          return const Center(
                                                            child: Text(
                                                                "Tidak ada data"),
                                                          );
                                                        }

                                                        int index =
                                                            dataReminderBirthday
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
                                                              ReminderBirthdayDetailPage
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
                                                                minHeight: 70,
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
                                                                      91,
                                                                      1,
                                                                      181,
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
                                                                  90,
                                                                  1,
                                                                  181,
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

                                                                                  // print("Checkbox diubah: ${dataReminderBirthday.listReminder![index].taskStatusACEID} -> ${checkControllers[index].text}");
                                                                                  // print("currentIndex setelah checkbox diklik: $currentIndex");
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
                                                                            item.taskDateView,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.grey,
                                                                              border: Border.all(color: Colors.grey),
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
                                                        return dataReminderBirthday
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
                                                            90,
                                                            1,
                                                            181,
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
                                                              90,
                                                              1,
                                                              181,
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
