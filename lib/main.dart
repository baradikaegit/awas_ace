import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awas_ace/widgets/main_page.dart';
import 'package:awas_ace/widgets/pages/aftersales/boccaibypicbooking.dart';
import 'package:awas_ace/widgets/pages/aftersales/bookingtoshow.dart';
import 'package:awas_ace/widgets/pages/aftersales/funneling.dart';
import 'package:awas_ace/widgets/pages/aftersales/funneling_byactual.dart';
import 'package:awas_ace/widgets/pages/aftersales/funneling_bybranch.dart';
import 'package:awas_ace/widgets/pages/aftersales/prospekgrtoeubp.dart';
import 'package:awas_ace/widgets/pages/aftersales/prospekgrtoeubp_bysaname.dart';
import 'package:awas_ace/widgets/pages/aftersales/prospeksagrvsvalidity.dart';
import 'package:awas_ace/widgets/pages/aftersales/prospeksagrvsvalidity_bysaname.dart';
import 'package:awas_ace/widgets/pages/aftersales/tmsproductivity.dart';
import 'package:awas_ace/widgets/pages/bodypaint/prospekbptouegr.dart';
import 'package:awas_ace/widgets/pages/bodypaint/prospekbptouegr_bysaname.dart';
import 'package:awas_ace/widgets/pages/bodypaint/prospeksabpvsvalidity.dart';
import 'package:awas_ace/widgets/pages/bodypaint/prospeksabpvsvalidity_bysaname.dart';
import 'package:awas_ace/widgets/pages/call_page.dart';
import 'package:awas_ace/widgets/pages/changepass_page.dart';
import 'package:awas_ace/widgets/pages/entrypropectuebp_page.dart';
import 'package:awas_ace/widgets/pages/general/monitoringpoin.dart';
import 'package:awas_ace/widgets/pages/general/monitoringpoinbysls.dart';
import 'package:awas_ace/widgets/pages/general/monitoringpoinbyss.dart';
import 'package:awas_ace/widgets/pages/general/monitoringpoinhistory.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeem.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeembysls.dart';
import 'package:awas_ace/widgets/pages/general/monitoringredeembyss.dart';
import 'package:awas_ace/widgets/pages/general/monitoringsaldo.dart';
import 'package:awas_ace/widgets/pages/menu/menu_lainnya.dart';
import 'package:awas_ace/widgets/pages/prospect_page.dart';
import 'package:awas_ace/widgets/pages/prospectbengkel_page.dart';
import 'package:awas_ace/widgets/pages/prospectbengkeldetail_page.dart';
import 'package:awas_ace/widgets/pages/prospectedit_page.dart';
import 'package:awas_ace/widgets/pages/prospectsales_page.dart';
import 'package:awas_ace/widgets/pages/prospectsalesbysls_page.dart';
import 'package:awas_ace/widgets/pages/prospectuebp_page.dart';
import 'package:awas_ace/widgets/pages/reminder/birthday_page.dart';
import 'package:awas_ace/widgets/pages/reminder/birthdaydetail_page.dart';
import 'package:awas_ace/widgets/pages/reminder/leasingberakhir_page.dart';
import 'package:awas_ace/widgets/pages/reminder/leasingberakhirdetail_page.dart';
import 'package:awas_ace/widgets/pages/reminder/stnk_page.dart';
import 'package:awas_ace/widgets/pages/reminder/stnkdetail_page.dart';
import 'package:awas_ace/widgets/pages/resetpass_page.dart';
import 'package:awas_ace/widgets/pages/sales/boccaibysales.dart';
import 'package:awas_ace/widgets/pages/sales/boccaibysales_byss.dart';
import 'package:awas_ace/widgets/pages/sales/boccaibysales_byssdtl.dart';
import 'package:awas_ace/widgets/pages/sales/dotogatepass_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/dotogatepass_byss.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_bysales_detail.dart';
import 'package:awas_ace/widgets/pages/sales/funneling_byss.dart';
import 'package:awas_ace/widgets/pages/sales/gatepasstosbi_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/gatepasstosbi_byss.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringfoapma.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringfoapma_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringfoapma_byss.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringprofitmaker.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringprofitmaker_detail.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringvolmaker_detail.dart';
import 'package:awas_ace/widgets/pages/sales/prospekuebp_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/prospekuebp_byss.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_bysales.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk_byss.dart';
import 'package:awas_ace/widgets/pages/sales/stockbymodel.dart';
import 'package:awas_ace/widgets/pages/sales/stockbymodel_branch.dart';
import 'package:awas_ace/widgets/pages/sales/stockbymodel_vcolor.dart';
import 'package:awas_ace/widgets/pages/sales/stockbymodel_vtype.dart';
import 'package:awas_ace/widgets/pages/sales/targetsalesvsactual_byss.dart';
import 'package:awas_ace/widgets/pages/sales/targetsalesvsactual_byssales.dart';
import 'package:awas_ace/widgets/pages/settings/rotg_page.dart';
import 'package:awas_ace/widgets/pages/sales/dotogatepass.dart';
import 'package:awas_ace/widgets/pages/sales/funneling.dart';
import 'package:awas_ace/widgets/pages/sales/gatepasstosbi.dart';
import 'package:awas_ace/widgets/pages/sales/monitoringvolmaker.dart';
import 'package:awas_ace/widgets/pages/sales/prospekuebp.dart';
import 'package:awas_ace/widgets/pages/sales/prospekvalidtospk.dart';
import 'package:awas_ace/widgets/pages/sales/targetsalesvsactual.dart';
import 'package:awas_ace/widgets/pages/settings/teamsaya_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/bodyrepairgr_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/bodyrepairgrdetail_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/bodyrepairsls_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/bodyrepairslsdetail_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/svckendaaraanpelanggan_page.dart';
import 'package:awas_ace/widgets/pages/svckendaraan/svckendaraanpelanggandetail_page.dart';
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
        ProspectSalesBySlsPage.routeName: (context) => ProspectSalesBySlsPage(
            linkPageObj: ModalRoute.of(context)!.settings.arguments),
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
        ProspectDariBengkelPage.routeName: (context) =>
            const ProspectDariBengkelPage(),
        ProspectDariBengkeDetailPage.routeName: (context) =>
            ProspectDariBengkeDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        LainnyaPage.routeName: (context) => const LainnyaPage(),
        ProspectPage.routeName: (context) => const ProspectPage(),
        ProspectEditPage.routeName: (context) => ProspectEditPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ReminderBirthdayPage.routeName: (context) =>
            const ReminderBirthdayPage(),
        ReminderBirthdayDetailPage.routeName: (context) =>
            ReminderBirthdayDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        ReminderLeasingBerakhirPage.routeName: (context) =>
            const ReminderLeasingBerakhirPage(),
        ReminderLeasingBerakhirDetailPage.routeName: (context) =>
            ReminderLeasingBerakhirDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        ReminderSTNKPage.routeName: (context) => const ReminderSTNKPage(),
        ReminderSTNKDetailPage.routeName: (context) => ReminderSTNKDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        SvcKendaraanPelangganPage.routeName: (context) =>
            const SvcKendaraanPelangganPage(),
        SvcKendaraanPelangganDetailPage.routeName: (context) =>
            SvcKendaraanPelangganDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        BodyRepairGRPage.routeName: (context) => const BodyRepairGRPage(),
        BodyRepariGRDetailPage.routeName: (context) => BodyRepariGRDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
        BodyRepairSlsPage.routeName: (context) => const BodyRepairSlsPage(),
        BodyRepariSlsDetailPage.routeName: (context) => BodyRepariSlsDetailPage(
              linkObject: ModalRoute.of(context)!.settings.arguments,
            ),
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
        ProspekUeBPPage.routeName: (context) => ProspekUeBPPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekUeBPSsPage.routeName: (context) => ProspekUeBPSsPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekUeBPSalesPage.routeName: (context) => ProspekUeBPSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitVolMakerPage.routeName: (context) => MonitVolMakerPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitVolMakerDetailPage.routeName: (context) => MonitVolMakerDetailPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitProfitMakerPage.routeName: (context) => MonitProfitMakerPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitProfitMakerDetailPage.routeName: (context) =>
            MonitProfitMakerDetailPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        DOtoGatePassPage.routeName: (context) => DOtoGatePassPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        DOtoGatePassBySSPage.routeName: (context) => DOtoGatePassBySSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        DOtoGatePassBySalesPage.routeName: (context) => DOtoGatePassBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        GatePasstoSBIPage.routeName: (context) => GatePasstoSBIPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        GatePasstoSBIBySSPage.routeName: (context) => GatePasstoSBIBySSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        GatePasstoSBIBySalesPage.routeName: (context) =>
            GatePasstoSBIBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        TargetSalesActualPage.routeName: (context) => TargetSalesActualPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        TargetSalesActualBySSPage.routeName: (context) =>
            TargetSalesActualBySSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        TargetSalesActualBySalesPage.routeName: (context) =>
            TargetSalesActualBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        BocCaiBySalesPage.routeName: (context) => BocCaiBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        BocCaiBySalesSSPage.routeName: (context) => BocCaiBySalesSSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        BocCaiBySalesSSDtlPage.routeName: (context) => BocCaiBySalesSSDtlPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitFoaPMAPage.routeName: (context) => MonitFoaPMAPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitFoaPMABySSPage.routeName: (context) => MonitFoaPMABySSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitFoaPMABySalesPage.routeName: (context) => MonitFoaPMABySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        StockByModelPage.routeName: (context) => const StockByModelPage(),
        StockByModelVtypePage.routeName: (context) => StockByModelVtypePage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        StockByModelVcolorPage.routeName: (context) => StockByModelVcolorPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        StockByModelVbranchPage.routeName: (context) => StockByModelVbranchPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekSaGRPage.routeName: (context) => ProspekSaGRPage(
            linkPageObj: ModalRoute.of(context)!.settings.arguments),
        ProspekSaGRBySANamePage.routeName: (context) => ProspekSaGRBySANamePage(
            linkPageObj: ModalRoute.of(context)!.settings.arguments),
        ProspekSaBPPage.routeName: (context) => ProspekSaBPPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekSaBPBySANamePage.routeName: (context) => ProspekSaBPBySANamePage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekGRtoUeBPPage.routeName: (context) => ProspekGRtoUeBPPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekGRtoUeBPBySANamePage.routeName: (context) =>
            ProspekGRtoUeBPBySANamePage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekBPtoUeGRPage.routeName: (context) => ProspekBPtoUeGRPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        ProspekBPtoUeGRBySANamePage.routeName: (context) =>
            ProspekBPtoUeGRBySANamePage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        TMSProductivityPage.routeName: (context) => TMSProductivityPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        BookingToShowPage.routeName: (context) => BookingToShowPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingAfterSalesPage.routeName: (context) => FunnelingAfterSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingByBranchAfterSalesPage.routeName: (context) =>
            FunnelingByBranchAfterSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        FunnelingByActualAfterSalesPage.routeName: (context) =>
            FunnelingByActualAfterSalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        BocCaiByPicBookingPage.routeName: (context) => BocCaiByPicBookingPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitoringPoinPage.routeName: (context) => const MonitoringPoinPage(),
        MonitoringPoinBySSPage.routeName: (context) => MonitoringPoinBySSPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitoringPoinBySalesPage.routeName: (context) =>
            MonitoringPoinBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitoringRedeemPage.routeName: (context) =>
            const MonitoringRedeemPage(),
        MonitoringRedeemBySSPage.routeName: (context) =>
            MonitoringRedeemBySSPage(
                linkPageObj: ModalRoute.of(context)!.settings.arguments),
        MonitoringRedeemBySalesPage.routeName: (context) =>
            MonitoringRedeemBySalesPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        MonitoringSaldoPage.routeName: (context) => const MonitoringSaldoPage(),
        MonitoringPoinHistoryPage.routeName: (context) =>
            MonitoringPoinHistoryPage(
              linkPageObj: ModalRoute.of(context)!.settings.arguments,
            ),
        TeamSayaPage.routeName: (context) => const TeamSayaPage(),
        RulesOftheGamePage.routeName: (context) => const RulesOftheGamePage(),
        ChangepassPage.routeName: (context) => const ChangepassPage(),
      },
      // home: const ProspectSalesPage(),
    );
  }
}
