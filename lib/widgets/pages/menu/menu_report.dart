import 'package:awas_ace/support/watermark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List menuRolesSales = [
    'Funneling',
    'Prospek Valid vs SPK',
    'BOC & CAI SBE By Sales',
    'Prospect UE BP vs UE BP',
    'Monitoring Area Mapping',
    'Monitoring Volume Maker',
    'Monitoring Profit Maker',
    'DO to Gatepass',
    'Gatepass to SBI',
    'Target Sales vs Actual',
    'Monitoring FOA & PMA',
    'Total Stock By Model',
  ];

  List imageSales = [
    'funneling_1.png',
    'prospek.png',
    'boccai.png',
    'prospek.png',
    'areamapping.png',
    'volumemaker.png',
    'profitmaker.png',
    'gatepass.png',
    'gatepass.png',
    'targetsales.png',
    'foampa.png',
    'stockbymodel.png',
  ];

  List linkPageSales = [
    '/funnelingPage',
    '/prospekVtoSpkPage',
    '/bocCaiSBEPage',
    '/prospekUeBPPage',
    '/monitAreaMappingPage',
    '/monitAreaVolumeMakerPage',
    '/monitProfitMakerPage',
    '/dOtoGatePassPage',
    '/gatePasstoSBIPage',
    '/targetSalesActualPage',
    '/',
    '/stockByModelPage',
  ];

  List menuRolesASGR = [
    'Funneling',
    'Prospek SA GR VS Validity',
    'BOC & CAI By PIC Booking',
    'Prospect Ratio from GR to UE BP',
    'TMS Productivity',
    'Boooking Show',
  ];

  List imageASGR = [
    'funneling_1.png',
    'prospek.png',
    'boccai.png',
    'prospek.png',
    'svc.png',
    'bookingshow.png'
  ];

  List linkPageASGR = ['/', '/', '/', '/', '/', '/'];

  List menuRolesBP = [
    'Funneling',
    'Prospek SA BP & Receiver VS Validity',
    'BOC & CAI By SA BP & Receiver',
    'Prospect Ratio from BP to UE GR',
    'Daihatsu GR Contributon to UE BP',
  ];

  List imageBP = [
    'funneling_1.png',
    'prospek.png',
    'boccai.png',
    'prospek.png',
    'contributor.png',
  ];

  List linkPageBP = ['/', '/', '/', '/', '/'];

  List menuRolesGeneral = [
    'Monitoring Poin',
    'Monitoring Redeem',
    'Monitoring Saldo'
  ];

  List imageGeneral = [
    'monitoringpoin.png',
    'monitoringredeem.png',
    'monitoringsaldo.png'
  ];

  List linkPageGeneral = ['/', '/', '/'];

  String? roles;

  final String _monthNow = DateFormat('M').format(DateTime.now());
  final String _yearNow = DateFormat('yyyy').format(DateTime.now());

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        3,
        116,
        18,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Stack(
          children: [
            const Watermark(),
            ListView(
              padding: const EdgeInsets.only(top: 10.0),
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SALES",
                              style: TextStyle(
                                fontSize: ResponsiveValue(
                                  context,
                                  conditionalValues: [
                                    const Condition.equals(
                                      name: TABLET,
                                      value: 16.5,
                                      landscapeValue: 18.5,
                                    ),
                                    const Condition.largerThan(
                                      name: TABLET,
                                      value: 16.5,
                                      landscapeValue: 16.5,
                                    ),
                                  ],
                                  defaultValue: 14.5,
                                ).value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimationLimiter(
                        child: GridView.builder(
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveValue<int>(
                              context,
                              conditionalValues: [
                                const Condition.equals(
                                  name: TABLET,
                                  value: 4,
                                  landscapeValue: 4,
                                ),
                                const Condition.largerThan(
                                  name: TABLET,
                                  value: 4,
                                  landscapeValue: 4,
                                  breakpoint: 800,
                                ),
                              ],
                              defaultValue: 4,
                            ).value,
                            childAspectRatio: 5 / 6,
                          ),
                          shrinkWrap: true,
                          itemCount: menuRolesSales.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              duration: const Duration(milliseconds: 1500),
                              position: index,
                              columnCount: 2,
                              child: FlipAnimation(
                                child: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    linkPageSales[index],
                                    arguments: linkPageSales[index] ==
                                                '/funnelingPage' ||
                                            linkPageSales[index] ==
                                                '/prospekVtoSpkPage' ||
                                            linkPageSales[index] ==
                                                '/prospekUeBPPage' ||
                                            linkPageSales[index] ==
                                                '/targetSalesActualPage' ||
                                            linkPageSales[index] ==
                                                '/dOtoGatePassPage'
                                        ? '$_monthNow/$_yearNow/MTD'
                                        : null,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        radius: ResponsiveValue<double>(
                                          context,
                                          conditionalValues: [
                                            const Condition.equals(
                                              name: TABLET,
                                              value: 35,
                                              landscapeValue: 55,
                                            ),
                                            const Condition.largerThan(
                                              name: TABLET,
                                              value: 35,
                                              landscapeValue: 55,
                                              breakpoint: 800,
                                            ),
                                            const Condition.equals(
                                              name: DESKTOP,
                                              value: 75,
                                              landscapeValue: 75,
                                            ),
                                            const Condition.largerThan(
                                              name: DESKTOP,
                                              value: 75,
                                              landscapeValue: 75,
                                              breakpoint: 1920,
                                            ),
                                          ],
                                          defaultValue: 30,
                                        ).value,
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    0, 49, 49, 49),
                                                blurRadius: 5.0,
                                                offset: Offset(0, 0),
                                                spreadRadius: 2.1,
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.transparent,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                0, 255, 255, 255),
                                          ),
                                          padding: const EdgeInsets.all(0.0),
                                          child: Image.asset(
                                            'assets/images/menu/${imageSales[index]}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 5, 0),
                                        child: Center(
                                          child: Text(
                                            menuRolesSales[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ResponsiveValue<double>(
                                                context,
                                                conditionalValues: [
                                                  const Condition.equals(
                                                    name: TABLET,
                                                    value: 10.5,
                                                    landscapeValue: 14.5,
                                                  ),
                                                  const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 10.5,
                                                    landscapeValue: 14.5,
                                                  ),
                                                ],
                                                defaultValue: 10.0,
                                              ).value,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(43, 49, 49, 49),
                                  blurRadius: 2.0,
                                  offset: Offset(0, -3),
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "AFTER SALES GR",
                                  style: TextStyle(
                                    fontSize: ResponsiveValue(
                                      context,
                                      conditionalValues: [
                                        const Condition.equals(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 18.5,
                                        ),
                                        const Condition.largerThan(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 16.5,
                                        ),
                                      ],
                                      defaultValue: 14.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimationLimiter(
                            child: GridView.builder(
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveValue<int>(
                                  context,
                                  conditionalValues: [
                                    const Condition.equals(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                    ),
                                    const Condition.largerThan(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                      breakpoint: 800,
                                    ),
                                  ],
                                  defaultValue: 4,
                                ).value,
                                childAspectRatio: 5 / 6,
                              ),
                              shrinkWrap: true,
                              itemCount: menuRolesASGR.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  duration: const Duration(milliseconds: 1500),
                                  position: index,
                                  columnCount: 2,
                                  child: FlipAnimation(
                                    child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, linkPageASGR[index]),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    0, 255, 255, 255),
                                            radius: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                ),
                                                const Condition.largerThan(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                  breakpoint: 800,
                                                ),
                                                const Condition.equals(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                ),
                                                const Condition.largerThan(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                  breakpoint: 1920,
                                                ),
                                              ],
                                              defaultValue: 30,
                                            ).value,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      0,
                                                      49,
                                                      49,
                                                      49,
                                                    ),
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 2.1,
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                  242,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Image.asset(
                                                'assets/images/menu/${imageASGR[index]}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 10, 5, 0),
                                            child: Center(
                                              child: Text(
                                                menuRolesASGR[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      ResponsiveValue<double>(
                                                    context,
                                                    conditionalValues: [
                                                      const Condition.equals(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                      const Condition
                                                          .largerThan(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                    ],
                                                    defaultValue: 10.0,
                                                  ).value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(43, 49, 49, 49),
                                  blurRadius: 2.0,
                                  offset: Offset(0, -3),
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "BODY & PAINT",
                                  style: TextStyle(
                                    fontSize: ResponsiveValue(
                                      context,
                                      conditionalValues: [
                                        const Condition.equals(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 18.5,
                                        ),
                                        const Condition.largerThan(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 16.5,
                                        ),
                                      ],
                                      defaultValue: 14.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimationLimiter(
                            child: GridView.builder(
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveValue<int>(
                                  context,
                                  conditionalValues: [
                                    const Condition.equals(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                    ),
                                    const Condition.largerThan(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                      breakpoint: 800,
                                    ),
                                  ],
                                  defaultValue: 4,
                                ).value,
                                childAspectRatio: 5 / 6,
                              ),
                              shrinkWrap: true,
                              itemCount: menuRolesBP.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  duration: const Duration(milliseconds: 1500),
                                  position: index,
                                  columnCount: 2,
                                  child: FlipAnimation(
                                    child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, linkPageBP[index]),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    0, 255, 255, 255),
                                            radius: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                ),
                                                const Condition.largerThan(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                  breakpoint: 800,
                                                ),
                                                const Condition.equals(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                ),
                                                const Condition.largerThan(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                  breakpoint: 1920,
                                                ),
                                              ],
                                              defaultValue: 30,
                                            ).value,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      0,
                                                      49,
                                                      49,
                                                      49,
                                                    ),
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 2.1,
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    0, 255, 255, 255),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Image.asset(
                                                'assets/images/menu/${imageBP[index]}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              5,
                                              10,
                                              5,
                                              0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                menuRolesBP[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      ResponsiveValue<double>(
                                                    context,
                                                    conditionalValues: [
                                                      const Condition.equals(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                      const Condition
                                                          .largerThan(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                    ],
                                                    defaultValue: 10.0,
                                                  ).value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(43, 49, 49, 49),
                                  blurRadius: 2.0,
                                  offset: Offset(0, -3),
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GENERAL",
                                  style: TextStyle(
                                    fontSize: ResponsiveValue(
                                      context,
                                      conditionalValues: [
                                        const Condition.equals(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 18.5,
                                        ),
                                        const Condition.largerThan(
                                          name: TABLET,
                                          value: 16.5,
                                          landscapeValue: 16.5,
                                        ),
                                      ],
                                      defaultValue: 14.5,
                                    ).value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimationLimiter(
                            child: GridView.builder(
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveValue<int>(
                                  context,
                                  conditionalValues: [
                                    const Condition.equals(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                    ),
                                    const Condition.largerThan(
                                      name: TABLET,
                                      value: 4,
                                      landscapeValue: 4,
                                      breakpoint: 800,
                                    ),
                                  ],
                                  defaultValue: 4,
                                ).value,
                                childAspectRatio: 5 / 6,
                              ),
                              shrinkWrap: true,
                              itemCount: menuRolesGeneral.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  duration: const Duration(milliseconds: 1500),
                                  position: index,
                                  columnCount: 2,
                                  child: FlipAnimation(
                                    child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, linkPageGeneral[index]),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                              0,
                                              255,
                                              255,
                                              255,
                                            ),
                                            radius: ResponsiveValue<double>(
                                              context,
                                              conditionalValues: [
                                                const Condition.equals(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                ),
                                                const Condition.largerThan(
                                                  name: TABLET,
                                                  value: 35,
                                                  landscapeValue: 55,
                                                  breakpoint: 800,
                                                ),
                                                const Condition.equals(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                ),
                                                const Condition.largerThan(
                                                  name: DESKTOP,
                                                  value: 75,
                                                  landscapeValue: 75,
                                                  breakpoint: 1920,
                                                ),
                                              ],
                                              defaultValue: 30,
                                            ).value,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      0,
                                                      49,
                                                      49,
                                                      49,
                                                    ),
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 2.1,
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                  0,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Image.asset(
                                                'assets/images/menu/${imageGeneral[index]}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              5,
                                              10,
                                              5,
                                              0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                menuRolesGeneral[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      ResponsiveValue<double>(
                                                    context,
                                                    conditionalValues: [
                                                      const Condition.equals(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                      const Condition
                                                          .largerThan(
                                                        name: TABLET,
                                                        value: 10.5,
                                                        landscapeValue: 14.5,
                                                      ),
                                                    ],
                                                    defaultValue: 10.0,
                                                  ).value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
