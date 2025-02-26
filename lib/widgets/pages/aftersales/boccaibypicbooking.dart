import 'package:awas_ace/provider/reportaftersales_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BocCaiByPicBookingPage extends StatefulWidget {
  final Object? linkPageObj;
  const BocCaiByPicBookingPage({super.key, required this.linkPageObj});

  static const String routeName = "/bocCaiByPicBookingPage";
  @override
  State<BocCaiByPicBookingPage> createState() => _BocCaiByPicBookingPageState();
}

class ModelMonth {
  String value;
  int id;
  ModelMonth(this.value, this.id);
}

class _BocCaiByPicBookingPageState extends State<BocCaiByPicBookingPage> {
  Widget titleBar = const Text(
    "BOC & CAI By PIC Booking",
    style: TextStyle(color: Colors.white),
  );

  String? userName;
  String? roles;
  String? sid;
  String? branchID;

  List<String> tipePeriodeOptions = ['MTD', 'YTD'];
  List<ModelMonth> monthOptions = [
    ModelMonth('January', 1),
    ModelMonth('February', 2),
    ModelMonth('March', 3),
    ModelMonth('April', 4),
    ModelMonth('May', 5),
    ModelMonth('June', 6),
    ModelMonth('July', 7),
    ModelMonth('August', 8),
    ModelMonth('September', 9),
    ModelMonth('October', 10),
    ModelMonth('November', 11),
    ModelMonth('December', 12)
  ];
  List<String> yearOPtions = [
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.utc(DateTime.now().year - 1))
  ];

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Name');
      roles = prefs.getString('Roles');
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorGold = TextStyle(
      color: const Color.fromARGB(255, 248, 172, 8),
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
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
              color: Color.fromARGB(255, 33, 44, 81),
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

                    String monthNow = DateFormat('M').format(DateTime.now());
                    String yearNow = DateFormat('yyyy').format(DateTime.now());
                    final String dateNow =
                        DateFormat('dd MMMM yyyy').format(DateTime.now());

                    final rptBocCai =
                        ref.watch(reportBocCaiByPicBooking(linkPageObj));

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                                child: SizedBox(
                                  child: rptBocCai.when(
                                    data: (dataSelectOpt) {
                                      if (dataSelectOpt
                                              .listRptAfterSalesBocCaiByPICBooking !=
                                          null) {
                                        String tipePeriode = dataSelectOpt
                                                .listRptAfterSalesBocCaiByPICBooking!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? 'MTD'
                                                : dataSelectOpt
                                                    .listRptAfterSalesBocCaiByPICBooking![
                                                        0]
                                                    .periodTipe
                                            : '';

                                        String monthSelected = dataSelectOpt
                                                .listRptAfterSalesBocCaiByPICBooking!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('M')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptAfterSalesBocCaiByPICBooking![
                                                        0]
                                                    .month
                                                    .toString()
                                            : '';

                                        String yearSelected = dataSelectOpt
                                                .listRptAfterSalesBocCaiByPICBooking!
                                                .isNotEmpty
                                            ? (linkPageObj ==
                                                    '$monthNow/$yearNow')
                                                ? DateFormat('yyyy')
                                                    .format(DateTime.now())
                                                : dataSelectOpt
                                                    .listRptAfterSalesBocCaiByPICBooking![
                                                        0]
                                                    .year
                                                    .toString()
                                            : '';

                                        return Column(
                                          children: [
                                            AppBar(
                                              automaticallyImplyLeading: false,
                                              centerTitle: false,
                                              title: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 15, 0, 0),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value: tipePeriode,
                                                            isExpanded: false,
                                                            items: tipePeriodeOptions
                                                                .map((String
                                                                    valueTipePeriode) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    valueTipePeriode,
                                                                child: Text(
                                                                  valueTipePeriode,
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValTp) {
                                                              setState(
                                                                () {
                                                                  tipePeriode =
                                                                      newValTp!;
                                                                  var monthNow =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesBocCaiByPICBooking![
                                                                              0]
                                                                          .month;
                                                                  var yearNow =
                                                                      dataSelectOpt
                                                                          .listRptAfterSalesBocCaiByPICBooking![
                                                                              0]
                                                                          .year;

                                                                  var linkResultPeriodTipe =
                                                                      '$monthNow/$yearNow/$tipePeriode';

                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                    context,
                                                                    BocCaiByPicBookingPage
                                                                        .routeName,
                                                                    arguments:
                                                                        linkResultPeriodTipe,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  33,
                                                                  44,
                                                                  81,
                                                                ),
                                                              ),
                                                              maxHeight: 250,
                                                              offset:
                                                                  const Offset(
                                                                      0, 0),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                radius:
                                                                    const Radius
                                                                        .circular(
                                                                        40),
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all(5),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            true),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          0,
                                                          15,
                                                          0,
                                                          0,
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            isExpanded: false,
                                                            items: monthOptions
                                                                .map(
                                                                    (valueMonth) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: valueMonth
                                                                    .id
                                                                    .toString(),
                                                                child: Text(
                                                                  valueMonth
                                                                      .value,
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            value:
                                                                monthSelected,
                                                            onChanged: (String?
                                                                newValMonth) {
                                                              setState(() {
                                                                monthSelected =
                                                                    newValMonth!;
                                                                var yearNow =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesBocCaiByPICBooking![
                                                                            0]
                                                                        .year;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesBocCaiByPICBooking![
                                                                            0]
                                                                        .periodTipe;

                                                                var linkResultMonth =
                                                                    '$monthSelected/$yearNow/$periodTipe';

                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  BocCaiByPicBookingPage
                                                                      .routeName,
                                                                  arguments:
                                                                      linkResultMonth,
                                                                );
                                                              });
                                                            },
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  33,
                                                                  44,
                                                                  81,
                                                                ),
                                                              ),
                                                              maxHeight: 250,
                                                              offset:
                                                                  const Offset(
                                                                      0, 0),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                radius:
                                                                    const Radius
                                                                        .circular(
                                                                        40),
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all(5),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            true),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          0,
                                                          15,
                                                          15,
                                                          0,
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value: yearSelected,
                                                            isExpanded: false,
                                                            items: yearOPtions
                                                                .map((String
                                                                    valueYear) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    valueYear,
                                                                child: Text(
                                                                  valueYear,
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValYear) {
                                                              setState(() {
                                                                yearSelected =
                                                                    newValYear!;
                                                                var monthNow =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesBocCaiByPICBooking![
                                                                            0]
                                                                        .month;
                                                                var periodTipe =
                                                                    dataSelectOpt
                                                                        .listRptAfterSalesBocCaiByPICBooking![
                                                                            0]
                                                                        .periodTipe;

                                                                var linkResultYear =
                                                                    '$monthNow/$yearSelected/$periodTipe';

                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  BocCaiByPicBookingPage
                                                                      .routeName,
                                                                  arguments:
                                                                      linkResultYear,
                                                                );
                                                              });
                                                            },
                                                            dropdownStyleData:
                                                                const DropdownStyleData(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  33,
                                                                  44,
                                                                  81,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                                              centerTitle: true,
                                              title: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                      0,
                                                      5,
                                                      0,
                                                      0,
                                                    ),
                                                    child: Text(
                                                      "BOC & CAI By PIC Booking",
                                                      style:
                                                          textStyleColorWhiteB,
                                                    ),
                                                  ),
                                                ],
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
                                                        "Periode : ${dataSelectOpt.listRptAfterSalesBocCaiByPICBooking![0].monthID} ${dataSelectOpt.listRptAfterSalesBocCaiByPICBooking![0].year}",
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
                                                                      12.0),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.0,
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
                                                                  value: 12.0,
                                                                  landscapeValue:
                                                                      12.0),
                                                              const Condition
                                                                  .largerThan(
                                                                  name: TABLET,
                                                                  value: 12.5,
                                                                  landscapeValue:
                                                                      12.5,
                                                                  breakpoint:
                                                                      800),
                                                            ],
                                                            defaultValue: 11.0,
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
                                        );
                                      }
                                      return null;
                                    },
                                    error: (err, stack) => Text('Error $err'),
                                    loading: () =>
                                        const Center(child: Text('')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return ref.refresh(reportBocCaiByPicBooking(
                                        linkPageObj.toString()));
                                  },
                                  child: rptBocCai.when(
                                    data: (dataBocCai) {
                                      var gContacted = dataBocCai
                                          .listRptAfterSalesBocCaiByPICBooking![
                                              0]
                                          .persenContacted;
                                      var gBoc = dataBocCai
                                          .listRptAfterSalesBocCaiByPICBooking![
                                              0]
                                          .persenBoc;
                                      var gCai = dataBocCai
                                          .listRptAfterSalesBocCaiByPICBooking![
                                              0]
                                          .persenCai;

                                      return (dataBocCai
                                                  .listRptAfterSalesBocCaiByPICBooking !=
                                              null)
                                          ? dataBocCai
                                                  .listRptAfterSalesBocCaiByPICBooking!
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
                                                                  .fromLTRB(
                                                            5,
                                                            20,
                                                            5,
                                                            0,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 200,
                                                                width: 220,
                                                                child:
                                                                    SfRadialGauge(
                                                                  enableLoadingAnimation:
                                                                      true,
                                                                  animationDuration:
                                                                      4500,
                                                                  axes: <RadialAxis>[
                                                                    RadialAxis(
                                                                      axisLineStyle:
                                                                          const AxisLineStyle(
                                                                        thicknessUnit:
                                                                            GaugeSizeUnit.factor,
                                                                        thickness:
                                                                            0.08,
                                                                      ),
                                                                      majorTickStyle:
                                                                          const MajorTickStyle(
                                                                        length:
                                                                            8,
                                                                        thickness:
                                                                            2,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      minorTickStyle:
                                                                          const MinorTickStyle(
                                                                        length:
                                                                            4,
                                                                        thickness:
                                                                            2,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      axisLabelStyle:
                                                                          const GaugeTextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      labelsPosition:
                                                                          ElementsPosition
                                                                              .inside,
                                                                      useRangeColorForAxis:
                                                                          true,
                                                                      minimum:
                                                                          0,
                                                                      maximum:
                                                                          100,
                                                                      interval:
                                                                          25.0,
                                                                      labelOffset:
                                                                          15,
                                                                      showLastLabel:
                                                                          true,
                                                                      ranges: <GaugeRange>[
                                                                        GaugeRange(
                                                                          startWidth:
                                                                              4,
                                                                          endWidth:
                                                                              4,
                                                                          startValue:
                                                                              0,
                                                                          endValue:
                                                                              20,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              0,
                                                                              211,
                                                                              165),
                                                                        ),
                                                                        GaugeRange(
                                                                          startWidth:
                                                                              4,
                                                                          endWidth:
                                                                              4,
                                                                          startValue:
                                                                              20,
                                                                          endValue:
                                                                              40,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              0,
                                                                              148,
                                                                              116),
                                                                        ),
                                                                        GaugeRange(
                                                                          startWidth:
                                                                              4,
                                                                          endWidth:
                                                                              4,
                                                                          startValue:
                                                                              40,
                                                                          endValue:
                                                                              60,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              245,
                                                                              204,
                                                                              101),
                                                                        ),
                                                                        GaugeRange(
                                                                          startWidth:
                                                                              4,
                                                                          endWidth:
                                                                              4,
                                                                          startValue:
                                                                              60,
                                                                          endValue:
                                                                              80,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              247,
                                                                              182,
                                                                              3),
                                                                        ),
                                                                        GaugeRange(
                                                                            startWidth:
                                                                                4,
                                                                            endWidth:
                                                                                4,
                                                                            startValue:
                                                                                80,
                                                                            endValue:
                                                                                100,
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                250,
                                                                                84,
                                                                                7)),
                                                                      ],
                                                                      pointers: <GaugePointer>[
                                                                        NeedlePointer(
                                                                          value:
                                                                              gContacted.toDouble(),
                                                                          needleLength:
                                                                              0.95,
                                                                          enableAnimation:
                                                                              true,
                                                                          animationType:
                                                                              AnimationType.ease,
                                                                          needleStartWidth:
                                                                              0.3,
                                                                          needleEndWidth:
                                                                              6,
                                                                          needleColor: gContacted < 20
                                                                              ? const Color.fromARGB(255, 0, 211, 165)
                                                                              : gContacted < 40
                                                                                  ? const Color.fromARGB(255, 0, 148, 116)
                                                                                  : gContacted < 60
                                                                                      ? const Color.fromARGB(255, 245, 206, 101)
                                                                                      : gContacted < 60
                                                                                          ? const Color.fromARGB(255, 247, 182, 3)
                                                                                          : const Color.fromARGB(255, 250, 84, 7),
                                                                          knobStyle:
                                                                              KnobStyle(
                                                                            knobRadius:
                                                                                0.1,
                                                                            color: gContacted < 20
                                                                                ? const Color.fromARGB(255, 0, 211, 165)
                                                                                : gContacted < 40
                                                                                    ? const Color.fromARGB(255, 0, 148, 116)
                                                                                    : gContacted < 60
                                                                                        ? const Color.fromARGB(255, 245, 206, 101)
                                                                                        : gContacted < 60
                                                                                            ? const Color.fromARGB(255, 247, 182, 3)
                                                                                            : const Color.fromARGB(255, 250, 84, 7),
                                                                          ),
                                                                        )
                                                                      ],
                                                                      annotations: <GaugeAnnotation>[
                                                                        GaugeAnnotation(
                                                                          widget:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              RichText(
                                                                                textAlign: TextAlign.center,
                                                                                text: TextSpan(
                                                                                  text: 'Contacted \n',
                                                                                  style: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                  children: [
                                                                                    const WidgetSpan(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                      ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: '${gContacted.toString()}%',
                                                                                      style: const TextStyle(
                                                                                        color: Color.fromARGB(
                                                                                          185,
                                                                                          255,
                                                                                          238,
                                                                                          2,
                                                                                        ),
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          positionFactor:
                                                                              0.4,
                                                                          angle:
                                                                              90,
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: 220,
                                                                    child:
                                                                        SfRadialGauge(
                                                                      enableLoadingAnimation:
                                                                          true,
                                                                      animationDuration:
                                                                          4500,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                          axisLineStyle:
                                                                              const AxisLineStyle(
                                                                            thicknessUnit:
                                                                                GaugeSizeUnit.factor,
                                                                            thickness:
                                                                                0.08,
                                                                          ),
                                                                          majorTickStyle:
                                                                              const MajorTickStyle(
                                                                            length:
                                                                                8,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          minorTickStyle:
                                                                              const MinorTickStyle(
                                                                            length:
                                                                                4,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          axisLabelStyle:
                                                                              const GaugeTextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          labelsPosition:
                                                                              ElementsPosition.inside,
                                                                          useRangeColorForAxis:
                                                                              true,
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              100,
                                                                          interval:
                                                                              25.0,
                                                                          labelOffset:
                                                                              15,
                                                                          showLastLabel:
                                                                              true,
                                                                          ranges: <GaugeRange>[
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 0,
                                                                              endValue: 20,
                                                                              color: const Color.fromARGB(255, 0, 211, 165),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 20,
                                                                              endValue: 40,
                                                                              color: const Color.fromARGB(255, 0, 148, 116),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 40,
                                                                              endValue: 60,
                                                                              color: const Color.fromARGB(255, 245, 204, 101),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 60,
                                                                              endValue: 80,
                                                                              color: const Color.fromARGB(255, 247, 182, 3),
                                                                            ),
                                                                            GaugeRange(
                                                                                startWidth: 4,
                                                                                endWidth: 4,
                                                                                startValue: 80,
                                                                                endValue: 100,
                                                                                color: const Color.fromARGB(255, 250, 84, 7)),
                                                                          ],
                                                                          pointers: <GaugePointer>[
                                                                            NeedlePointer(
                                                                              value: gBoc.toDouble(),
                                                                              needleLength: 0.95,
                                                                              enableAnimation: true,
                                                                              animationType: AnimationType.ease,
                                                                              needleStartWidth: 0.3,
                                                                              needleEndWidth: 6,
                                                                              needleColor: gBoc < 20
                                                                                  ? const Color.fromARGB(255, 0, 211, 165)
                                                                                  : gBoc < 40
                                                                                      ? const Color.fromARGB(255, 0, 148, 116)
                                                                                      : gBoc < 60
                                                                                          ? const Color.fromARGB(255, 245, 206, 101)
                                                                                          : gBoc < 60
                                                                                              ? const Color.fromARGB(255, 247, 182, 3)
                                                                                              : const Color.fromARGB(255, 250, 84, 7),
                                                                              knobStyle: KnobStyle(
                                                                                knobRadius: 0.1,
                                                                                color: gBoc < 20
                                                                                    ? const Color.fromARGB(255, 0, 211, 165)
                                                                                    : gBoc < 40
                                                                                        ? const Color.fromARGB(255, 0, 148, 116)
                                                                                        : gBoc < 60
                                                                                            ? const Color.fromARGB(255, 245, 206, 101)
                                                                                            : gBoc < 60
                                                                                                ? const Color.fromARGB(255, 247, 182, 3)
                                                                                                : const Color.fromARGB(255, 250, 84, 7),
                                                                              ),
                                                                            )
                                                                          ],
                                                                          annotations: <GaugeAnnotation>[
                                                                            GaugeAnnotation(
                                                                              widget: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                      text: 'BOC \n',
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      children: [
                                                                                        const WidgetSpan(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: '${gBoc.toString()}%',
                                                                                          style: const TextStyle(
                                                                                            color: Color.fromARGB(
                                                                                              185,
                                                                                              255,
                                                                                              238,
                                                                                              2,
                                                                                            ),
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              positionFactor: 0.4,
                                                                              angle: 90,
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: 220,
                                                                    child:
                                                                        SfRadialGauge(
                                                                      enableLoadingAnimation:
                                                                          true,
                                                                      animationDuration:
                                                                          4500,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                          axisLineStyle:
                                                                              const AxisLineStyle(
                                                                            thicknessUnit:
                                                                                GaugeSizeUnit.factor,
                                                                            thickness:
                                                                                0.08,
                                                                          ),
                                                                          majorTickStyle:
                                                                              const MajorTickStyle(
                                                                            length:
                                                                                8,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          minorTickStyle:
                                                                              const MinorTickStyle(
                                                                            length:
                                                                                4,
                                                                            thickness:
                                                                                2,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          axisLabelStyle:
                                                                              const GaugeTextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          labelsPosition:
                                                                              ElementsPosition.inside,
                                                                          useRangeColorForAxis:
                                                                              true,
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              100,
                                                                          interval:
                                                                              25.0,
                                                                          labelOffset:
                                                                              15,
                                                                          showLastLabel:
                                                                              true,
                                                                          ranges: <GaugeRange>[
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 0,
                                                                              endValue: 20,
                                                                              color: const Color.fromARGB(255, 0, 211, 165),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 20,
                                                                              endValue: 40,
                                                                              color: const Color.fromARGB(255, 0, 148, 116),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 40,
                                                                              endValue: 60,
                                                                              color: const Color.fromARGB(255, 245, 204, 101),
                                                                            ),
                                                                            GaugeRange(
                                                                              startWidth: 4,
                                                                              endWidth: 4,
                                                                              startValue: 60,
                                                                              endValue: 80,
                                                                              color: const Color.fromARGB(255, 247, 182, 3),
                                                                            ),
                                                                            GaugeRange(
                                                                                startWidth: 4,
                                                                                endWidth: 4,
                                                                                startValue: 80,
                                                                                endValue: 100,
                                                                                color: const Color.fromARGB(255, 250, 84, 7)),
                                                                          ],
                                                                          pointers: <GaugePointer>[
                                                                            NeedlePointer(
                                                                              value: gCai.toDouble(),
                                                                              needleLength: 0.95,
                                                                              enableAnimation: true,
                                                                              animationType: AnimationType.ease,
                                                                              needleStartWidth: 0.3,
                                                                              needleEndWidth: 6,
                                                                              needleColor: gCai < 20
                                                                                  ? const Color.fromARGB(255, 0, 211, 165)
                                                                                  : gCai < 40
                                                                                      ? const Color.fromARGB(255, 0, 148, 116)
                                                                                      : gCai < 60
                                                                                          ? const Color.fromARGB(255, 245, 206, 101)
                                                                                          : gCai < 60
                                                                                              ? const Color.fromARGB(255, 247, 182, 3)
                                                                                              : const Color.fromARGB(255, 250, 84, 7),
                                                                              knobStyle: KnobStyle(
                                                                                knobRadius: 0.1,
                                                                                color: gCai < 20
                                                                                    ? const Color.fromARGB(255, 0, 211, 165)
                                                                                    : gCai < 40
                                                                                        ? const Color.fromARGB(255, 0, 148, 116)
                                                                                        : gCai < 60
                                                                                            ? const Color.fromARGB(255, 245, 206, 101)
                                                                                            : gCai < 60
                                                                                                ? const Color.fromARGB(255, 247, 182, 3)
                                                                                                : const Color.fromARGB(255, 250, 84, 7),
                                                                              ),
                                                                            )
                                                                          ],
                                                                          annotations: <GaugeAnnotation>[
                                                                            GaugeAnnotation(
                                                                              widget: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                      text: 'CAI \n',
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      children: [
                                                                                        const WidgetSpan(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: '${gCai.toString()}%',
                                                                                          style: const TextStyle(
                                                                                            color: Color.fromARGB(
                                                                                              185,
                                                                                              255,
                                                                                              238,
                                                                                              2,
                                                                                            ),
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              positionFactor: 0.4,
                                                                              angle: 90,
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            10,
                                                            20,
                                                            10,
                                                            20,
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 600,
                                                              minWidth: double
                                                                  .infinity,
                                                            ),
                                                            child: DataTable(
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
                                                                            .topLeft,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "CABANG",
                                                                          style:
                                                                              textStyleColorWhiteB,
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
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 60,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "DATA",
                                                                        style:
                                                                            textStyleColorWhiteB,
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
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CONNECTED",
                                                                        style:
                                                                            textStyleColorWhiteB,
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
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CONTACTED",
                                                                        style:
                                                                            textStyleColorWhiteB,
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
                                                                            .topCenter,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 70,
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        "CAI",
                                                                        style:
                                                                            textStyleColorWhiteB,
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
                                                                dataBocCai
                                                                    .listRptAfterSalesBocCaiByPICBooking!
                                                                    .length,
                                                                (indexObj) {
                                                                  final dataRptBocCai =
                                                                      dataBocCai
                                                                              .listRptAfterSalesBocCaiByPICBooking![
                                                                          indexObj];

                                                                  var textStyleDataTable =
                                                                      TextStyle(
                                                                    color: dataBocCai.listRptAfterSalesBocCaiByPICBooking![indexObj].headerCode ==
                                                                            'TOTAL'
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255,
                                                                          )
                                                                        : Colors
                                                                            .blue,
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
                                                                        InkWell(
                                                                          onTap: dataBocCai.listRptAfterSalesBocCaiByPICBooking![indexObj].headerCode == 'TOTAL'
                                                                              ? () {}
                                                                              : () {
                                                                                  var linkPage = dataBocCai.listRptAfterSalesBocCaiByPICBooking![indexObj].linkPage.toString();

                                                                                  print(linkPage);

                                                                                  // Navigator.pushNamed(
                                                                                  //   context,
                                                                                  //   BocCaiBySalesSSPage.routeName,
                                                                                  //   arguments: linkPage,
                                                                                  // );
                                                                                },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 10,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              dataRptBocCai.headerCode,
                                                                              style: textStyleDataTable,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            dataRptBocCai.data1.toString(),
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
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptBocCai.contacted.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptBocCai.persenContacted}%)', style: textStyleColorGold),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptBocCai.boc.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptBocCai.persenBoc}%)', style: textStyleColorGold),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              text: dataRptBocCai.cai.toString(),
                                                                              style: textStyleColorWhite,
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: '(${dataRptBocCai.persenCai}%)', style: textStyleColorGold),
                                                                              ],
                                                                            ),
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
                const Watermark(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
