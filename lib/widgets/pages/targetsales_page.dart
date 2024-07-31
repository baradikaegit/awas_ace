// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/widgets/pages/targetsalesentry_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

  @override
  Widget build(BuildContext context) {
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
      body: const BodyListWidget(),
    );
  }
}

class BodyListWidget extends StatefulWidget {
  const BodyListWidget({super.key});

  @override
  State<BodyListWidget> createState() => _BodyListWidgetState();
}

class _BodyListWidgetState extends State<BodyListWidget> {
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
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TargetsalesEntryPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 195,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(197, 3, 116, 18),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromARGB(
                            255,
                            3,
                            116,
                            18,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Call = 1",
                                      style: textStyleColorWhite,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: Text(
                                          "Juli 2024",
                                          style: textStyleColorWhite,
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
                                  "Prospect = 1",
                                  style: textStyleColorWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "HOT = 1",
                                  style: textStyleColorWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "SPK = 1",
                                  style: textStyleColorWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "DO = 1",
                                  style: textStyleColorWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TargetsalesEntryPage(),
            ),
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
