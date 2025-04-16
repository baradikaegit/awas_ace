// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/profile_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamSayaPage extends StatefulWidget {
  const TeamSayaPage({super.key});

  static const String routeName = "/teamSayaPage";

  @override
  State<TeamSayaPage> createState() => _TeamSayaPageState();
}

class _TeamSayaPageState extends State<TeamSayaPage> {
  Widget titleBar = const Text(
    "Team Saya",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(
            255,
            17,
            157,
            144,
          ),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(
          255,
          17,
          157,
          144,
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
                  final dataProfile = ref.watch(getProfileTeam);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: dataProfile.when(
                                data: (dataProfileTeam) => (dataProfileTeam
                                            .listGetProfileTeam !=
                                        null)
                                    ? dataProfileTeam
                                            .listGetProfileTeam!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            child: SearchableList<
                                                ListGetProfileTeam>(
                                              initialList: dataProfileTeam
                                                  .listGetProfileTeam!,
                                              itemBuilder: (item) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minHeight: 90,
                                                      minWidth: double.infinity,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                            167,
                                                            33,
                                                            167,
                                                            153,
                                                          ),
                                                          blurRadius: 3.0,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 1.1,
                                                        ),
                                                      ],
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color:
                                                          const Color.fromARGB(
                                                        167,
                                                        17,
                                                        157,
                                                        144,
                                                      ),
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
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          subtitle: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 8,
                                                                  ),
                                                                  child: Text(
                                                                    '',
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
                                                                        right:
                                                                            8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  border: Border
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          2,
                                                                          5,
                                                                          2),
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.assignment_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                ResponsiveValue<double>(
                                                                              context,
                                                                              conditionalValues: [
                                                                                const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                                const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                              ],
                                                                              defaultValue: 12.0,
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
                                                                              defaultValue: 12.0,
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
                                                                        right:
                                                                            8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  border: Border
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          2,
                                                                          5,
                                                                          2),
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.assignment_turned_in_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                ResponsiveValue<double>(
                                                                              context,
                                                                              conditionalValues: [
                                                                                const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                                const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                              ],
                                                                              defaultValue: 12.0,
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
                                                                              defaultValue: 12.0,
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
                                                                  color: Colors
                                                                      .grey,
                                                                  border: Border
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          2,
                                                                          5,
                                                                          2),
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.attach_money_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                ResponsiveValue<double>(
                                                                              context,
                                                                              conditionalValues: [
                                                                                const Condition.equals(name: TABLET, value: 14.0, landscapeValue: 14.0),
                                                                                const Condition.largerThan(name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
                                                                              ],
                                                                              defaultValue: 12.0,
                                                                            ).value,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              " ${item.totalStatus3.toString()}",
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
                                                                              defaultValue: 12.0,
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              searchTextController:
                                                  searchController,
                                              filter: (searchController) {
                                                return dataProfileTeam
                                                    .listGetProfileTeam!
                                                    .where(
                                                      (element) =>
                                                          element.salesName
                                                              .toLowerCase()
                                                              .contains(
                                                                searchController
                                                                    .toString()
                                                                    .toLowerCase(),
                                                              ) ||
                                                          element.totalStatus1
                                                              .toString()
                                                              .contains(
                                                                searchController
                                                                    .toString()
                                                                    .toLowerCase(),
                                                              ) ||
                                                          element.totalStatus2
                                                              .toString()
                                                              .contains(
                                                                searchController
                                                                    .toString()
                                                                    .toLowerCase(),
                                                              ) ||
                                                          element.totalStatus3
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
                                              emptyWidget: const EmptyView(),
                                              inputDecoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                labelText: "Search..",
                                                labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    17,
                                                    157,
                                                    144,
                                                  ),
                                                ),
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  gapPadding: 15.0,
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                      255,
                                                      17,
                                                      157,
                                                      144,
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
                            )
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
