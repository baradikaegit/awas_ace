// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({super.key});
  static const String routeName = "/lainnyaPage";

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  Widget title = const Text("Menu Lainnya");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          9,
          155,
          28,
        ),
        title: title,
        elevation: 0,
        centerTitle: true,
      ),
      body: const widgetBody(),
    );
  }
}

class widgetBody extends StatefulWidget {
  const widgetBody({super.key});

  @override
  State<widgetBody> createState() => _widgetBodyState();
}

class _widgetBodyState extends State<widgetBody> {
  List menuRolesSVC = ['SVC Kendaraan Pelanggan'];
  List imageSVC = ['svc.png'];
  List linkPageSVC = ['/'];

  List menuRolesSurvey = [
    'Survey PSP SPK',
    'Survey PSP Pre DEC',
    'Survey PSP Area Sales',
    'Survey PSP Area CRC',
    'Survey PSP Area MRA',
    'Survey PSP Area SA',
  ];
  List imageSurvey = [
    'surveypsp.png',
    'surveypsp.png',
    'surveypsparea.png',
    'surveypsparea.png',
    'surveypsparea.png',
    'surveypsparea.png'
  ];
  List linkPageSurvey = ['/', '/', '/', '/', '/', '/'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        9,
        155,
        28,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: ListView(
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
                          "SVC Kendaraan Pelanggan",
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      itemCount: menuRolesSVC.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 1500),
                          position: index,
                          columnCount: 2,
                          child: FlipAnimation(
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, linkPageSVC[index]),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(0, 255, 255, 255),
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
                                            color:
                                                Color.fromARGB(0, 49, 49, 49),
                                            blurRadius: 5.0,
                                            offset: Offset(0, 0),
                                            spreadRadius: 2.1,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                          0,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(0.0),
                                      child: Image.asset(
                                        'assets/images/menu/${imageSVC[index]}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                    child: Center(
                                      child: Text(
                                        menuRolesSVC[index],
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Survey PSP",
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
                            itemCount: menuRolesSurvey.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                duration: const Duration(milliseconds: 1500),
                                position: index,
                                columnCount: 2,
                                child: FlipAnimation(
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, linkPageSurvey[index]),
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Image.asset(
                                              'assets/images/menu/${imageSurvey[index]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 10, 5, 0),
                                          child: Center(
                                            child: Text(
                                              menuRolesSurvey[index],
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
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
