import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awas_ace/widgets/main_page.dart';
import 'package:awas_ace/widgets/pages/call_page.dart';
import 'package:awas_ace/widgets/pages/changepass_page.dart';
import 'package:awas_ace/widgets/pages/entrypropectuebp_page.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:awas_ace/widgets/pages/menu/menu_lainnya.dart';
import 'package:awas_ace/widgets/pages/prospect_page.dart';
import 'package:awas_ace/widgets/pages/prospectsales_page.dart';
import 'package:awas_ace/widgets/pages/prospectuebp_page.dart';
import 'package:awas_ace/widgets/pages/resetpass_page.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_bysales_detail.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_byss.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_byss.dart';
import 'package:awas_ace/widgets/pages/settings/rotg_page.dart';
import 'package:awas_ace/widgets/pages/sales/boccaisbe.dart';
import 'package:awas_ace/widgets/pages/sales/dotogatepass.dart';
import 'package:awas_ace/widgets/pages/sales/funneling.dart';
import 'package:awas_ace/widgets/pages/sales/gatepasstosbi.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringareamapping.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringprofitmaker.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringvolmaker.dart';
import 'package:awas_ace/widgets/pages/sales/prospekuebp.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk.dart';
import 'package:awas_ace/widgets/pages/sales/targetsalesvsactual.dart';
import 'package:awas_ace/widgets/pages/targetsales_page.dart';
import 'package:awas_ace/widgets/pages/targetsalesentry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
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
        fontFamily: 'Tahoma',
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo_splash.png'),
        splashIconSize: double.infinity,
        duration: 3000,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: const Color(0xFFFFFFFF),
        nextScreen: const MainPage(),
      ),
      routes: {
        ResetPassword.routeName: (context) => const ResetPassword(),
        CallPage.routeName: (context) => CallPage(
            callDateObject: ModalRoute.of(context)!.settings.arguments),
        ProspectSalesPage.routeName: (context) => const ProspectSalesPage(),
        TargetsalesPage.routeName: (context) => const TargetsalesPage(),
        TargetsalesEntryPage.routeName: (context) => TargetsalesEntryPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspectUEbpPage.routeName: (context) => ProspectUEbpPage(
              objID: ModalRoute.of(context)!.settings.arguments,
            ),
        EntryProspectUEbpPage.routeName: (context) => EntryProspectUEbpPage(
              objID: ModalRoute.of(context)!.settings.arguments,
            ),
        LainnyaPage.routeName: (context) => const LainnyaPage(),
        ProspectPage.routeName: (context) => const ProspectPage(),
        FunnelingPage.routeName: (context) => FunnelingPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingSSPage.routeName: (context) => FunnelingSSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingSalesPage.routeName: (context) => FunnelingSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingSalesDetailPage.routeName: (context) =>
            FunnelingSalesDetailPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekVtoSpkPage.routeName: (context) => ProspekVtoSpkPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekVtoSpkSsPage.routeName: (context) => ProspekVtoSpkSsPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekVtoSpkSalesPage.routeName: (context) => ProspekVtoSpkSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekUeBPPage.routeName: (context) => const ProspekUeBPPage(),
        MonitAreaMappingPage.routeName: (context) =>
            const MonitAreaMappingPage(),
        MonitAreaVolumeMakerPage.routeName: (context) =>
            const MonitAreaVolumeMakerPage(),
        MonitProfitMakerPage.routeName: (context) =>
            const MonitProfitMakerPage(),
        DOtoGatePassPage.routeName: (context) => const DOtoGatePassPage(),
        GatePasstoSBIPage.routeName: (context) => const GatePasstoSBIPage(),
        TargetSalesActualPage.routeName: (context) =>
            const TargetSalesActualPage(),
        BocCaiSBEPage.routeName: (context) => const BocCaiSBEPage(),
        RulesOftheGamePage.routeName: (context) => const RulesOftheGamePage(),
        ChangepassPage.routeName: (context) => const ChangepassPage(),
      },
      // home: const HomePage(),
    );
  }
}
