import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AlertNotempty extends StatelessWidget {
  const AlertNotempty({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhite = TextStyle(
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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        20,
        0,
        0,
      ),
      child: Text(
        "Tidak ada data di tampilkan",
        style: textStyleColorWhite,
      ),
    );
  }
}
