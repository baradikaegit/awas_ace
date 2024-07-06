import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChangepassPage extends StatefulWidget {
  const ChangepassPage({super.key});
  static const String routeName = "/changePassPage";

  @override
  State<ChangepassPage> createState() => _ChangepassPageState();
}

class _ChangepassPageState extends State<ChangepassPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Widget titleBar = const Text(
    "Change Password",
    style: TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    var textStyleWhite = TextStyle(
      color: Colors.white,
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

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: titleBar,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF00AA80),
            ),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formkey,
                        child: BootstrapContainer(
                          fluid: true,
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          children: <Widget>[
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-md-6 col-12',
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      autocorrect: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Password Lama',
                                        hintStyle: textStyleWhite,
                                        labelText: 'Password Lama',
                                        labelStyle: textStyleWhite,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-md-6 col-12',
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      autocorrect: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Password Baru',
                                        hintStyle: textStyleWhite,
                                        labelText: 'Password Baru',
                                        labelStyle: textStyleWhite,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-md-6 col-12',
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      autocorrect: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Ulangi Password Baru',
                                        hintStyle: textStyleWhite,
                                        labelText: 'Ulangi Password Baru',
                                        labelStyle: textStyleWhite,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            BootstrapRow(
                              children: [
                                BootstrapCol(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Column(
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            fixedSize: Size(
                                              ResponsiveValue<double>(context,
                                                      conditionalValues: [
                                                        const Condition.equals(
                                                          name: TABLET,
                                                          value: 400,
                                                          landscapeValue: 400,
                                                        ),
                                                        const Condition
                                                            .largerThan(
                                                            name: TABLET,
                                                            value: 400,
                                                            landscapeValue: 400,
                                                            breakpoint: 800),
                                                      ],
                                                      defaultValue: 400)
                                                  .value,
                                              ResponsiveValue<double>(
                                                context,
                                                conditionalValues: [
                                                  const Condition.equals(
                                                      name: TABLET,
                                                      value: 55,
                                                      landscapeValue: 55),
                                                  const Condition.largerThan(
                                                      name: TABLET,
                                                      value: 55,
                                                      landscapeValue: 55,
                                                      breakpoint: 800),
                                                ],
                                                defaultValue: 50,
                                              ).value,
                                            ),
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromARGB(
                                              255,
                                              129,
                                              127,
                                              127,
                                            ),
                                          ).copyWith(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
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
                                          onPressed: () {},
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Simpan",
                                                  textAlign: TextAlign.center,
                                                  style: textStyleWhite,
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
