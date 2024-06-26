import 'package:flutter/material.dart';

class LainnyaPage extends StatefulWidget {
  const LainnyaPage({super.key});
  static const String routeName = "/lainnyaPage";

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                    radius: ResponsiveValue<double>(
                                      context,
                                      conditionalValues: [
                                        const Condition.equals(
                                          name: TABLET,
                                          value: 45,
                                          landscapeValue: 65,
                                        ),
                                        const Condition.largerThan(
                                          name: TABLET,
                                          value: 45,
                                          landscapeValue: 65,
                                          breakpoint: 800,
                                        ),
                                        const Condition.equals(
                                          name: DESKTOP,
                                          value: 85,
                                          landscapeValue: 85,
                                        ),
                                        const Condition.largerThan(
                                          name: DESKTOP,
                                          value: 85,
                                          landscapeValue: 85,
                                          breakpoint: 1920,
                                        ),
                                      ],
                                      defaultValue: 35,
                                    ).value,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              74,
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                          242,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                    child: Center(
                                      child: Text(
                                        menuRolesSurvey[index],
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
                ),
        ),
      ),
    );
  }
}
