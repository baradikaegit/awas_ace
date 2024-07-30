import 'package:flutter/material.dart';

void catchApiError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text("Gagal mengambil data: Silahkan Login Kembali"),
    ),
  );
}
