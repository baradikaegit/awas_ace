import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static const String routeName = "/resetPass";

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Widget titleBar = const Text("Reset Password");

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
                                      //controller: userNameCtr,
                                      autocorrect: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'NIK',
                                        hintStyle: textStyleWhite,
                                        //labelText: 'NIK',
                                        // enabledBorder: OutlineInputBorder(
                                        //     borderSide: BorderSide(
                                        //         color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
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
                                      autocorrect: false,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: 'Reset Code',
                                        hintStyle: textStyleWhite,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
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
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          fixedSize: const Size(130, 50),
                                          elevation: 0,
                                          backgroundColor:
                                              const Color(0xFF9E9E9E),
                                        ).copyWith(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return const Color.fromARGB(
                                                    255, 1, 209, 29);
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
                                                "Get Reset Code",
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          fixedSize: const Size(135, 50),
                                          elevation: 0,
                                          backgroundColor:
                                              const Color(0xFF9E9E9E),
                                        ).copyWith(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return const Color.fromARGB(
                                                    255, 1, 209, 29);
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
                                                "Reset Password",
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
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 400,
                              minWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(74, 49, 49, 49),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 0),
                                  spreadRadius: 2.1,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF00AA80),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Cara Mereset Password",
                                          style: textStyleWhite,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Masukkan NIK anda pada kolom NIK kemudian klik tombol "Get Reset Code".',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Buka email anda yang telah di daftarkan pada program ACE',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Masukkan Reset Code yang terdapat pada email ke kolom Reset Code kemudian klik tombol "Reset Password".',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Buka kembali email anda yang telah di daftarkan pada program ACE.',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Lakukan login dengan password yang terdapat pada email "perhatikan huruf besar kecilnya".',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 10, 8, 10),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                          minWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 121, 91),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 0),
                                              spreadRadius: 3.1,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFFDEDEE2),
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 10),
                                            child: Text(
                                              'Setelah berhasil login, ubah password anda agar mudah di ingat.',
                                              style: textStyleWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        ),
      ],
    );
  }
}
