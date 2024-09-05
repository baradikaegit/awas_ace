import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Watermark extends StatefulWidget {
  const Watermark({super.key});

  @override
  State<Watermark> createState() => _WatermarkState();
}

class _WatermarkState extends State<Watermark> {
  get tabletWidth => MediaQuery.of(context).size.width;

  String? userName;
  String? roles;

  @override
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Name');
      roles = prefs.getString('Roles');
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyleWaterMark = TextStyle(
      color: const Color.fromARGB(
        88,
        0,
        0,
        0,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
            name: TABLET,
            value: 65.0,
            landscapeValue: 65.0,
          ),
          const Condition.largerThan(
              name: TABLET,
              value: 100.0,
              landscapeValue: 100.0,
              breakpoint: 800),
        ],
        defaultValue: 50.0,
      ).value,
    );

    return Wrap(
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 300, 50, 0),
          child: Transform.rotate(
            angle: -51,
            child: SizedBox(
              height: 60,
              width: 500,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  textAlign: TextAlign.center,
                  '$userName',
                  style: textStyleWaterMark,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
