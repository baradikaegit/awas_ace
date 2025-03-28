// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/prospectsalesmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProspectSalesBySlsPage extends ConsumerStatefulWidget {
  final Object? linkPageObj;
  const ProspectSalesBySlsPage({super.key, required this.linkPageObj});

  static const String routeName = "/prospectSalesBySlsPage";

  @override
  _ProspectSalesBySlsPageState createState() => _ProspectSalesBySlsPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ProspectSalesBySlsPageState extends ConsumerState<ProspectSalesBySlsPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchControllerDrawer = TextEditingController();
  List<ProspectSalesListResponse> listProspectSalesRes = [];
  List<TextEditingController> prospectCodeControllers = [];

  List<bool> checkedItems = [];
  List<TextEditingController> checkControllers = [];

  int? currentIndex;

  late TabController _tabController;

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? sid;
  String? branchID;
  String? roles;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
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

  void _handleTabSelection() {
    setState(() {});
  }

  String selectedProspectCode = "";

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
      fontWeight: FontWeight.bold,
    );

    var textStyleColorWhiteList = TextStyle(
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
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
    );

    var textStyleColorWhiteBI = TextStyle(
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
              name: TABLET, value: 17.5, landscapeValue: 17.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Prospect Sales",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              // IconButton(
              //   icon: const Icon(Icons.send),
              //   onPressed: _toggleDrawer,
              // ),
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
            elevation: 0,
            backgroundColor: const Color.fromARGB(
              255,
              3,
              116,
              18,
            ),
          ),
          endDrawer: Drawer(
            child: Stack(
              children: [
                Consumer(builder: (context, WidgetRef ref, child) {
                  final dataSales = ref.watch(prospectSales);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  return ref.refresh(prospectSales);
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
                                                ListProspectSales>(
                                              initialList: dataSendTask
                                                  .listProspectSales!,
                                              itemBuilder: (item) {
                                                return item.type == 'List'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minHeight: 20,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0x50D6D6D6),
                                                                blurRadius: 8.0,
                                                                offset: Offset(
                                                                    0, 0),
                                                                spreadRadius:
                                                                    5.1,
                                                              ),
                                                            ],
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xFFDEDEE2),
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            color: const Color(
                                                                0x5AF2F2F2),
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
                                                                      child:
                                                                          Text(
                                                                        item.salesman,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                subtitle: Text(
                                                                    item.prospectStatusName
                                                                    //     Builder(
                                                                    //   builder:
                                                                    //       (context) {
                                                                    //     if (checkControllers
                                                                    //             .isEmpty ||
                                                                    //         prospectCodeControllers
                                                                    //             .isEmpty) {
                                                                    //       return const Text(
                                                                    //           "Pilih item terlebih dahulu");
                                                                    //     }
                                                                    //     List<String>
                                                                    //         selectedProspectCodes =
                                                                    //         [];
                                                                    //     for (int i =
                                                                    //             0;
                                                                    //         i < checkControllers.length;
                                                                    //         i++) {
                                                                    //       if (checkControllers[i]
                                                                    //               .text ==
                                                                    //           "1") {
                                                                    //         selectedProspectCodes
                                                                    //             .add(prospectCodeControllers[i].text);
                                                                    //       }
                                                                    //     }
                                                                    //     return selectedProspectCodes
                                                                    //             .isNotEmpty
                                                                    //         ? Text(
                                                                    //             "1 ${selectedProspectCodes.join(', ')} ")
                                                                    //         : const SizedBox();
                                                                    //   },
                                                                    ),
                                                                onTap:
                                                                    () async {
                                                                  List<TextEditingController>
                                                                      selectedProspects =
                                                                      [];

                                                                  String?
                                                                      checkVal;
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          checkControllers
                                                                              .length;
                                                                      i++) {
                                                                    if (checkControllers[i]
                                                                            .text ==
                                                                        "1") {
                                                                      selectedProspects
                                                                          .add(
                                                                              TextEditingController(
                                                                        text: prospectCodeControllers[i]
                                                                            .text,
                                                                      ));

                                                                      checkVal =
                                                                          checkControllers[i]
                                                                              .text;
                                                                    }
                                                                  }

                                                                  for (var controller
                                                                      in selectedProspects) {
                                                                    var upSendProspect =
                                                                        ListSendProspect(
                                                                      prospectCode:
                                                                          controller
                                                                              .text,
                                                                      salesCode:
                                                                          item.salesCode,
                                                                    );
                                                                    try {
                                                                      //var resp =
                                                                      await ref
                                                                          .read(
                                                                              updateSendProspectFormProvider)
                                                                          .onUpdateSendProspect(
                                                                              upSendProspect);

                                                                      // if (resp.statusMessage ==
                                                                      //     "Success Updated") {
                                                                      //   ketController
                                                                      //       .clear();
                                                                      // }

                                                                      Navigator.of(
                                                                              context)
                                                                          .pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const HomePage(),
                                                                        ),
                                                                        (route) =>
                                                                            false,
                                                                      );

                                                                      notifUpdated(
                                                                          context);
                                                                    } catch (e) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushAndRemoveUntil(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const HomePage(),
                                                                        ),
                                                                        (route) =>
                                                                            false,
                                                                      );

                                                                      catchError(
                                                                        context,
                                                                        e,
                                                                      );
                                                                    }
                                                                    print(
                                                                        checkVal);
                                                                    print(controller
                                                                        .text);
                                                                    print(
                                                                        '${item.salesman} - ${item.salesCode}');
                                                                  }
                                                                },
                                                              ),
                                                              // Column(
                                                              //   children: List.generate(
                                                              //       prospectCodeControllers
                                                              //           .length,
                                                              //       (index) {
                                                              //     if (checkControllers[
                                                              //                 index]
                                                              //             .text ==
                                                              //         "1") {
                                                              //       return Padding(
                                                              //         padding: const EdgeInsets
                                                              //             .symmetric(
                                                              //             vertical:
                                                              //                 4.0),
                                                              //         child:
                                                              //             Visibility(
                                                              //           visible:
                                                              //               false,
                                                              //           child:
                                                              //               TextFormField(
                                                              //             controller:
                                                              //                 prospectCodeControllers[index],
                                                              //             autocorrect:
                                                              //                 false,
                                                              //             style:
                                                              //                 const TextStyle(color: Colors.black),
                                                              //             textInputAction:
                                                              //                 TextInputAction.next,
                                                              //             decoration:
                                                              //                 InputDecoration(
                                                              //               hintText:
                                                              //                   'Prospect Code',
                                                              //               hintStyle:
                                                              //                   textStyleColorWhite,
                                                              //               enabledBorder:
                                                              //                   const OutlineInputBorder(
                                                              //                 borderSide: BorderSide(
                                                              //                   color: Color.fromARGB(255, 0, 0, 0),
                                                              //                 ),
                                                              //               ),
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              //       );
                                                              //     } else {
                                                              //       return const SizedBox
                                                              //           .shrink();
                                                              //     }
                                                              //   }),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const Center();
                                              },
                                              searchTextController:
                                                  searchControllerDrawer,
                                              filter: (query) {
                                                return dataSendTask
                                                    .listProspectSales!
                                                    .where(
                                                      (element) =>
                                                          element.prospectCode
                                                              .toLowerCase()
                                                              .contains(query
                                                                  .toLowerCase()) ||
                                                          element.salesman
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
                                                      255, 255, 255, 255),
                                                ),
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
            134,
            206,
            68,
          ),
          body: Center(
            child: Stack(
              children: [
                const Watermark(),
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    final rptProspectSales =
                        ref.watch(prospectSalesBySls(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(
                                      prospectSalesBySls(linkPageObj),
                                    );
                                  },
                                  child: rptProspectSales.when(
                                    data: (dataProspectSales) {
                                      listProspectSalesRes.clear();
                                      listProspectSalesRes
                                          .add(dataProspectSales);

                                      final listProspect =
                                          dataProspectSales.listProspectSales ??
                                              [];

                                      // Jika checkedItems masih kosong atau ukurannya tidak sesuai, perbarui ukurannya
                                      if (checkedItems.isEmpty ||
                                          checkedItems.length !=
                                              listProspect.length) {
                                        checkedItems = List<bool>.filled(
                                            listProspect.length, false);
                                        checkControllers = List.generate(
                                            listProspect.length,
                                            (index) => TextEditingController(
                                                text: "0"));
                                      }

                                      if (prospectCodeControllers.isEmpty ||
                                          prospectCodeControllers.length !=
                                              listProspect.length) {
                                        prospectCodeControllers = List.generate(
                                          listProspect.length,
                                          (index) => TextEditingController(
                                              text: listProspect[index]
                                                  .prospectCode),
                                        );
                                      }

                                      return (dataProspectSales
                                                  .listProspectSales !=
                                              null)
                                          ? dataProspectSales
                                                  .listProspectSales!.isNotEmpty
                                              ? ListView.builder(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var linkPageObj = widget
                                                        .linkPageObj
                                                        .toString();

                                                    return Column(
                                                      children: [
                                                        ResponsiveRowColumnItem(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    ResponsiveValue<
                                                                        double>(
                                                                  context,
                                                                  conditionalValues: [
                                                                    const Condition
                                                                        .largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          20.0,
                                                                      landscapeValue:
                                                                          20.0,
                                                                      breakpoint:
                                                                          500,
                                                                    ),
                                                                    const Condition
                                                                        .largerThan(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            32.0,
                                                                        landscapeValue:
                                                                            32.0,
                                                                        breakpoint:
                                                                            800),
                                                                  ],
                                                                  defaultValue:
                                                                      19,
                                                                ).value,
                                                                height: 35,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .orange[
                                                                      400],
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.96,
                                                                height: 35,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color.fromARGB(
                                                                          255,
                                                                          40,
                                                                          208,
                                                                          37),
                                                                      Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          185,
                                                                          44),
                                                                      Color.fromARGB(
                                                                          255,
                                                                          175,
                                                                          231,
                                                                          44),
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "ON PROGRESS",
                                                                    style:
                                                                        textStyleColorWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          color:
                                                              Colors.green[700],
                                                          child: Column(
                                                            children: [
                                                              TabBar(
                                                                controller:
                                                                    _tabController,
                                                                dividerHeight:
                                                                    0,
                                                                indicatorColor:
                                                                    Colors
                                                                        .orange,
                                                                labelColor:
                                                                    Colors
                                                                        .white,
                                                                unselectedLabelColor:
                                                                    Colors
                                                                        .white70,
                                                                isScrollable:
                                                                    false,
                                                                indicatorPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 0,
                                                                ),
                                                                labelPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 0,
                                                                ),
                                                                tabs: [
                                                                  for (int i =
                                                                          0;
                                                                      i < 3;
                                                                      i++)
                                                                    dataProspectSales.listProspectSales![i].prospectStatusName ==
                                                                            'HOT'
                                                                        ? _customTab(
                                                                            dataProspectSales.listProspectSales![i].prospectStatus,
                                                                            " \nPELANGGAN \nHOT \nPROSPECT",
                                                                            const Color.fromARGB(
                                                                              255,
                                                                              40,
                                                                              208,
                                                                              37,
                                                                            ),
                                                                          )
                                                                        : dataProspectSales.listProspectSales![i].prospectStatusName ==
                                                                                'MEDIUM'
                                                                            ? _customTab(
                                                                                dataProspectSales.listProspectSales![i].prospectStatus,
                                                                                " \nPELANGGAN \nMEDIUM \nPROSPECT",
                                                                                const Color.fromARGB(
                                                                                  255,
                                                                                  106,
                                                                                  185,
                                                                                  44,
                                                                                ),
                                                                              )
                                                                            : _customTab(
                                                                                dataProspectSales.listProspectSales![i].prospectStatus,
                                                                                " \nPELANGGAN \nLOW \nPROSPECT",
                                                                                const Color.fromARGB(
                                                                                  255,
                                                                                  175,
                                                                                  231,
                                                                                  44,
                                                                                ),
                                                                              ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height -
                                                              Scaffold.of(
                                                                      context)
                                                                  .appBarMaxHeight! -
                                                              kToolbarHeight -
                                                              16,
                                                          child: TabBarView(
                                                            controller:
                                                                _tabController,
                                                            children: <Widget>[
                                                              HotProspectTab(
                                                                linkPageObj:
                                                                    linkPageObj,
                                                              ),
                                                              // MediumProspectTab(
                                                              //   linkPageObj:
                                                              //       linkPageObj,
                                                              // ),
                                                              Column(),

                                                              SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        50,
                                                                        0,
                                                                      ),
                                                                      child:
                                                                          SfCircularChart(
                                                                        tooltipBehavior:
                                                                            TooltipBehavior(
                                                                          enable:
                                                                              true,
                                                                        ),
                                                                        annotations: [
                                                                          CircularChartAnnotation(
                                                                            widget:
                                                                                Text(
                                                                              textAlign: TextAlign.center,
                                                                              "${dataProspectSales.listProspectSales![4].prospectStatusName} \nPROSPECT",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: ResponsiveValue<double>(
                                                                                  context,
                                                                                  conditionalValues: [
                                                                                    const Condition.equals(name: TABLET, value: 12.0, landscapeValue: 12.0),
                                                                                    const Condition.largerThan(name: TABLET, value: 25.0, landscapeValue: 25.0, breakpoint: 800),
                                                                                  ],
                                                                                  defaultValue: 10.0,
                                                                                ).value,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                        legend:
                                                                            const Legend(
                                                                          iconWidth:
                                                                              25,
                                                                          isVisible:
                                                                              true,
                                                                          width:
                                                                              '300%',
                                                                          itemPadding:
                                                                              0,
                                                                          position:
                                                                              LegendPosition.right,
                                                                          overflowMode:
                                                                              LegendItemOverflowMode.scroll,
                                                                          textStyle:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        series: <CircularSeries>[
                                                                          DoughnutSeries<
                                                                              ChartData,
                                                                              String>(
                                                                            dataSource:
                                                                                toDynamic(listProspectSalesRes[0].listProspectSales!),
                                                                            legendIconType:
                                                                                LegendIconType.rectangle,
                                                                            xValueMapper: (ChartData data, _) =>
                                                                                data.x,
                                                                            yValueMapper: (ChartData data, _) =>
                                                                                data.y,
                                                                            pointColorMapper: (ChartData data, _) => data.x == 'Comunnity'
                                                                                ? data.colorCommunity
                                                                                : data.x == 'Walk In Customer'
                                                                                    ? data.colorWalkIn
                                                                                    : data.x == 'Mobile/canvasing'
                                                                                        ? data.colorMobileCanvasing
                                                                                        : data.x == 'Reference'
                                                                                            ? data.colorReference
                                                                                            : data.x == 'Moving Exhibition'
                                                                                                ? data.colorMovingEx
                                                                                                : data.x == 'Call In'
                                                                                                    ? data.colorCallin
                                                                                                    : data.x == 'Database'
                                                                                                        ? data.colorDatabase
                                                                                                        : data.x == 'Iklan & Media Sosial'
                                                                                                            ? data.colorIklanMedia
                                                                                                            : data.x == 'Repeat Order Retail'
                                                                                                                ? data.colorRepeatOrderRetail
                                                                                                                : data.colorRepeatOrderFleet,
                                                                            innerRadius:
                                                                                '60%',
                                                                            radius:
                                                                                '70%',
                                                                            explode:
                                                                                true,
                                                                            explodeGesture:
                                                                                ActivationMode.singleTap,
                                                                            explodeOffset:
                                                                                '5',
                                                                            dataLabelSettings:
                                                                                const DataLabelSettings(
                                                                              showZeroValue: false,
                                                                              isVisible: false,
                                                                              labelAlignment: ChartDataLabelAlignment.middle,
                                                                              overflowMode: OverflowMode.trim,
                                                                              textStyle: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height -
                                                                          Scaffold.of(context)
                                                                              .appBarMaxHeight! -
                                                                          kToolbarHeight -
                                                                          16,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            20,
                                                                            0,
                                                                            20,
                                                                            130),
                                                                        child:
                                                                            SearchableList(
                                                                          textStyle:
                                                                              const TextStyle(color: Colors.white),
                                                                          initialList:
                                                                              dataProspectSales.listProspectSales!,
                                                                          itemBuilder:
                                                                              (item) {
                                                                            // int currentIndex =
                                                                            //     dataProspectSales.listProspectSales!.indexOf(item);

                                                                            if (dataProspectSales.listProspectSales == null ||
                                                                                dataProspectSales.listProspectSales!.isEmpty) {
                                                                              return const Center(
                                                                                child: Text("Tidak ada data"),
                                                                              );
                                                                            }

                                                                            int index =
                                                                                dataProspectSales.listProspectSales!.indexWhere(
                                                                              (element) => element.prospectCode == item.prospectCode,
                                                                            );

                                                                            if (index == -1 ||
                                                                                index >= checkedItems.length ||
                                                                                index >= checkControllers.length) {
                                                                              return const SizedBox(); // Hindari error index out of range
                                                                            }

                                                                            return item.type == 'List' && item.prospectStatusName == 'LOW'
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(
                                                                                      0,
                                                                                      10,
                                                                                      0,
                                                                                      10,
                                                                                    ),
                                                                                    child: Container(
                                                                                      constraints: const BoxConstraints(
                                                                                        minHeight: 160,
                                                                                        minWidth: double.infinity,
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                        boxShadow: const [
                                                                                          BoxShadow(
                                                                                            color: Color.fromARGB(
                                                                                              176,
                                                                                              115,
                                                                                              184,
                                                                                              51,
                                                                                            ),
                                                                                            blurRadius: 3.0,
                                                                                            offset: Offset(0, 0),
                                                                                            spreadRadius: 1.1,
                                                                                          ),
                                                                                        ],
                                                                                        border: Border.all(color: Colors.transparent, width: 2),
                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                      ),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                              0,
                                                                                              0,
                                                                                              10,
                                                                                              0,
                                                                                            ),
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Row(
                                                                                                children: <Widget>[
                                                                                                  Checkbox(
                                                                                                    activeColor: Colors.white,
                                                                                                    checkColor: const Color.fromARGB(
                                                                                                      176,
                                                                                                      115,
                                                                                                      184,
                                                                                                      51,
                                                                                                    ),
                                                                                                    side: const BorderSide(color: Colors.white),
                                                                                                    value: (index < checkedItems.length) ? checkedItems[index] : false,
                                                                                                    onChanged: (bool? value) {
                                                                                                      setState(() {
                                                                                                        if (index < checkControllers.length && index < checkedItems.length) {
                                                                                                          checkedItems[index] = value!;
                                                                                                          checkControllers[index].text = value ? "1" : "0";
                                                                                                          currentIndex = index; // Pastikan currentIndex diperbarui dan tidak hilang setelah rebuild

                                                                                                          print("Checkbox diubah: ${dataProspectSales.listProspectSales![index].prospectCode} -> ${checkControllers[index].text}");
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
                                                                                                    child: Text(
                                                                                                      'Check to send',
                                                                                                      style: textStyleColorWhiteList,
                                                                                                      maxLines: 2,
                                                                                                      overflow: TextOverflow.ellipsis,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    item.prospectCode,
                                                                                                    style: textStyleColorWhiteBI,
                                                                                                  ),
                                                                                                  Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.grey,
                                                                                                      border: Border.all(color: Colors.grey),
                                                                                                      borderRadius: const BorderRadius.all(
                                                                                                        Radius.circular(10.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                                      child: Text(
                                                                                                        item.prospectDate,
                                                                                                        style: textStyleColorWhiteList,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Text(
                                                                                                item.customerName,
                                                                                                style: textStyleColorWhiteList,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Text(
                                                                                                item.meetingPoint,
                                                                                                style: textStyleColorWhiteList,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : const Center();
                                                                          },
                                                                          searchTextController:
                                                                              searchController,
                                                                          filter:
                                                                              (searchController) {
                                                                            return dataProspectSales.listProspectSales!
                                                                                .where(
                                                                                  (element) =>
                                                                                      element.customerName.toLowerCase().contains(
                                                                                            searchController.toString().toLowerCase(),
                                                                                          ) ||
                                                                                      element.prospectCode.toLowerCase().contains(
                                                                                            searchController.toString().toLowerCase(),
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
                                                                                const EdgeInsets.symmetric(horizontal: 8.0),
                                                                            labelText:
                                                                                "Search..",
                                                                            labelStyle:
                                                                                const TextStyle(
                                                                              color: Color.fromARGB(255, 102, 107, 94),
                                                                            ),
                                                                            fillColor:
                                                                                Colors.white,
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              gapPadding: 15.0,
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(255, 91, 97, 83),
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void notifUpdated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ("Success Updated" == "Success Updated")
            ? Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text(("Success Updated" == "Success Updated")
            ? "Send Berhasil"
            : "Send Gagal"),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _customTab(String labelH, String label, Color backgroundColor) {
    return SizedBox(
      height: 150,
      child: Tab(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: labelH,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HotProspectTab extends StatefulWidget {
  final Object? linkPageObj;
  const HotProspectTab({super.key, required this.linkPageObj});

  @override
  State<HotProspectTab> createState() => _HotProspectTabState();
}

class _HotProspectTabState extends State<HotProspectTab> {
  List<ProspectSalesListResponse> listProspectSalesRes = [];
  TextEditingController searchController = TextEditingController();

  List<TextEditingController> prospectCodeControllers = [];
  List<bool> checkedItems = [];
  List<TextEditingController> checkControllers = [];

  bool checkQ1 = false;

  String? roles;

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      roles = prefs.getString('Roles');
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhiteBI = TextStyle(
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
              name: TABLET, value: 17.5, landscapeValue: 17.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
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
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
    );
    return Consumer(
      builder: (context, ref, child) {
        var linkPageObj = widget.linkPageObj.toString();

        final rptProspectSalesGrafik =
            ref.watch(prospectSalesBySls(linkPageObj));

        return Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: rptProspectSalesGrafik.when(
                      data: (dataGrafik) {
                        listProspectSalesRes.clear();
                        listProspectSalesRes.add(dataGrafik);
                        final listProspect = dataGrafik.listProspectSales ?? [];

                        // Jika checkedItems masih kosong atau ukurannya tidak sesuai, perbarui ukurannya
                        if (checkedItems.isEmpty ||
                            checkedItems.length != listProspect.length) {
                          checkedItems =
                              List<bool>.filled(listProspect.length, false);
                          checkControllers = List.generate(listProspect.length,
                              (index) => TextEditingController(text: "0"));
                        }

                        if (prospectCodeControllers.isEmpty ||
                            prospectCodeControllers.length !=
                                listProspect.length) {
                          prospectCodeControllers = List.generate(
                            listProspect.length,
                            (index) => TextEditingController(
                                text: listProspect[index].prospectCode),
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    50,
                                    0,
                                  ),
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Text(
                                          textAlign: TextAlign.center,
                                          "${dataGrafik.listProspectSales![4].prospectStatusName} \nPROSPECT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 25.0,
                                                    landscapeValue: 25.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 10.0,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    legend: const Legend(
                                      iconWidth: 25,
                                      isVisible: true,
                                      width: '300%',
                                      itemPadding: 0,
                                      position: LegendPosition.right,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll,
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: toDynamic(
                                            listProspectSalesRes[0]
                                                .listProspectSales!),
                                        legendIconType:
                                            LegendIconType.rectangle,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) => data
                                                    .x ==
                                                'Comunnity'
                                            ? data.colorCommunity
                                            : data.x == 'Walk In Customer'
                                                ? data.colorWalkIn
                                                : data.x == 'Mobile/canvasing'
                                                    ? data.colorMobileCanvasing
                                                    : data.x == 'Reference'
                                                        ? data.colorReference
                                                        : data.x ==
                                                                'Moving Exhibition'
                                                            ? data.colorMovingEx
                                                            : data.x ==
                                                                    'Call In'
                                                                ? data
                                                                    .colorCallin
                                                                : data.x ==
                                                                        'Database'
                                                                    ? data
                                                                        .colorDatabase
                                                                    : data.x ==
                                                                            'Iklan & Media Sosial'
                                                                        ? data
                                                                            .colorIklanMedia
                                                                        : data.x ==
                                                                                'Repeat Order Retail'
                                                                            ? data.colorRepeatOrderRetail
                                                                            : data.colorRepeatOrderFleet,
                                        innerRadius: '60%',
                                        radius: '70%',
                                        explode: true,
                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          showZeroValue: false,
                                          isVisible: false,
                                          labelAlignment:
                                              ChartDataLabelAlignment.middle,
                                          overflowMode: OverflowMode.trim,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      Scaffold.of(context).appBarMaxHeight! -
                                      kToolbarHeight -
                                      16,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 130),
                                    child: SearchableList(
                                      initialList:
                                          dataGrafik.listProspectSales!,
                                      itemBuilder: (item) {
                                        int currentIndex = dataGrafik
                                            .listProspectSales!
                                            .indexOf(item);
                                        return item.type == 'List' &&
                                                item.prospectStatusName == 'HOT'
                                            ? Padding(
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
                                                    minHeight: 110,
                                                    minWidth: double.infinity,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            176, 115, 184, 51),
                                                        blurRadius: 3.0,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.1,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
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
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Checkbox(
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                checkColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                  176,
                                                                  115,
                                                                  184,
                                                                  51,
                                                                ),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                value: checkedItems[
                                                                    currentIndex],
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkedItems[
                                                                            currentIndex] =
                                                                        value!;

                                                                    checkControllers[currentIndex]
                                                                            .text =
                                                                        value
                                                                            ? "1"
                                                                            : "0";
                                                                  });
                                                                },
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  'Check to send',
                                                                  style:
                                                                      textStyleColorWhite,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              checkControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Check',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              prospectCodeControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Prospect Code',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.prospectCode,
                                                                style:
                                                                    textStyleColorWhiteBI,
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    item.prospectDate,
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
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.customerName,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.meetingPoint,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const Center();
                                      },
                                      searchTextController: searchController,
                                      filter: (searchController) {
                                        return dataGrafik.listProspectSales!
                                            .where(
                                              (element) =>
                                                  element.salesman
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ) ||
                                                  element.prospectStatusName
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ),
                                            )
                                            .toList();
                                      },
                                      keyboardAction: TextInputAction.search,
                                      emptyWidget: const EmptyView(),
                                      inputDecoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                        labelText: "Search..",
                                        labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 102, 107, 94),
                                        ),
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 15.0,
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 91, 97, 83),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class MediumProspectTab extends StatefulWidget {
  final Object? linkPageObj;
  const MediumProspectTab({super.key, required this.linkPageObj});

  @override
  State<MediumProspectTab> createState() => _MediumProspectTabState();
}

class _MediumProspectTabState extends State<MediumProspectTab> {
  List<ProspectSalesListResponse> listProspectSalesRes = [];
  TextEditingController searchController = TextEditingController();

  List<TextEditingController> prospectCodeControllers = [];
  List<bool> checkedItems = [];
  List<TextEditingController> checkControllers = [];

  bool checkQ1 = false;

  String? roles;

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      roles = prefs.getString('Roles');
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhiteBI = TextStyle(
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
              name: TABLET, value: 17.5, landscapeValue: 17.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
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
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
    );
    return Consumer(
      builder: (context, ref, child) {
        var linkPageObj = widget.linkPageObj.toString();
        final rptProspectSalesGrafik =
            ref.watch(prospectSalesBySls(linkPageObj));

        return Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: rptProspectSalesGrafik.when(
                      data: (dataGrafik) {
                        listProspectSalesRes.clear();
                        listProspectSalesRes.add(dataGrafik);

                        final listProspect = dataGrafik.listProspectSales ?? [];

                        // Jika checkedItems masih kosong atau ukurannya tidak sesuai, perbarui ukurannya
                        if (checkedItems.isEmpty ||
                            checkedItems.length != listProspect.length) {
                          checkedItems =
                              List<bool>.filled(listProspect.length, false);
                          checkControllers = List.generate(listProspect.length,
                              (index) => TextEditingController(text: "0"));
                        }

                        if (prospectCodeControllers.isEmpty ||
                            prospectCodeControllers.length !=
                                listProspect.length) {
                          prospectCodeControllers = List.generate(
                            listProspect.length,
                            (index) => TextEditingController(
                                text: listProspect[index].prospectCode),
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    50,
                                    0,
                                  ),
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Text(
                                          textAlign: TextAlign.center,
                                          "${dataGrafik.listProspectSales![4].prospectStatusName} \nPROSPECT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 25.0,
                                                    landscapeValue: 25.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 10.0,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    legend: const Legend(
                                      iconWidth: 25,
                                      isVisible: true,
                                      width: '300%',
                                      itemPadding: 0,
                                      position: LegendPosition.right,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll,
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: toDynamic(
                                            listProspectSalesRes[0]
                                                .listProspectSales!),
                                        legendIconType:
                                            LegendIconType.rectangle,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) => data
                                                    .x ==
                                                'Comunnity'
                                            ? data.colorCommunity
                                            : data.x == 'Walk In Customer'
                                                ? data.colorWalkIn
                                                : data.x == 'Mobile/canvasing'
                                                    ? data.colorMobileCanvasing
                                                    : data.x == 'Reference'
                                                        ? data.colorReference
                                                        : data.x ==
                                                                'Moving Exhibition'
                                                            ? data.colorMovingEx
                                                            : data.x ==
                                                                    'Call In'
                                                                ? data
                                                                    .colorCallin
                                                                : data.x ==
                                                                        'Database'
                                                                    ? data
                                                                        .colorDatabase
                                                                    : data.x ==
                                                                            'Iklan & Media Sosial'
                                                                        ? data
                                                                            .colorIklanMedia
                                                                        : data.x ==
                                                                                'Repeat Order Retail'
                                                                            ? data.colorRepeatOrderRetail
                                                                            : data.colorRepeatOrderFleet,
                                        innerRadius: '60%',
                                        radius: '70%',
                                        explode: true,
                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          showZeroValue: false,
                                          isVisible: false,
                                          labelAlignment:
                                              ChartDataLabelAlignment.middle,
                                          overflowMode: OverflowMode.trim,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      Scaffold.of(context).appBarMaxHeight! -
                                      kToolbarHeight -
                                      16,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 130),
                                    child: SearchableList(
                                      initialList:
                                          dataGrafik.listProspectSales!,
                                      itemBuilder: (item) {
                                        int currentIndex = dataGrafik
                                            .listProspectSales!
                                            .indexOf(item);
                                        return item.type == 'List' &&
                                                item.prospectStatusName ==
                                                    'MEDIUM'
                                            ? Padding(
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
                                                    minHeight: 110,
                                                    minWidth: double.infinity,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            176, 115, 184, 51),
                                                        blurRadius: 3.0,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.1,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    // color: const Color.fromARGB(
                                                    //     176, 130, 131, 128),
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
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Checkbox(
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                checkColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                  176,
                                                                  115,
                                                                  184,
                                                                  51,
                                                                ),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                value: checkedItems[
                                                                    currentIndex],
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkedItems[
                                                                            currentIndex] =
                                                                        value!;

                                                                    checkControllers[currentIndex]
                                                                            .text =
                                                                        value
                                                                            ? "1"
                                                                            : "0";
                                                                  });
                                                                },
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  'Check to send',
                                                                  style:
                                                                      textStyleColorWhite,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              checkControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Check',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              prospectCodeControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Prospect Code',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.prospectCode,
                                                                style:
                                                                    textStyleColorWhiteBI,
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    item.prospectDate,
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
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.customerName,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.meetingPoint,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const Center();
                                      },
                                      searchTextController: searchController,
                                      filter: (searchController) {
                                        return dataGrafik.listProspectSales!
                                            .where(
                                              (element) =>
                                                  element.customerName
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ) ||
                                                  element.prospectCode
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ),
                                            )
                                            .toList();
                                      },
                                      keyboardAction: TextInputAction.search,
                                      emptyWidget: const EmptyView(),
                                      inputDecoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                        labelText: "Search..",
                                        labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 102, 107, 94),
                                        ),
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 15.0,
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 91, 97, 83),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class LowProspectTab extends StatefulWidget {
  final Object? linkPageObj;
  final List<TextEditingController> checkControllers; // Menerima dari parent

  const LowProspectTab(
      {super.key, required this.linkPageObj, required this.checkControllers});

  @override
  State<LowProspectTab> createState() => _LowProspectTabState();
}

class _LowProspectTabState extends State<LowProspectTab> {
  List<ProspectSalesListResponse> listProspectSalesRes = [];
  TextEditingController searchController = TextEditingController();

  List<TextEditingController> prospectCodeControllers = [];
  List<bool> checkedItems = [];
  List<TextEditingController> checkControllers = [];

  List<ListProspectSales> selectedProspects = [];

  bool checkQ1 = false;

  String? roles;

  @override
  void initState() {
    super.initState();
    // checkController.text = '0';
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      roles = prefs.getString('Roles');
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhiteBI = TextStyle(
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
              name: TABLET, value: 17.5, landscapeValue: 17.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
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
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 10.5,
      ).value,
    );
    return Consumer(
      builder: (context, ref, child) {
        var linkPageObj = widget.linkPageObj.toString();

        final rptProspectSalesGrafik =
            ref.watch(prospectSalesBySls(linkPageObj));
        return Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: rptProspectSalesGrafik.when(
                      data: (dataGrafik) {
                        listProspectSalesRes.clear();
                        listProspectSalesRes.add(dataGrafik);

                        final listProspect = dataGrafik.listProspectSales ?? [];

                        // Jika checkedItems masih kosong atau ukurannya tidak sesuai, perbarui ukurannya
                        if (checkedItems.isEmpty ||
                            checkedItems.length != listProspect.length) {
                          checkedItems =
                              List<bool>.filled(listProspect.length, false);
                          checkControllers = List.generate(listProspect.length,
                              (index) => TextEditingController(text: "0"));
                        }

                        if (prospectCodeControllers.isEmpty ||
                            prospectCodeControllers.length !=
                                listProspect.length) {
                          prospectCodeControllers = List.generate(
                            listProspect.length,
                            (index) => TextEditingController(
                                text: listProspect[index].prospectCode),
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    50,
                                    0,
                                  ),
                                  child: SfCircularChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Text(
                                          textAlign: TextAlign.center,
                                          "${dataGrafik.listProspectSales![4].prospectStatusName} \nPROSPECT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                    name: TABLET,
                                                    value: 12.0,
                                                    landscapeValue: 12.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 25.0,
                                                    landscapeValue: 25.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 10.0,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    legend: const Legend(
                                      iconWidth: 25,
                                      isVisible: true,
                                      width: '300%',
                                      itemPadding: 0,
                                      position: LegendPosition.right,
                                      overflowMode:
                                          LegendItemOverflowMode.scroll,
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: toDynamic(
                                            listProspectSalesRes[0]
                                                .listProspectSales!),
                                        legendIconType:
                                            LegendIconType.rectangle,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) => data
                                                    .x ==
                                                'Comunnity'
                                            ? data.colorCommunity
                                            : data.x == 'Walk In Customer'
                                                ? data.colorWalkIn
                                                : data.x == 'Mobile/canvasing'
                                                    ? data.colorMobileCanvasing
                                                    : data.x == 'Reference'
                                                        ? data.colorReference
                                                        : data.x ==
                                                                'Moving Exhibition'
                                                            ? data.colorMovingEx
                                                            : data.x ==
                                                                    'Call In'
                                                                ? data
                                                                    .colorCallin
                                                                : data.x ==
                                                                        'Database'
                                                                    ? data
                                                                        .colorDatabase
                                                                    : data.x ==
                                                                            'Iklan & Media Sosial'
                                                                        ? data
                                                                            .colorIklanMedia
                                                                        : data.x ==
                                                                                'Repeat Order Retail'
                                                                            ? data.colorRepeatOrderRetail
                                                                            : data.colorRepeatOrderFleet,
                                        innerRadius: '60%',
                                        radius: '70%',
                                        explode: true,
                                        explodeGesture:
                                            ActivationMode.singleTap,
                                        explodeOffset: '5',
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          showZeroValue: false,
                                          isVisible: false,
                                          labelAlignment:
                                              ChartDataLabelAlignment.middle,
                                          overflowMode: OverflowMode.trim,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      Scaffold.of(context).appBarMaxHeight! -
                                      kToolbarHeight -
                                      16,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 130),
                                    child: SearchableList(
                                      initialList:
                                          dataGrafik.listProspectSales!,
                                      itemBuilder: (item) {
                                        int currentIndex = dataGrafik
                                            .listProspectSales!
                                            .indexOf(item);
                                        return item.type == 'List' &&
                                                item.prospectStatusName == 'LOW'
                                            ? Padding(
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
                                                    minHeight: 160,
                                                    minWidth: double.infinity,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                          176,
                                                          115,
                                                          184,
                                                          51,
                                                        ),
                                                        blurRadius: 3.0,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.1,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
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
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Checkbox(
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                checkColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                  176,
                                                                  115,
                                                                  184,
                                                                  51,
                                                                ),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                value: checkedItems[
                                                                    currentIndex],
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    // checkedItems[
                                                                    //         currentIndex] =
                                                                    //     value!;

                                                                    // checkControllers[currentIndex]
                                                                    //         .text =
                                                                    //     value
                                                                    //         ? "1"
                                                                    //         : "0";
                                                                    // print(
                                                                    //     "Checkbox diubah: ${item.prospectCode} -> ${checkControllers[index].text}");
                                                                    if (currentIndex <
                                                                        checkControllers
                                                                            .length) {
                                                                      checkedItems[
                                                                              currentIndex] =
                                                                          value!;
                                                                      checkControllers[currentIndex]
                                                                              .text =
                                                                          value
                                                                              ? "1"
                                                                              : "0";

                                                                      print(
                                                                          "Checkbox diubah: ${item.prospectCode} -> ${checkControllers[currentIndex].text}");
                                                                    } else {
                                                                      print(
                                                                          "Indeks $currentIndex tidak valid!");
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  'Check to send',
                                                                  style:
                                                                      textStyleColorWhite,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              checkControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Check',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: TextFormField(
                                                          controller:
                                                              prospectCodeControllers[
                                                                  currentIndex],
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Prospect Code',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.prospectCode,
                                                                style:
                                                                    textStyleColorWhiteBI,
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    item.prospectDate,
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
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.customerName,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.meetingPoint,
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const Center();
                                      },
                                      searchTextController: searchController,
                                      filter: (searchController) {
                                        return dataGrafik.listProspectSales!
                                            .where(
                                              (element) =>
                                                  element.customerName
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ) ||
                                                  element.prospectCode
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController
                                                            .toString()
                                                            .toLowerCase(),
                                                      ),
                                            )
                                            .toList();
                                      },
                                      keyboardAction: TextInputAction.search,
                                      emptyWidget: const EmptyView(),
                                      inputDecoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                        labelText: "Search..",
                                        labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 102, 107, 94),
                                        ),
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 15.0,
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 91, 97, 83),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChartData {
  String x;
  int y;
  Color colorCommunity;
  Color colorWalkIn;
  Color colorMobileCanvasing;
  Color colorReference;
  Color colorMovingEx;
  Color colorCallin;
  Color colorDatabase;
  Color colorIklanMedia;
  Color colorRepeatOrderRetail;
  Color colorRepeatOrderFleet;

  ChartData(
    this.x,
    this.y,
    this.colorCommunity,
    this.colorWalkIn,
    this.colorMobileCanvasing,
    this.colorReference,
    this.colorMovingEx,
    this.colorCallin,
    this.colorDatabase,
    this.colorIklanMedia,
    this.colorRepeatOrderRetail,
    this.colorRepeatOrderFleet,
  );
}

dynamic toDynamic(List<ListProspectSales> objList) {
  List<ChartData> doughnutData = [];

  for (var i = 1; i < objList.length + 1; i++) {
    if (objList[objList.length - i].type == 'Grafik') {
      doughnutData.add(
        ChartData(
          objList[objList.length - i].referensi,
          int.parse(objList[objList.length - i].prospectStatus),
          const Color.fromARGB(183, 84, 0, 92),
          const Color.fromARGB(185, 255, 238, 2),
          const Color.fromARGB(192, 241, 144, 15),
          const Color.fromARGB(192, 0, 119, 83),
          const Color.fromARGB(192, 77, 159, 192),
          const Color.fromARGB(184, 131, 122, 1),
          const Color.fromARGB(184, 25, 26, 41),
          const Color.fromARGB(184, 255, 0, 0),
          const Color.fromARGB(184, 255, 255, 255),
          const Color.fromARGB(184, 156, 146, 146),
        ),
      );
    }
  }
  return doughnutData;
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
