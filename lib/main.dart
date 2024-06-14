import 'package:awas_ace/widgets/main_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        breakpointsLandscape: [
          const Breakpoint(start: 0, end: 1023, name: MOBILE),
          const Breakpoint(start: 1024, end: 1599, name: TABLET),
          const Breakpoint(start: 1600, end: double.infinity, name: DESKTOP),
        ],
        child: child!,
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainPage(),
    );
  }
}
