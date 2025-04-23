// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awas_ace/provider/profile_provider.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/profilemodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String routeName = "/profilePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget titleBar = const Text(
    "Profile",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
    var textStyleColorGreenH = TextStyle(
      color: const Color.fromARGB(
        255,
        17,
        157,
        144,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
        ],
        defaultValue: 14.0,
      ).value,
    );

    var textStyleColorWhiteH = TextStyle(
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
              name: TABLET, value: 20.0, landscapeValue: 20.0, breakpoint: 800),
        ],
        defaultValue: 14.0,
      ).value,
    );

    var textStyleColorGreen = TextStyle(
      color: const Color.fromARGB(
        255,
        17,
        157,
        144,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 14.5, landscapeValue: 14.5),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.04; // 4% dari lebar layar

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
                  final dataProfile = ref.watch(getProfile);

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: dataProfile.when(
                                data:
                                    (dataProfileGet) =>
                                        (dataProfileGet.listGetProfile != null)
                                            ? dataProfileGet
                                                    .listGetProfile!.isNotEmpty
                                                ? ListView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount: dataProfileGet
                                                        .listGetProfile!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var emailCtrl =
                                                          dataProfileGet
                                                              .listGetProfile![
                                                                  index]
                                                              .email
                                                              .toLowerCase();

                                                      emailController.text =
                                                          emailCtrl;

                                                      phoneController.text =
                                                          dataProfileGet
                                                              .listGetProfile![
                                                                  index]
                                                              .phoneNumber;

                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal:
                                                                  spacing,
                                                              vertical:
                                                                  screenWidth *
                                                                      0.02,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: screenWidth *
                                                                          0.30, // sekitar 95px di layar 400px,
                                                                      height:
                                                                          screenWidth *
                                                                              0.30,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(
                                                                            'assets/images/user.png',
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            spacing),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            dataProfileGet.listGetProfile![index].userName,
                                                                            style:
                                                                                textStyleColorGreenH,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                screenWidth * 0.02,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Text('Status Poin', style: textStyleColorGreen),
                                                                                  Text(
                                                                                    dataProfileGet.listGetProfile![index].totalLevel.toString(),
                                                                                    style: textStyleColorGreen,
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: screenWidth * 0.06,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Text('Status Level', style: textStyleColorGreen),
                                                                                  Text(
                                                                                    'Basic',
                                                                                    style: textStyleColorGreen,
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
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
                                                              0,
                                                              10,
                                                              0,
                                                            ),
                                                            child: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                minHeight:
                                                                    screenWidth *
                                                                        0.20,
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
                                                                      17,
                                                                      157,
                                                                      144,
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
                                                                  width: 0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                                color: const Color
                                                                    .fromARGB(
                                                                  167,
                                                                  17,
                                                                  157,
                                                                  144,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        'Reward Poin',
                                                                        style:
                                                                            textStyleColorWhiteH,
                                                                      ),
                                                                      Text(
                                                                        dataProfileGet
                                                                            .listGetProfile![index]
                                                                            .totalPoin
                                                                            .toString(),
                                                                        style:
                                                                            textStyleColorWhiteH,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .gift,
                                                                    color: Colors
                                                                        .white,
                                                                    size: ResponsiveValue<
                                                                        double>(
                                                                      context,
                                                                      conditionalValues: [
                                                                        const Condition
                                                                            .equals(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                60.0,
                                                                            landscapeValue:
                                                                                60.0),
                                                                        const Condition
                                                                            .largerThan(
                                                                            name:
                                                                                TABLET,
                                                                            value:
                                                                                80.0,
                                                                            landscapeValue:
                                                                                80.0,
                                                                            breakpoint:
                                                                                800),
                                                                      ],
                                                                      defaultValue:
                                                                          50.0,
                                                                    ).value,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          BootstrapContainer(
                                                            fluid: true,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    10, 0, 0),
                                                            children: <Widget>[
                                                              BootstrapRow(
                                                                children: <BootstrapCol>[
                                                                  BootstrapCol(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              15),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              "Email :",
                                                                              style: textStyleColorGreen,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20),
                                                                          child:
                                                                              TextFormField(
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                17,
                                                                                157,
                                                                                144,
                                                                              ),
                                                                            ),
                                                                            autocorrect:
                                                                                false,
                                                                            controller:
                                                                                emailController,
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              errorStyle: const TextStyle(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  17,
                                                                                  0,
                                                                                ),
                                                                              ),
                                                                              errorBorder: const UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    255,
                                                                                    17,
                                                                                    0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              hintText: 'Email',
                                                                              hintStyle: textStyleColorGreen,
                                                                              enabledBorder: const OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    17,
                                                                                    157,
                                                                                    144,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    17,
                                                                                    157,
                                                                                    144,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  BootstrapCol(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              15),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              "No.Hp :",
                                                                              style: textStyleColorGreen,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20),
                                                                          child:
                                                                              TextFormField(
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                17,
                                                                                157,
                                                                                144,
                                                                              ),
                                                                            ),
                                                                            autocorrect:
                                                                                false,
                                                                            controller:
                                                                                phoneController,
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              errorStyle: const TextStyle(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  17,
                                                                                  0,
                                                                                ),
                                                                              ),
                                                                              errorBorder: const UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    255,
                                                                                    17,
                                                                                    0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              hintText: 'No.HP',
                                                                              hintStyle: textStyleColorGreen,
                                                                              enabledBorder: const OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    17,
                                                                                    157,
                                                                                    144,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    17,
                                                                                    157,
                                                                                    144,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              BootstrapRow(
                                                                children: [
                                                                  BootstrapCol(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          OutlinedButton(
                                                                            style:
                                                                                OutlinedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              fixedSize: Size(
                                                                                ResponsiveValue<double>(
                                                                                  context,
                                                                                  conditionalValues: [
                                                                                    const Condition.equals(
                                                                                      name: TABLET,
                                                                                      value: 350,
                                                                                      landscapeValue: 350,
                                                                                    ),
                                                                                    const Condition.largerThan(
                                                                                      name: TABLET,
                                                                                      value: 450,
                                                                                      landscapeValue: 450,
                                                                                      breakpoint: 800,
                                                                                    ),
                                                                                  ],
                                                                                  defaultValue: 250,
                                                                                ).value,
                                                                                ResponsiveValue<double>(
                                                                                  context,
                                                                                  conditionalValues: [
                                                                                    const Condition.equals(name: TABLET, value: 55, landscapeValue: 55),
                                                                                    const Condition.largerThan(name: TABLET, value: 55, landscapeValue: 55, breakpoint: 800),
                                                                                  ],
                                                                                  defaultValue: 50,
                                                                                ).value,
                                                                              ),
                                                                              elevation: 0,
                                                                              side: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  167,
                                                                                  17,
                                                                                  157,
                                                                                  144,
                                                                                ),
                                                                              ),
                                                                              backgroundColor: const Color.fromARGB(
                                                                                167,
                                                                                17,
                                                                                157,
                                                                                144,
                                                                              ),
                                                                            ).copyWith(
                                                                              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                                                                (Set<MaterialState> states) {
                                                                                  if (states.contains(MaterialState.pressed)) {
                                                                                    return const Color.fromARGB(
                                                                                      255,
                                                                                      1,
                                                                                      209,
                                                                                      29,
                                                                                    );
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              print('${emailController.text} ${phoneController.text}');

                                                                              var updateProfile = ListUpdateProfile(
                                                                                email: emailController.text,
                                                                                phoneNumber: phoneController.text,
                                                                              );

                                                                              try {
                                                                                await ref.read(updateProfileFormProvider).onUpdateProfile(updateProfile);

                                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => const HomePage(),
                                                                                  ),
                                                                                  (route) => false,
                                                                                );

                                                                                notifUpdated(context);
                                                                              } catch (e) {
                                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => const HomePage(),
                                                                                  ),
                                                                                  (route) => false,
                                                                                );

                                                                                catchError(
                                                                                  context,
                                                                                  e,
                                                                                );
                                                                              }
                                                                            },
                                                                            child:
                                                                                Stack(
                                                                              children: <Widget>[
                                                                                Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    "Update",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: textStyleColorWhiteH,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
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
            ? "Update berhasil "
            : "Update gagal"),
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
