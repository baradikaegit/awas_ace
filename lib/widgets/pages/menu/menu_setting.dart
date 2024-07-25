// ignore_for_file: use_build_context_synchronously

import 'package:awas_ace/widgets/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List menuRoles = [
    'Profile',
    'Team Saya',
    'Rules Of The Game',
    'Change Password',
    'LogOut',
  ];
  List image = [
    'profile.png',
    'team.png',
    'piala.png',
    'padlock.png',
    'logout.png'
  ];
  List linkPage = ['/', '/', '/rulesOftheGamePage', '/changePassPage', '/'];

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
                          "SETTING",
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
                      itemCount: menuRoles.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 1500),
                          position: index,
                          columnCount: 2,
                          child: FlipAnimation(
                            child: InkWell(
                              onTap: () => menuRoles[index] == 'LogOut'
                                  ? myAlertDialog(context)
                                  : Navigator.pushNamed(
                                      context, linkPage[index]),
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
                                        'assets/images/menu/${image[index]}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                    child: Center(
                                      child: Text(
                                        menuRoles[index],
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> myAlertDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Info"),
        content: const Text(
          "Apakah anda yakin ingin keluar?",
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
            ),
            child: const Text("Batal"),
          ),
          OutlinedButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const MainPage(),
                ),
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
            ),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}
