import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RulesOftheGamePage extends StatefulWidget {
  const RulesOftheGamePage({super.key});
  static const String routeName = "/rulesOftheGamePage";

  @override
  State<RulesOftheGamePage> createState() => _RulesOftheGamePageState();
}

class _RulesOftheGamePageState extends State<RulesOftheGamePage> {
  Widget titleBar = const Text(
    "Rules Of The Game",
    style: TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: titleBar,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    var textStyleWhiteBU = TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
      decorationThickness: 2.0,
      color: Colors.white,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    var textStyleWhiteB = TextStyle(
      color: Colors.white,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    var textStyleWhite = TextStyle(
      color: Colors.white,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF00AA80),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "RULES OF THE GAME",
                          style: textStyleWhiteBU,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            text: "ACE",
                            style: textStyleWhiteB,
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' (ASTRIDO CUSTOMER ENGAGEMENT)',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ACE adalah Frequent Retention Program dari Astrido yang dirancang khusus "
                          "untuk menghargai para Frontliners Astrido yang gemar melakukan Aktivitas Retensi Pelanggan.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Frontliners akan mendapatkan Poin setiap kali melakukan aktivitas retensi pelanggan. "
                          "Jadi, semakin melakukan aktivitas retensi pelanggan, maka akan semakin besar keuntungan, hadiah, "
                          "dan manfaat yang di terima oleh Frontliners.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "BESARAN / JUMLAH POIN & CARA MEMPEROLEH POIN",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Semua Frontliners harus memiliki akun pribadi ACE masing-masing sebagai tempat pengkreditan poin yang diperoleh "
                          "dan untuk memperoleh akun pribadi ACE tersebut, maka Frontliners wajib mendaftarkan NIK mereka pada saat registrasi awal.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Jumlah poin yang akan didapatkan tergantung dari Jenis aktivitas retensi yang dilakukan dan besarnya poin berbeda-beda "
                          "sesuai dengan jenis aktivitas retesni yang dilakukan oleh Frontliners tersebut.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tidak sulit untuk mendapatkan Poin, cukup dengan melakukan aktivitas retensi pelanggan "
                          "sesuai jabatan Frontliners berikut ini:",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "WIRANIAGA",
                          style: textStyleWhiteBU,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromARGB(106, 0, 170, 128),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "AKTIVITAS",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "POIN",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Service Berkala & Booking",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Undang pelanggan anda untuk melakukan Servis Berkala & Booking melalui aplikasi ACE Anda hingga menjadi Unit Entry "
                                  "sesuai schedule Booking yang telah disepakati tersebut.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "300",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Service Berkala Tanpa Booking",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Bila pelanggan Anda belum bisa memberikan kepastian tanggal booking, namun akhirnya "
                                  "menjadi Unit Entry dalam kurun waktu 1 (satu) bulan setelah Anda undang.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "50",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "DO Melalui Mekanisme Corong",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text.rich(
                                  TextSpan(
                                    style: textStyleWhite,
                                    text:
                                        "👉 Dapatkan DO Customer Retail dengan memanfaatkan menu Prospect Sales (mekanisme corong / ",
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: "funneling) ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "pada aplikasi ACE. Poin akan Anda terima setelah unit tersebut di-",
                                      ),
                                      TextSpan(
                                        text: "gatepass ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "serta tidak berlaku untuk penjualan Fleet / Big Deal.",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "150",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "RO Leasing",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text.rich(
                                  TextSpan(
                                    style: textStyleWhite,
                                    text:
                                        "👉 Lakukan reminder saat pembayaran leasing pelanggan Anda akan berakhir dan dapatkan RO (",
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: "Repeat Order",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ") dari pelanggan tersebit dalam kurum waktu 3 (tiga) bulan. Dengan mendapatkan RO, maka otomatis Anda akan mendapatkan"
                                            'juga poin dari aktivitas "DO melalui Mekanisme Corong" (lihat di atas) ',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "20",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Reminder Perpanjangan Asuransi",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Lakukan reminder perpanjangan Asuransi kepada pelanggan saat pembayaran leasingnya akan berakhir.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "5",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Transaksi Perpanjangan Asuransi",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Dapatkan Transaksi perpanjangan Asuransi dari pelanggan yang telah di-reminder.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "50",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Transaksi Perpanjangan STNK",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Dapatkan Transaksi perpanjangan STNK dari pelanggan yang telah di-reminder.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "100",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Birthday Wishes",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '👉 Ucapkan "Selamat Ulang Tahun" kepada pelanggan Anda pada hari ulang tahunnya. ',
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "5",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Penalti",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Untuk setiap informasi palsu / tidak valid yang akan dimasukkan ke dalam aplikasi ACE akan mendapatkan penalty sebesar -50 poin. ",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "-50",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "SA (GR)",
                          style: textStyleWhiteBU,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromARGB(106, 0, 170, 128),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "AKTIVITAS",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "POIN",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prospek Untuk Showroom",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Jajaki kemungkinan pelanggan bengkel GR untuk melakukan pembelian Kendaraan Baru dalam waktu "
                                  "dekat (informasi data pelanggan yang diperoleh dari dokumen SPP) dengan memasukkan data prospek pelanggan "
                                  "tersebut ke dalam aplikasi ACE sehingga dapat ditransfer kepada Wiraniaga untuk di kelola "
                                  "dan dikonversi menjadi penjualan unit (DO) dalam kurun waktu 3 (tiga) bulan.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "600",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prospek Untuk BP",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Tawarkan perbaikan Body / Cat jika ada baret / penyok di kendaraan pelanggan pada saat servis di bengkel "
                                  "GR sehingga menjadi Unit Entry di Bengkel BP Astrido dalam kurun waktu 1 (satu) bulan setelah ditawarkan.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "500",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Birthday Wishes",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '👉 Ucapkan "Selamat Ulang Tahun" kepada pelanggan Anda pada hari ulang tahunnya. ',
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "5",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Penalti",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Untuk setiap informasi palsu / tidak valid yang akan dimasukkan ke dalam aplikasi ACE akan mendapatkan penalty sebesar -50 poin. ",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "-50",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "SA (BP)",
                          style: textStyleWhiteBU,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromARGB(106, 0, 170, 128),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "AKTIVITAS",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "POIN",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prospek Untuk Showroom",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Jajaki kemungkinan pelanggan bengkel BP untuk melakukan pembelian Kendaraan Baru dalam waktu "
                                  "dekat (informasi data pelanggan yang diperoleh dari dokumen SPP) dengan memasukkan data prospek pelanggan "
                                  "tersebut ke dalam aplikasi ACE sehingga dapat ditransfer kepada Wiraniaga untuk di kelola"
                                  "dan dikonversi menjadi penjualan unit (DO) dalam kurun waktu 3 (tiga) bulan.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "600",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prospek Untuk GR",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Tawarkan Service Berkala & Booking pada saat pelanggan Anda melakukan perbaikan Body / Cat "
                                  "sehingga menjadi Unit Entry di Bengkel GR setempat.",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "300",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 120.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prospek Customer Dealers Lain",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Referensikan bengkel GR Astrido kepada pelanggan BP yang tidak membeli kendaraannya dari Astrdio "
                                  "untuk melakukan Service Berkala di bengkel GR Astrido, hingga menjadi Unit Entry Bengkel Astrido dalam kurun "
                                  "waktu 6 (enam) bulan",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "500",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Birthday Wishes",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '👉 Ucapkan "Selamat Ulang Tahun" kepada pelanggan Anda pada hari ulang tahunnya. ',
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "5",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: ResponsiveValue<double>(
                            context,
                            conditionalValues: [
                              const Condition.equals(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                              ),
                              const Condition.largerThan(
                                name: TABLET,
                                value: 120.0,
                                landscapeValue: 120.0,
                                breakpoint: 800,
                              ),
                              const Condition.equals(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                              ),
                              const Condition.largerThan(
                                name: DESKTOP,
                                value: 110.0,
                                landscapeValue: 110.0,
                                breakpoint: 800,
                              ),
                            ],
                            defaultValue: 102.0,
                          ).value,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Penalti",
                                  style: textStyleWhiteB,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 45, 100, 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "👉 Untuk setiap informasi palsu / tidak valid yang akan dimasukkan ke dalam aplikasi ACE akan mendapatkan penalty sebesar -50 poin. ",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "-50",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "MEMAHAMI STATUS POIN & STATUS LEVEL",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ACE memiliki 3 tingkatan Status Level (Basic - Silver - Gold) yang semuanya memberi Anda kesempatan untuk "
                          "menikmati lebih banyak Poin & beragam Hadiah.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Semakin sering Anda melakukan aktivitas retensi pelanggan, semakin cepat Anda mencapai Level yang lebih tinggi. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromARGB(106, 0, 170, 128),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "STATUS POIN",
                              style: textStyleWhiteB,
                            ),
                            Text(
                              "STATUS LEVEL",
                              style: textStyleWhiteB,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(55, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "< 25,000 poin",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 80, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "BASIC",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "≥ 25,000 s.d < 50,0000 poin",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 77, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "SILVER",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 49, 49, 49),
                              blurRadius: 5.0,
                              offset: Offset(0, 0),
                              spreadRadius: 2.1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFF00AA80),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(55, 15, 20, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "≥ 50,000 poin",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 83, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "GOLD",
                                  style: textStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level BASIC",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Setelah men-download Aplikasi, Anda akan diberikan Nama User & Password yang nantinya dapa Anda ubah sendiri di menu Setting. "
                          "Anda lalu dapat mulai untuk mengumpulkan poin.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Untuk mendapatkan poin, Anda cukup melakukan berbagai aktivitas retensi pelanggan. Semakin sering Anda melakukan "
                          "Aktivitas retensi pelanggan, akan semakin banyak poin yang Anda dapatkan.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gunakan poin Anda untuk ditukarkan langsung dengan beragam hadiah. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level SILVER",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dibutuhkan 25,000 poin untuk mencapai level Silver. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kumpulkan minimal 25,000 poin dalam periode 1 Tahun (Januari s.d Desember) dan Anda akan mendapatkan "
                          "upgrade ke level Silver pada tahun berikutnya.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Masa berlaku untuk status level Anda adalah sampai dengan akhir tahun berikutnya. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level GOLD",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dibutuhkan 50,000 poin untuk mencapai level Gold. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dengan mengumpulkan 50,000 poin dalam periode 1 Tahun (Januari s.d Desember) dan Anda akan mendapatkan "
                          "upgrade ke level Gold pada tahun berikutnya.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Masa berlaku untuk status level Anda adalah sampai dengan akhir tahun berikutnya. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status poin akan di're-set kembali pada setiap Awal Tahun (tanggal 01 Januari). ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          const TextSpan(
                            text:
                                "Note : Khusus untuk 01 Januari 2019, status poin Tidak direset. ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "MEMAHAMI REWARD POIN & TRANSFER REWARD POIN",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reward Poin adalah akumulasi poin selama periode 1 Tahun (Januari s.d Desember) ditambah dengan transfer poin dari tahun "
                          "sebelumnya yang dapat ditukar dengan beragam hadiah menarik.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ketentuan / aturan yang berlaku untuk Transfer Reward Poin dari periode/tahun sebelumnya adalah sbb: ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level Basic : ",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reward Poin yang belum ditukar pada akhir periode akan ditransfer 50% ke periode berikutnya. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level Silver : ",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reward Poin yang belum ditukar pada akhir periode akan ditransfer 75% ke periode berikutnya. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Level Gold : ",
                          style: textStyleWhiteB,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reward Poin yang belum ditukar pada akhir periode akan ditransfer 100% ke periode berikutnya. ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Khusus unutk masa peralihan periode dari 31 Desember 2018 ke 01 Januari 2019, Reward Poin akan ditransfer 100% "
                          "untuk semua level.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reward Poin yang terkumpul akan dapat digunakan kapan saja untuk ditukar langsung dengan beraneka hadiah menarik "
                          "melalui aplikasi ACE pada smartphone Anda.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "So, tunggu apa lagi guys? ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Segera log-in hari ini dan langsung kumpulkan poin sebanyak-banyaknya dengan aplikasi ACE "
                          "unutk menikmati berbagai hadiahnya.",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Happy Selling 🙂 ",
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          const TextSpan(
                            text:
                                "Retensi Selalu Pelanggan Anda,\nBuat mereka merasa Penting & Spesial !!! ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: textStyleWhite,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
