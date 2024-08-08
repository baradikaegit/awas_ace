import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:flutter/material.dart';

void successSubmit(BuildContext context, ProspectResponse resp) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: (resp.statusMessage == "Sucess")
          ? const Color.fromARGB(
              255,
              1,
              209,
              29,
            )
          : Colors.red,
      content: Text(resp.statusMessage.toString()),
    ),
  );
}

void sucessSubmit2(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      backgroundColor: ("Success" == "Success")
          ? Color.fromARGB(
              255,
              1,
              209,
              29,
            )
          : Colors.red,
      content: Text("Message : Success Insert"),
    ),
  );
}
