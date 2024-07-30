import 'package:flutter/material.dart';

void catchError(BuildContext context, Object e) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text("Terjadi kesalahan : Data Gagal Di Input"),
    ),
  );
}
