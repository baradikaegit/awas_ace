import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(71, 90, 83, 83),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Info"),
        content: const Text("Tidak ada data di tampilkan.!"),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Ok")),
        ],
      ),
    );
  }
}
