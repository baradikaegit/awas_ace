// ignore_for_file: camel_case_types

import 'package:awas_ace/widgets/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notActivetoken extends StatelessWidget {
  const notActivetoken({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(71, 90, 83, 83),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Info"),
        content: const Text("Session habis. Harap login kembali.!"),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              onPressed: () {
                sessionAlert(context);
              },
              child: const Text("Ok")),
        ],
      ),
    );
  }

  void sessionAlert(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? deviceId = pref.getString('deviceId');
    String? deviceName = pref.getString('deviceName');
    String? deviceToken = pref.getString('deviceToken');

    await pref.clear();

    if (deviceId != null) {
      await pref.setString('deviceId', deviceId);
    }

    if (deviceName != null) {
      await pref.setString('deviceName', deviceName);
    }

    if (deviceToken != null) {
      await pref.setString('deviceToken', deviceToken);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF3936AB),
        content: Text("Message : Silahkan login kembali"),
      ),
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false);
  }
}
