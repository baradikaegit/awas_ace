// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:awas_ace/widgets/pages/resetpass_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var userNameCtr = TextEditingController();
  var passCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    //periksa cek login, jika user siap login (login otomatis) atau belum siap login (login kembali)
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login"); //token
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: height * 0.3,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/ace_ast_s.jpg"),
                          ),
                        ),
                      ),
                      Container(
                        height: height * .10,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ResponsiveRowColumnItem(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 30, 20, 0),
                            child: Text(
                              "Hallo, Selamat Datang.",
                              style: TextStyle(
                                fontSize: ResponsiveValue<double>(
                                  context,
                                  conditionalValues: [
                                    const Condition.equals(
                                        name: TABLET,
                                        value: 17.0,
                                        landscapeValue: 17.0),
                                    const Condition.largerThan(
                                        name: TABLET,
                                        value: 17.0,
                                        landscapeValue: 17.0,
                                        breakpoint: 800),
                                  ],
                                  defaultValue: 12,
                                ).value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: TextFormField(
                                  controller: userNameCtr,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Username',
                                    labelText: 'Username',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText:
                                              "* Username tidak boleh kosong.")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-md-6 col-12',
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: ValueListenableBuilder(
                                  valueListenable: _obsecurePassword,
                                  builder: (context, value, child) {
                                    return TextFormField(
                                      controller: passCtr,
                                      autocorrect: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: _obsecurePassword.value,
                                      obscuringCharacter: "•",
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        labelText: 'Password',
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _obsecurePassword.value =
                                                !_obsecurePassword.value;
                                          },
                                          child: Icon(
                                            _obsecurePassword.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility,
                                          ),
                                        ),
                                      ),
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText:
                                                "* Password tidak boleh kosong",
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-md-8',
                              offsets: 'offset-sm-2',
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fixedSize: const Size(200, 60),
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF9E9E9E),
                                ).copyWith(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return const Color.fromARGB(
                                            255, 1, 209, 29);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    login(context);
                                  }
                                },
                                child: const Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.lock,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "LOGIN",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 90),
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-3',
                              offsets: 'offset-md-3',
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(22, 255, 255, 255),
                                radius: 30,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(22, 230, 230, 230),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0.8,
                                        ),
                                      ],
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 1, 209, 29),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        ResetPassword.routeName,
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/rp.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-3',
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(22, 255, 255, 255),
                                radius: 30,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(22, 230, 230, 230),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0.8,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 1, 209, 29),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: const Text("Info"),
                                          content: const Text(
                                            "Untuk kritik, saran dan pengaduan silahkan kirim email ke ace-helpdesk@astridogroup.com dengan detail informasi yang jelas. Untuk reset password klik icon gembok.",
                                          ),
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide.none,
                                              ),
                                              child: const Text("Ok"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/cs.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
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
      ),
    );
  }

  void login(context) async {
    if (passCtr.text.isNotEmpty && userNameCtr.text.isNotEmpty) {
      var url = urlApi();
      var urlLogin = "${url}Auth/Login";

      final Map<String, String> headers = {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        // HttpHeaders.authorizationHeader: "Bearer $token",
      };

      try {
        var response = await http.post(
          Uri.parse(urlLogin),
          headers: headers,
          body: jsonEncode(
              {"UserName": userNameCtr.text, "Password": passCtr.text}),
        );

        final prefs = await SharedPreferences.getInstance();

        if (response.statusCode == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Column(
                children: [loadingAnimation()],
              );
            },
          );

          Future.delayed(
            const Duration(seconds: 2),
            () async {
              Navigator.pop(context); //pop dialog close

              final body = jsonDecode(response.body);
              final success = body['success'].toString();

              if (success == 'true') {
                //print("Login Token : " + body['token']);

                //body data login
                String prefId = body['data']['id'].toString();
                String prefSID = body['data']['sid'];
                String prefUserName = body['data']['username'];
                String prefName = body['data']['name'];
                String prefEmail = body['data']['email'];
                String prefPhoneNumber = body['data']['phoneNumber'];
                String prefBranchID = body['data']['branchID'];
                String prefBranchCode = body['data']['branchCode'];
                String prefRoles = body['data']['roles'];

                await prefs.setString("id", prefId);
                await prefs.setString("SID", prefSID);
                await prefs.setString("Username", prefUserName.toUpperCase());
                await prefs.setString("Name", prefName);
                await prefs.setString("Email", prefEmail);
                await prefs.setString("PhoneNumber", prefPhoneNumber);
                await prefs.setString("BranchID", prefBranchID);
                await prefs.setString("BranchCode", prefBranchCode);
                await prefs.setString("Roles", prefRoles);
                //body data login

                pageRoute(body['token'], body['message']);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text("Message : ${body['message']}"),
                  ),
                );
              }
            },
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Terjadi kesalahan : $e"),
          ),
        );
      }
    }
  }

  void pageRoute(String token, String message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    await pref.setString("message", message);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        backgroundColor: Color.fromARGB(
          255,
          1,
          209,
          29,
        ),
        content: Text("Sucess..."),
      ),
    );
  }
}
