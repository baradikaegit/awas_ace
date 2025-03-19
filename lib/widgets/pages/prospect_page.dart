// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/api_error.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/succes_submit.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/main_page.dart';
import 'package:awas_ace/widgets/model/custtypemodel.dart';
import 'package:awas_ace/widgets/model/kisaranhargamodel.dart';
import 'package:awas_ace/widgets/model/prospectmodel.dart';
import 'package:awas_ace/widgets/model/sumberdatamodel.dart';
import 'package:awas_ace/widgets/model/tipepelangganmodel.dart';
import 'package:awas_ace/widgets/model/vfueltransmisimodel.dart';
import 'package:awas_ace/widgets/model/vgroupmodel.dart';
import 'package:awas_ace/widgets/model/wilayah.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProspectPage extends ConsumerStatefulWidget {
  const ProspectPage({super.key});

  static const String routeName = "/prospectPage";

  @override
  _ProspectPageState createState() => _ProspectPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ProspectPageState extends ConsumerState<ProspectPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // final formkey = GlobalKey<FormState>();

  //STEP 1
  TextEditingController tglContactController = TextEditingController();
  final TextEditingController branchBusinessIDController =
      TextEditingController();
  final TextEditingController salesmanIDController = TextEditingController();
  TextEditingController lokasiBertemuController = TextEditingController();
  final TextEditingController idKodePosController = TextEditingController();
  final TextEditingController kodePosController = TextEditingController();
  final TextEditingController idAreaController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController sumberDataController = TextEditingController();
  final TextEditingController rencanaPembelianController =
      TextEditingController();
  final TextEditingController prospectStatusController =
      TextEditingController();

  //STEP 2
  TextEditingController nameContactContactController = TextEditingController();
  TextEditingController noHP1ContactController = TextEditingController();
  TextEditingController noHP2ContactController = TextEditingController();
  final TextEditingController jKController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  final TextEditingController idKodePosS2Controller = TextEditingController();
  final TextEditingController kodePosS2Controller = TextEditingController();
  final TextEditingController idAreaS2Controller = TextEditingController();
  final TextEditingController areaS2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController idCustTypeS2Controller = TextEditingController();
  final TextEditingController custTypeS2Controller = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  final TextEditingController hKendaraanController = TextEditingController();
  final TextEditingController tipePelangganController = TextEditingController();

  //STEP 3
  TextEditingController vGroupController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController vFuelController = TextEditingController();
  TextEditingController vTransmisiController = TextEditingController();
  TextEditingController vGroup2Controller = TextEditingController();
  TextEditingController tahun2Controller = TextEditingController();
  TextEditingController vFuel2Controller = TextEditingController();
  TextEditingController vTransmisi2Controller = TextEditingController();

  //STEP 4
  TextEditingController cashLeasingController = TextEditingController();
  TextEditingController dPController = TextEditingController();
  TextEditingController tenorController = TextEditingController();
  final TextEditingController q1Controller = TextEditingController();
  final TextEditingController q2Controller = TextEditingController();
  final TextEditingController q3Controller = TextEditingController();
  final TextEditingController q4Controller = TextEditingController();
  final TextEditingController q5Controller = TextEditingController();
  final TextEditingController q6Controller = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController alasanLostProspectController =
      TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  late TabController _tabController;

  //STEP 1
  String nameProv = '';
  String nameKab = '';
  String nameKec = '';
  String nameKel = '';
  String idKodePos = '';
  String kodePos = '';
  String idArea = '';
  String area = '';
  String iDSumberData = '';
  String sumberData = '';
  int? iDRencanaPembelian;
  String rencanaPembelian = '';

  //STEP 2
  String jkValue = '';
  int jkId = 0;
  String nameProvS2 = '';
  String nameKabS2 = '';
  String nameKecS2 = '';
  String nameKelS2 = '';
  String idKodePosS2 = '';
  String kodePosS2 = '';
  String idAreaS2 = '';
  String areaS2 = '';
  String idTipeCustS2 = '';
  String tipeCustS2 = '';
  int? valTipeCutS2;
  String jabatanVal = '';
  String hargaKendaraan = '';
  String idHargaKendaraan = '';
  String idTipePelanggan = '';
  String tipePelanggan = '';

  //STEP 3
  String idVGroup = '';
  String vGroup = '';
  String tahunVal = '';
  String idVfuel = '';
  String vFuel = '';
  String idVtransmisi = '';
  String vTransmisi = '';
  String idVGroup2 = '';
  String vGroup2 = '';
  String tahunVal2 = '';
  String idVfuel2 = '';
  String vFuel2 = '';
  String idVtransmisi2 = '';
  String vTransmisi2 = '';

  //STEP 4
  String cashLeasingVal = '';
  String dPVal = '';
  String tenorVal = '';
  bool checkQ1 = false;
  bool checkQ2 = false;
  bool checkQ3 = false;
  bool checkQ4 = false;
  bool checkQ5 = false;
  bool checkQ6 = false;
  bool checkQ7 = false;
  bool checkQ8 = false;
  bool checkQ9 = false;
  bool checkQ10 = false;
  bool checkQ11 = false;
  bool checkQ12 = false;
  int? idStatus;
  String status = '';
  int? idAlasanLp;
  String alasanLp = '';

  final List _dataFromApi = [];
  final List _dataFromApiArea = [];

  List<ModelSelect> rencanaPembelianOptions = [
    ModelSelect('1 Minggu Kedepan', 1),
    ModelSelect('2 Minggu Kedepan', 2),
    ModelSelect('3 Minggu Kedepan', 3),
    ModelSelect('1 Bulan Kedepan', 4),
    ModelSelect('Lebih Dari 1 Bulan Kedepan', 5)
  ];

  List<ModelSelect> jKOptions = [
    ModelSelect('Laki - Laki', 1),
    ModelSelect('Perempuan', 0)
  ];

  List<ModelSelect> jabatanOptions = [
    ModelSelect('Karyawan Swasta', 1),
    ModelSelect('PNS', 2),
    ModelSelect('Karyawan BUMN', 3),
    ModelSelect('Wiraswasta / Bisnis / Usaha', 4),
    ModelSelect('Pelajar / Mahasiswa', 5),
    ModelSelect('Profesional (Dokter, Polisi, Pengacara, Militer)', 6),
    ModelSelect('Bapak / Ibu Rumah Tangga', 7),
    ModelSelect('Lainnya', 8),
  ];

  List<ModelSelect> cashLeasingOptions = [
    ModelSelect('Cash', 1),
    ModelSelect('Leasing', 2)
  ];

  List<ModelSelect> dPOptions = [
    ModelSelect('20%', 1),
    ModelSelect('25%', 2),
    ModelSelect('>= 30%', 3),
  ];

  List<ModelSelect> tenorOptions = [
    ModelSelect('1 Tahun', 1),
    ModelSelect('2 Tahun', 2),
    ModelSelect('3 Tahun', 3),
    ModelSelect('4 Tahun', 4),
    ModelSelect('5 Tahun', 5),
    ModelSelect('6 Tahun', 6),
    ModelSelect('7 Tahun', 7),
  ];

  List<ModelSelect> statusOptions = [
    ModelSelect('Prospect', 1),
    ModelSelect('Lost Prospect', 2),
  ];

  List<ModelSelect> alasanLpOptions = [
    ModelSelect('Discount', 1),
    ModelSelect('Stock Tidak Tersedia', 2),
    ModelSelect('Beli Brand Lain', 3),
    ModelSelect('Leasing', 4),
    ModelSelect('Force Major', 5),
  ];

  void fetchDataKodePos(
      String nameProv, String nameKab, String nameKec, String nameKel) async {
    var url = Uri.parse(
      "${urlApi()}Wilayah/GetWilayahKodePos/$nameProv/$nameKab/$nameKec/$nameKel",
    );

    //print(url);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("login");

      var response = await http.get(url, headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      if (response.statusCode == 200) {
        List data =
            (jsonDecode(response.body) as Map<String, dynamic>)["listWilayah"];

        for (var element in data) {
          _dataFromApi.add(element);
        }

        setState(() {
          for (int a = 0; a < _dataFromApi.length; a++) {
            idKodePos = _dataFromApi[a]["iD"];
            kodePos = _dataFromApi[a]["text"];
            idKodePosController.text = idKodePos;
            kodePosController.text = kodePos;

            fetchDataFromApi(idKodePos);
            // print("KodePos : $idKodePos");
          }
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);

        catchApiError(context);
      }
    } catch (e) {
      catchError(context, e);
    }
  }

  void fetchDataFromApi(String idKodePos) async {
    var url = Uri.parse(
      "${urlApi()}Wilayah/GetWilayahArea/$idKodePos",
    );

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("login");

      var responseArea = await http.get(url, headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      if (responseArea.statusCode == 200) {
        List dataArea = (jsonDecode(responseArea.body)
            as Map<String, dynamic>)["listWilayah"];

        for (var e in dataArea) {
          _dataFromApiArea.add(e);
        }

        setState(() {
          for (int areaObj = 0; areaObj < _dataFromApiArea.length; areaObj++) {
            idArea = _dataFromApiArea[areaObj]["ring"];
            area = _dataFromApiArea[areaObj]["ringKet"];

            idAreaController.text = idArea;
            areaController.text = area;
          }
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);

        catchApiError(context);
      }
    } catch (e) {
      catchError(context, e);
    }
  }

  void fetchDataKodePosS2(String nameProvS2, String nameKabS2, String nameKecS2,
      String nameKelS2) async {
    var url = Uri.parse(
      "${urlApi()}Wilayah/GetWilayahKodePos/$nameProvS2/$nameKabS2/$nameKecS2/$nameKelS2",
    );

    //print(url);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("login");

      var response = await http.get(url, headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      if (response.statusCode == 200) {
        List data =
            (jsonDecode(response.body) as Map<String, dynamic>)["listWilayah"];

        for (var element in data) {
          _dataFromApi.add(element);
        }

        setState(() {
          for (int a = 0; a < _dataFromApi.length; a++) {
            idKodePosS2 = _dataFromApi[a]["iD"];
            kodePosS2 = _dataFromApi[a]["text"];
            idKodePosS2Controller.text = idKodePosS2;
            kodePosS2Controller.text = kodePosS2;

            fetchDataFromApiS2(idKodePosS2);
          }
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);

        catchApiError(context);
      }
    } catch (e) {
      catchError(context, e);
    }
  }

  void fetchDataFromApiS2(String idKodePosS2) async {
    var url = Uri.parse(
      "${urlApi()}Wilayah/GetWilayahArea/$idKodePosS2",
    );

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("login");

      var responseArea = await http.get(url, headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      if (responseArea.statusCode == 200) {
        List dataArea = (jsonDecode(responseArea.body)
            as Map<String, dynamic>)["listWilayah"];

        for (var e in dataArea) {
          _dataFromApiArea.add(e);
        }

        setState(() {
          for (int areaObj = 0; areaObj < _dataFromApiArea.length; areaObj++) {
            idAreaS2 = _dataFromApiArea[areaObj]["ring"];
            areaS2 = _dataFromApiArea[areaObj]["ringKet"];

            idAreaS2Controller.text = idAreaS2;
            areaS2Controller.text = areaS2;
          }
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);

        catchApiError(context);
      }
    } catch (e) {
      catchError(context, e);
    }
  }

  String dateNow = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String? userName;
  String? sid;
  String? branchID;

  final List<Color> indicatorColors = [
    const Color.fromARGB(255, 109, 149, 79), // Warna untuk Step 1
    const Color.fromARGB(255, 15, 70, 128), // Warna untuk Step 2
    const Color.fromARGB(255, 215, 156, 18), // Warna untuk Step 3
    const Color.fromARGB(255, 150, 11, 18), // Warna untuk Step 4
  ];

  Color currentIndicatorColor =
      const Color.fromARGB(255, 109, 149, 79); // Default warna Step 1

  @override
  void initState() {
    super.initState();
    tglContactController.text = dateNow;

    q1Controller.text = '0';
    q2Controller.text = '0';
    q3Controller.text = '0';
    q4Controller.text = '0';
    q5Controller.text = '0';
    q6Controller.text = '0';
    alasanLostProspectController.text = '0';
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndicatorColor = indicatorColors[_tabController.index];
      });
    });
    loadSharedPreference();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('Username');
      sid = prefs.getString('SID');
      branchID = prefs.getString('BranchID');

      branchBusinessIDController.text = branchID!.toUpperCase();
      salesmanIDController.text = sid!.toUpperCase();
    });
  }

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
              name: TABLET, value: 17.0, landscapeValue: 17.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.5,
      ).value,
    );

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Entry Prospect Sales",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: Material(
                color: const Color.fromARGB(
                  255,
                  3,
                  116,
                  18,
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    splashColor: const Color.fromARGB(
                      255,
                      3,
                      116,
                      18,
                    ),
                  ),
                  child: TabBar(
                    dividerHeight: 0,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.green,
                    isScrollable: false,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              109,
                              149,
                              79,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "STEP 1 ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveValue<double>(
                                    context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 16.0,
                                          landscapeValue: 16.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 20.0,
                                          landscapeValue: 20.0,
                                          breakpoint: 800),
                                    ],
                                    defaultValue: 12.0,
                                  ).value,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.sticky_note_2_outlined,
                                      color: Colors.white,
                                      size: ResponsiveValue<double>(
                                        context,
                                        conditionalValues: [
                                          const Condition.equals(
                                              name: TABLET,
                                              value: 20.0,
                                              landscapeValue: 20.0),
                                          const Condition.largerThan(
                                              name: TABLET,
                                              value: 24.0,
                                              landscapeValue: 24.0,
                                              breakpoint: 800),
                                        ],
                                        defaultValue: 15.0,
                                      ).value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              15,
                              70,
                              128,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "STEP 2 ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveValue<double>(
                                    context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 16.0,
                                          landscapeValue: 16.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 20.0,
                                          landscapeValue: 20.0,
                                          breakpoint: 800),
                                    ],
                                    defaultValue: 12.0,
                                  ).value,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.person_add_alt_outlined,
                                      color: Colors.white,
                                      size: ResponsiveValue<double>(
                                        context,
                                        conditionalValues: [
                                          const Condition.equals(
                                              name: TABLET,
                                              value: 20.0,
                                              landscapeValue: 20.0),
                                          const Condition.largerThan(
                                              name: TABLET,
                                              value: 24.0,
                                              landscapeValue: 24.0,
                                              breakpoint: 800),
                                        ],
                                        defaultValue: 15.0,
                                      ).value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              215,
                              156,
                              18,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "STEP 3 ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveValue<double>(
                                    context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 16.0,
                                          landscapeValue: 16.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 20.0,
                                          landscapeValue: 20.0,
                                          breakpoint: 800),
                                    ],
                                    defaultValue: 12.0,
                                  ).value,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.directions_car,
                                      color: Colors.white,
                                      size: ResponsiveValue<double>(
                                        context,
                                        conditionalValues: [
                                          const Condition.equals(
                                              name: TABLET,
                                              value: 20.0,
                                              landscapeValue: 20.0),
                                          const Condition.largerThan(
                                              name: TABLET,
                                              value: 24.0,
                                              landscapeValue: 24.0,
                                              breakpoint: 800),
                                        ],
                                        defaultValue: 15.0,
                                      ).value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              150,
                              11,
                              18,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "STEP 4 ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveValue<double>(
                                    context,
                                    conditionalValues: [
                                      const Condition.equals(
                                          name: TABLET,
                                          value: 16.0,
                                          landscapeValue: 16.0),
                                      const Condition.largerThan(
                                          name: TABLET,
                                          value: 20.0,
                                          landscapeValue: 20.0,
                                          breakpoint: 800),
                                    ],
                                    defaultValue: 12.0,
                                  ).value,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.handshake,
                                      color: Colors.white,
                                      size: ResponsiveValue<double>(
                                        context,
                                        conditionalValues: [
                                          const Condition.equals(
                                              name: TABLET,
                                              value: 20.0,
                                              landscapeValue: 20.0),
                                          const Condition.largerThan(
                                              name: TABLET,
                                              value: 24.0,
                                              landscapeValue: 24.0,
                                              breakpoint: 800),
                                        ],
                                        defaultValue: 15.0,
                                      ).value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(
              255,
              3,
              116,
              18,
            ),
            elevation: 0,
          ),
          backgroundColor: const Color.fromARGB(
            255,
            3,
            116,
            18,
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        109,
                        149,
                        79,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "PROSPECTING",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                BootstrapContainer(
                                  fluid: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  children: <Widget>[
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tanggal Contact :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller:
                                                      tglContactController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tanggal Contact',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText:
                                                        'Tanggal Contact',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2050),
                                                    );
                                                    if (pickedDate != null) {
                                                      String formatDate =
                                                          DateFormat(
                                                                  'MM/dd/yyyy')
                                                              .format(
                                                                  pickedDate);

                                                      setState(() {
                                                        tglContactController
                                                            .text = formatDate;
                                                      });
                                                    } else {
                                                      //print("Tanggal tidak dipilih");

                                                      tglContactController
                                                          .text = dateNow;
                                                    }
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      branchBusinessIDController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'BranchBusinessID',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      salesmanIDController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'SalesmanID',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Lokasi Bertemu :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  controller:
                                                      lokasiBertemuController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Lokasi bertemu tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Lokasi Bertemu',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Lokasi Bertemu',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Provinsi :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Provinsi tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.text.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Provinsi',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameProv = value!.text;
                                                      nameKab = '';
                                                      nameKec = '';
                                                      nameKel = '';
                                                      kodePosController.clear();
                                                      idKodePosController
                                                          .clear();
                                                      idAreaController.clear();
                                                      areaController.clear();
                                                      // print(
                                                      //     "idProvinsi : $nameProv");
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameProv != ''
                                                        ? nameProv.toUpperCase()
                                                        : "Belum memilih provinsi",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahProvinsi",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kota :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kota tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kota',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKab = value!.text;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKab != ''
                                                        ? nameKab.toUpperCase()
                                                        : "Belum memilih kota",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKota/$nameProv",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kecamatan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kecamatan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kecamatan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKec = value!.text;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKec != ''
                                                        ? nameKec.toUpperCase()
                                                        : "Belum memilih kecamatan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKecamatan/$nameProv/$nameKab",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kelurahan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kelurahan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kelurahan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKel = value!.text;
                                                      fetchDataKodePos(
                                                          nameProv,
                                                          nameKab,
                                                          nameKec,
                                                          nameKel);
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKel != ''
                                                        ? nameKel.toUpperCase()
                                                        : "Belum memilih kelurahan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKelurahan/$nameProv/$nameKab/$nameKec",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kode Pos :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller: kodePosController,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Kode Pos tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Kode Pos',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Kode Pos',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      idKodePosController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Kode Pos',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Area :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  controller: areaController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Area tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Area',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Area',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: idAreaController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Area',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Sumber Data :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<SumberData>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Sumber data tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                        vertical:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.name.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Sumber Data',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      iDSumberData = value!.iD;
                                                      sumberData = value.name;
                                                      sumberDataController
                                                          .text = iDSumberData;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    sumberData != ''
                                                        ? sumberData
                                                            .toUpperCase()
                                                        : "Belum memilih sumber data",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetSumberData",
                                                      ),
                                                    );

                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allSumberData =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listSumberData"];
                                                    List<SumberData>
                                                        allModelSumberData = [];

                                                    for (var element
                                                        in allSumberData) {
                                                      allModelSumberData.add(
                                                        SumberData(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelSumberData;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      sumberDataController,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Sumber Data',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Rencana Pembelian :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<ModelSelect>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.value == '') {
                                                      return "Rencana pembelian tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items:
                                                      rencanaPembelianOptions,
                                                  itemAsString: (ModelSelect
                                                          rencanaPembelianOptions) =>
                                                      rencanaPembelianOptions
                                                          .value
                                                          .toUpperCase(),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText:
                                                          'Rencana Pembelian',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged:
                                                      (ModelSelect? value) {
                                                    setState(() {
                                                      iDRencanaPembelian =
                                                          value!.id;
                                                      rencanaPembelian =
                                                          value.value;
                                                      rencanaPembelianController
                                                              .text =
                                                          iDRencanaPembelian
                                                              .toString();

                                                      if (iDRencanaPembelian ==
                                                              4 ||
                                                          iDRencanaPembelian ==
                                                              5) {
                                                        prospectStatusController
                                                            .text = '1';
                                                      } else if (iDRencanaPembelian ==
                                                          3) {
                                                        prospectStatusController
                                                            .text = '2';
                                                      } else {
                                                        prospectStatusController
                                                            .text = '3';
                                                      }
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    rencanaPembelian != ''
                                                        ? rencanaPembelian
                                                            .toUpperCase()
                                                        : "Belum memilih rencana pembelian",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      rencanaPembelianController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Rencana Pembelian',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      prospectStatusController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Prospect Status',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        15,
                        70,
                        128,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "GREETING & QUALIFYING",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                BootstrapContainer(
                                  fluid: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  children: <Widget>[
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Nama Contact :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller:
                                                      nameContactContactController,
                                                  autocorrect: false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Nama contact tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Nama Contact',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Nama Contact',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "No HP1 :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller:
                                                      noHP1ContactController,
                                                  autocorrect: false,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "No HP1 tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'No HP1',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'No HP1',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "No HP2 :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller:
                                                      noHP2ContactController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "No HP2 tidak boleh kosong.";
                                                    }
                                                    return null;
                                                  },
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'No HP2',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'No HP2',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Jenis Kelamin :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: Container(
                                                  height: 55,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 0, 25, 0),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      15,
                                                      70,
                                                      128,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: double.infinity,
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              20.0),
                                                                    ),
                                                                  ),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ListView.separated(
                                                                        itemCount: jKOptions.length,
                                                                        separatorBuilder: (context, int int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder: (context, indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(jKOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  jkValue = jKOptions[indexSelect].value.toUpperCase();
                                                                                  jkId = jKOptions[indexSelect].id;
                                                                                  jKController.text = jkId.toString();
                                                                                });
                                                                                Navigator.of(context).pop();
                                                                              });
                                                                        });
                                                                  });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      80,
                                                                      5,
                                                                      80,
                                                                      5),
                                                              child: Text(
                                                                jkValue != ''
                                                                    ? jkValue
                                                                    : "CHOOSE",
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: jKController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Jenis Kelamin',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Alamat :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller: alamatController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Alamat tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Alamat',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Alamat',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Provinsi :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Provinsi tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Provinsi',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameProvS2 = value!.text;
                                                      nameKabS2 = '';
                                                      nameKecS2 = '';
                                                      nameKelS2 = '';
                                                      idKodePosS2Controller
                                                          .clear();
                                                      kodePosS2Controller
                                                          .clear();

                                                      // print(
                                                      //     "idProvinsi : $nameProvS2");
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameProvS2 != ''
                                                        ? nameProvS2
                                                            .toUpperCase()
                                                        : "Belum memilih provinsi",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahProvinsi",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kota :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kota tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kota',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKabS2 = value!.text;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKabS2 != ''
                                                        ? nameKabS2
                                                            .toUpperCase()
                                                        : "Belum memilih kota",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKota/$nameProvS2",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "kecamatan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kecamatan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kecamatan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKecS2 = value!.text;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKecS2 != ''
                                                        ? nameKecS2
                                                            .toUpperCase()
                                                        : "Belum memilih kecamatan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKecamatan/$nameProvS2/$nameKabS2",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kelurahan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Wilayah>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.text == '') {
                                                      return "Kelurahan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.text
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Kelurahan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameKelS2 = value!.text;
                                                      fetchDataKodePosS2(
                                                        nameProvS2,
                                                        nameKabS2,
                                                        nameKecS2,
                                                        nameKelS2,
                                                      );
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    nameKelS2 != ''
                                                        ? nameKelS2
                                                            .toUpperCase()
                                                        : "Belum memilih kelurahan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetWilayahKelurahan/$nameProvS2/$nameKabS2/$nameKecS2",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allWilayah =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listWilayah"];
                                                    List<Wilayah>
                                                        allModelWilayah = [];

                                                    for (var element
                                                        in allWilayah) {
                                                      allModelWilayah.add(
                                                        Wilayah(
                                                          no: element["no"],
                                                          text: element["text"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelWilayah;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kode Pos :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      kodePosS2Controller,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Kode pos tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Kode Pos',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Kode Pos',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      idKodePosS2Controller,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Kode Pos',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Area :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller: areaS2Controller,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Area tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'Area',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Area',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      idAreaS2Controller,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Area',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "E-mail :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller: emailController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        !value
                                                            .toString()
                                                            .contains('@')) {
                                                      return "E-mail tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        17,
                                                        0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    hintText: 'E-mail',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'E-mail',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tipe Customer :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<CustType>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Tipe Customer tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.name
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText:
                                                          'Tipe Customer',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idTipeCustS2 =
                                                          value!.iD.toString();
                                                      tipeCustS2 = value.name;
                                                      valTipeCutS2 = value.val;

                                                      idCustTypeS2Controller
                                                          .text = idTipeCustS2;
                                                      custTypeS2Controller
                                                          .text = tipeCustS2;

                                                      if (valTipeCutS2 == 2 ||
                                                          valTipeCutS2 == 1) {
                                                        q1Controller.text = "0";
                                                        q2Controller.text = "0";
                                                        q3Controller.text = "0";
                                                        q4Controller.text = "0";
                                                        q5Controller.text = "0";
                                                        q6Controller.text = "0";

                                                        checkQ1 = false;
                                                        checkQ2 = false;
                                                        checkQ3 = false;
                                                        checkQ4 = false;
                                                        checkQ5 = false;
                                                        checkQ6 = false;
                                                        checkQ7 = false;
                                                        checkQ8 = false;
                                                        checkQ9 = false;
                                                        checkQ10 = false;
                                                        checkQ11 = false;
                                                        checkQ12 = false;
                                                      }
                                                      // print(
                                                      //     "idProvinsi : $nameProvS2");
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    tipeCustS2 != ''
                                                        ? tipeCustS2
                                                            .toUpperCase()
                                                        : "Belum memilih tipe customer",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetCustType",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allCustType =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listCustType"];
                                                    List<CustType>
                                                        allModelCustType = [];

                                                    for (var element
                                                        in allCustType) {
                                                      allModelCustType.add(
                                                        CustType(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                          val: element["val"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelCustType;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      idCustTypeS2Controller,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tipe Customer',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Jabatan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<ModelSelect>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.value == '') {
                                                      return "Jabatan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps:
                                                      const PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps: DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search...",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: jabatanOptions,
                                                  itemAsString: (ModelSelect
                                                          jabatanOpt) =>
                                                      jabatanOpt.value
                                                          .toUpperCase(),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Jabatan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged:
                                                      (ModelSelect? value) {
                                                    setState(() {
                                                      //print(value);
                                                      jabatanVal = value!.value;
                                                      jabatanController.text =
                                                          jabatanVal;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    jabatanVal != ''
                                                        ? jabatanVal
                                                            .toUpperCase()
                                                        : "Belum memilih Jabatan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: jabatanController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Jabatan',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kisaran Harga Kendaraan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    KisaranHarga>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Kisaran harga kendaraan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.name),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText:
                                                          'Kisaran Harga Kendaraan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idHargaKendaraan =
                                                          value!.iD.toString();
                                                      hargaKendaraan =
                                                          value.name;

                                                      hKendaraanController
                                                              .text =
                                                          idHargaKendaraan;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    hargaKendaraan != ''
                                                        ? hargaKendaraan
                                                        : "Belum memilih kisaran harga kendaraan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetKisaranHarga",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allKisaranHarga =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listKisaranHarga"];
                                                    List<KisaranHarga>
                                                        allModelKisaranHarga =
                                                        [];

                                                    for (var element
                                                        in allKisaranHarga) {
                                                      allModelKisaranHarga.add(
                                                        KisaranHarga(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelKisaranHarga;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      hKendaraanController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Kisaran Harga Kendaraan',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tipe Pelanggan :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    TipePelanggan>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Tipe pelanggan tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              1,
                                                              53,
                                                              131,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(item.name
                                                          .toUpperCase()),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText:
                                                          'Tipe Pelanggan',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idTipePelanggan =
                                                          value!.iD;
                                                      tipePelanggan =
                                                          value.name;

                                                      tipePelangganController
                                                              .text =
                                                          idTipePelanggan;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    tipePelanggan != ''
                                                        ? tipePelanggan
                                                        : "Belum memilih tipe pelanggan",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetTipePelanggan",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allTipePelanggan =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listTipePelanggan"];
                                                    List<TipePelanggan>
                                                        allModelTipePelanggan =
                                                        [];

                                                    for (var element
                                                        in allTipePelanggan) {
                                                      allModelTipePelanggan.add(
                                                        TipePelanggan(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelTipePelanggan;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      tipePelangganController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tipe Pelanggan',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        215,
                        156,
                        18,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "PERSENTATION",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Customer Request",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                BootstrapContainer(
                                  fluid: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  children: <Widget>[
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Model :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Vgroup>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.vgroup == '') {
                                                      return "Model tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.vgroup
                                                            .toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Model',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVGroup = value!.iD;
                                                      vGroup = value.vgroup;
                                                      vGroupController.text =
                                                          idVGroup;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vGroup != ''
                                                        ? vGroup.toUpperCase()
                                                        : "Belum memilih model",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVgroup",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVgroup =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<Vgroup>
                                                        allModelVgroup = [];

                                                    for (var element
                                                        in allVgroup) {
                                                      allModelVgroup.add(
                                                        Vgroup(
                                                          iD: element["iD"],
                                                          vgroup:
                                                              element["vgroup"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVgroup;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: vGroupController,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Model',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tahun :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<String>(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Tahun tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: [
                                                    DateFormat('yyyy').format(
                                                        DateTime.utc(
                                                            DateTime.now()
                                                                    .year +
                                                                1)),
                                                    DateFormat('yyyy')
                                                        .format(DateTime.now()),
                                                    DateFormat('yyyy').format(
                                                        DateTime.utc(
                                                            DateTime.now()
                                                                    .year -
                                                                1))
                                                  ],
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Tahun',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tahunVal = value!;

                                                      tahunController.text =
                                                          tahunVal.toString();
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    tahunVal != ''
                                                        ? tahunVal.toString()
                                                        : "Belum memilih Tahun",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  controller: tahunController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tahun',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Tahun',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Bahan Bakar :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    VfuelTransmisi>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Tahun tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.name.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Bahan Bakar',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVfuel = value!.iD;
                                                      vFuel = value.name;
                                                      vFuelController.text =
                                                          idVfuel;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vFuel != ''
                                                        ? vFuel.toUpperCase()
                                                        : "Belum memilih bahan bakar",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVfuel",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVfuelTransmisi =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<VfuelTransmisi>
                                                        allModelVfuelTransmisi =
                                                        [];

                                                    for (var element
                                                        in allVfuelTransmisi) {
                                                      allModelVfuelTransmisi
                                                          .add(
                                                        VfuelTransmisi(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVfuelTransmisi;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  controller: vFuelController,
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Bahan Bakar',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Transmisi :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    VfuelTransmisi>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.name == '') {
                                                      return "Transmisi tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.name.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          17,
                                                          0,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            17,
                                                            0,
                                                          ),
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Transmisi',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVtransmisi = value!.iD;
                                                      vTransmisi = value.name;
                                                      vTransmisiController
                                                          .text = idVtransmisi;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vTransmisi != ''
                                                        ? vTransmisi
                                                            .toUpperCase()
                                                        : "Belum memilih transmisi",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVtransmisi",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVfuelTransmisi =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<VfuelTransmisi>
                                                        allModelVfuelTransmisi =
                                                        [];

                                                    for (var element
                                                        in allVfuelTransmisi) {
                                                      allModelVfuelTransmisi
                                                          .add(
                                                        VfuelTransmisi(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVfuelTransmisi;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      vTransmisiController,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Transmisi',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "ALTERNATIVE",
                                          style: TextStyle(
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
                                                    name: TABLET,
                                                    value: 17.0,
                                                    landscapeValue: 17.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 17.0,
                                                    landscapeValue: 17.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 12.5,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 15,
                                      thickness: 2,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 15, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Model :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<Vgroup>(
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.vgroup
                                                            .toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Model',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVGroup2 = value!.iD;
                                                      vGroup2 = value.vgroup;
                                                      vGroup2Controller.text =
                                                          idVGroup2;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vGroup2 != ''
                                                        ? vGroup2.toUpperCase()
                                                        : "Belum memilih model",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVgroup",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVgroup =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<Vgroup>
                                                        allModelVgroup = [];

                                                    for (var element
                                                        in allVgroup) {
                                                      allModelVgroup.add(
                                                        Vgroup(
                                                          iD: element["iD"],
                                                          vgroup:
                                                              element["vgroup"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVgroup;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: vGroup2Controller,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Model',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tahun :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<String>(
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: [
                                                    DateFormat('yyyy').format(
                                                        DateTime.utc(
                                                            DateTime.now()
                                                                    .year +
                                                                1)),
                                                    DateFormat('yyyy')
                                                        .format(DateTime.now()),
                                                    DateFormat('yyyy').format(
                                                        DateTime.utc(
                                                            DateTime.now()
                                                                    .year -
                                                                1))
                                                  ],
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Tahun',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tahunVal2 = value!;

                                                      tahun2Controller.text =
                                                          tahunVal2;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    tahunVal2 != ''
                                                        ? tahunVal2.toString()
                                                        : "Belum memilih Tahun",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: tahun2Controller,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tahun',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Bahan Bakar :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    VfuelTransmisi>(
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.name.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Bahan Bakar',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVfuel2 = value!.iD;
                                                      vFuel2 = value.name;
                                                      vFuel2Controller.text =
                                                          idVfuel2;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vFuel2 != ''
                                                        ? vFuel2.toUpperCase()
                                                        : "Belum memilih bahan bakar",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVfuel",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVfuelTransmisi2 =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<VfuelTransmisi>
                                                        allModelVfuelTransmisi2 =
                                                        [];

                                                    for (var element
                                                        in allVfuelTransmisi2) {
                                                      allModelVfuelTransmisi2
                                                          .add(
                                                        VfuelTransmisi(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVfuelTransmisi2;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: vFuel2Controller,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Bahan Bakar',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Transmisi :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: DropdownSearch<
                                                    VfuelTransmisi>(
                                                  popupProps: PopupProps.dialog(
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              202,
                                                              109,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, item,
                                                            isSelected) =>
                                                        ListTile(
                                                      title: Text(
                                                        item.name.toUpperCase(),
                                                      ),
                                                    ),
                                                  ),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Transmisi',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      idVtransmisi2 = value!.iD;
                                                      vTransmisi2 = value.name;
                                                      vTransmisi2Controller
                                                          .text = idVtransmisi2;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    vTransmisi2 != ''
                                                        ? vTransmisi2
                                                            .toUpperCase()
                                                        : "Belum memilih transmisi",
                                                    style: textStyleColorWhite,
                                                  ),
                                                  asyncItems:
                                                      (String filter) async {
                                                    var response =
                                                        await http.get(
                                                      Uri.parse(
                                                        "${urlApi()}Wilayah/GetVtransmisi",
                                                      ),
                                                    );
                                                    if (response.statusCode !=
                                                        200) {
                                                      return [];
                                                    }
                                                    List allVfuelTransmisi2 =
                                                        (jsonDecode(response
                                                                    .body)
                                                                as Map<String,
                                                                    dynamic>)[
                                                            "listVgroup"];
                                                    List<VfuelTransmisi>
                                                        allModelVfuelTransmisi2 =
                                                        [];

                                                    for (var element
                                                        in allVfuelTransmisi2) {
                                                      allModelVfuelTransmisi2
                                                          .add(
                                                        VfuelTransmisi(
                                                          iD: element["iD"],
                                                          name: element["name"],
                                                        ),
                                                      );
                                                    }
                                                    return allModelVfuelTransmisi2;
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      vTransmisi2Controller,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Transmisi',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        150,
                        11,
                        18,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "NEGOTIATION & CLOSING",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Skema Pembayaran",
                                      style: TextStyle(
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
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0),
                                            const Condition.largerThan(
                                                name: TABLET,
                                                value: 17.0,
                                                landscapeValue: 17.0,
                                                breakpoint: 800),
                                          ],
                                          defaultValue: 12.5,
                                        ).value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                BootstrapContainer(
                                  fluid: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  children: <Widget>[
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Cash/Leasing :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: Container(
                                                  height: 55,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 0, 25, 0),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      150,
                                                      11,
                                                      18,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: double.infinity,
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              20.0),
                                                                    ),
                                                                  ),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ListView.separated(
                                                                        itemCount: cashLeasingOptions.length,
                                                                        separatorBuilder: (context, int int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder: (context, indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(cashLeasingOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  cashLeasingVal = cashLeasingOptions[indexSelect].value.toUpperCase();
                                                                                  cashLeasingController.text = cashLeasingVal;
                                                                                });
                                                                                Navigator.of(context).pop();
                                                                              });
                                                                        });
                                                                  });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      80,
                                                                      5,
                                                                      80,
                                                                      5),
                                                              child: Text(
                                                                cashLeasingVal !=
                                                                        ''
                                                                    ? cashLeasingVal
                                                                    : "CHOOSE",
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller:
                                                      cashLeasingController,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Cash/Leasing',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Down Payment :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<ModelSelect>(
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: dPOptions,
                                                  itemAsString:
                                                      (ModelSelect dPOpt) =>
                                                          dPOpt.value,
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Down Payment',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged:
                                                      (ModelSelect? value) {
                                                    setState(() {
                                                      //print(value);
                                                      dPVal = value!.value;
                                                      dPController.text = dPVal;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    dPVal != ''
                                                        ? dPVal
                                                        : "Belum memilih Down Payment",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: dPController,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Down Payment',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tenor :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<ModelSelect>(
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: tenorOptions,
                                                  itemAsString:
                                                      (ModelSelect tenorOpt) =>
                                                          tenorOpt.value
                                                              .toUpperCase(),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Down Payment',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged:
                                                      (ModelSelect? value) {
                                                    setState(() {
                                                      //print(value);
                                                      tenorVal = value!.value;
                                                      tenorController.text =
                                                          tenorVal;
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    tenorVal != ''
                                                        ? tenorVal.toUpperCase()
                                                        : "Belum memilih Tenor",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: tenorController,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Tenor',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "SYARAT KELENGKAPAN DOKUMEN",
                                          style: TextStyle(
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
                                                    name: TABLET,
                                                    value: 17.0,
                                                    landscapeValue: 17.0),
                                                const Condition.largerThan(
                                                    name: TABLET,
                                                    value: 17.0,
                                                    landscapeValue: 17.0,
                                                    breakpoint: 800),
                                              ],
                                              defaultValue: 12.5,
                                            ).value,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 15,
                                      thickness: 2,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 15, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tipe Customer :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller:
                                                      custTypeS2Controller,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Tipe Customer tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  autocorrect: false,
                                                  readOnly: true,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                      color: Colors.amber,
                                                    ),
                                                    errorBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                    hintText: 'Tipe Customer',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    labelText: 'Tipe Customer',
                                                    labelStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: valTipeCutS2 == null ||
                                                  valTipeCutS2 == 1
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ1,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ1 =
                                                                    value!;
                                                                if (checkQ1 ==
                                                                    true) {
                                                                  q1Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q1Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'KTP Suami Istri + Kartu Keluarga / Surat Nikah + NPWP Debitur',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q1Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q1',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ2,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ2 =
                                                                    value!;
                                                                if (checkQ2 ==
                                                                    true) {
                                                                  q2Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q2Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'PLN/PBB/AJB/Sertifikat Kepemilikan Rumah An. Debitur',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q2Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q2',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ3,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ3 =
                                                                    value!;
                                                                if (checkQ3 ==
                                                                    true) {
                                                                  q3Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q3Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Fixed Line',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q3Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q3',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ4,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ4 =
                                                                    value!;
                                                                if (checkQ4 ==
                                                                    true) {
                                                                  q4Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q4Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Rekening Koran 3 Bulan Terakhir',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q4Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q4',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ5,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ5 =
                                                                    value!;
                                                                if (checkQ5 ==
                                                                    true) {
                                                                  q5Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q5Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Slip Gaji / Surat Ket Penghasilan (Karyawan)',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q5Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q5',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ6,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ6 =
                                                                    value!;
                                                                if (checkQ6 ==
                                                                    true) {
                                                                  q6Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q6Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Siup, Npwp & Tdp (Pengusaha)',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q6Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q6',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ7,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ7 =
                                                                    value!;
                                                                if (checkQ7 ==
                                                                    true) {
                                                                  q1Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q1Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Ktp Pengurus + Pemegang Saham',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q1Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q7',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ8,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ8 =
                                                                    value!;
                                                                if (checkQ8 ==
                                                                    true) {
                                                                  q2Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q2Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'SIUP, TDP, BPWP',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q2Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q8',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ9,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ9 =
                                                                    value!;
                                                                if (checkQ9 ==
                                                                    true) {
                                                                  q3Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q3Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Surat Pengesahan Menteri Kehakiman',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q3Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q9',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ10,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ10 =
                                                                    value!;
                                                                if (checkQ10 ==
                                                                    true) {
                                                                  q4Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q4Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Surat Keterangan Domisili Perusahaan',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q4Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q10',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ11,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ11 =
                                                                    value!;
                                                                if (checkQ11 ==
                                                                    true) {
                                                                  q5Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q5Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Rekening Koran 3 Bulan Terakhir',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q5Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q11',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                const Color
                                                                    .fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            value: checkQ12,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                checkQ12 =
                                                                    value!;
                                                                if (checkQ12 ==
                                                                    true) {
                                                                  q6Controller
                                                                          .text =
                                                                      '1';
                                                                } else {
                                                                  q6Controller
                                                                          .text =
                                                                      '0';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Akta Pendirian Dan Perubahannya',
                                                              style:
                                                                  textStyleColorWhite,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: false,
                                                      child: TextFormField(
                                                        controller:
                                                            q6Controller,
                                                        autocorrect: false,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Perorangan Q12',
                                                          hintStyle:
                                                              textStyleColorWhite,
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-md-6 col-12',
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Status :",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 20),
                                                child:
                                                    DropdownSearch<ModelSelect>(
                                                  validator: (val) {
                                                    if (val == null ||
                                                        val.value == '') {
                                                      return "Status tidak boleh kosong";
                                                    }
                                                    return null;
                                                  },
                                                  popupProps: PopupProps.dialog(
                                                    // showSelectedItems: true,
                                                    dialogProps:
                                                        const DialogProps(
                                                      shape: Border.symmetric(
                                                          vertical:
                                                              BorderSide.none),
                                                    ),
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search..",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              134,
                                                              134,
                                                              134,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              146,
                                                              2,
                                                              2,
                                                            ),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  items: statusOptions,
                                                  itemAsString:
                                                      (ModelSelect statusOpt) =>
                                                          statusOpt.value
                                                              .toUpperCase(),
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Colors.amber,
                                                      ),
                                                      errorBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.amber,
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          textStyleColorWhite,
                                                      labelText: 'Status',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255,
                                                          ),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged:
                                                      (ModelSelect? value) {
                                                    setState(() {
                                                      //print(value);
                                                      idStatus = value!.id;
                                                      status = value.value;
                                                      statusController.text =
                                                          idStatus.toString();
                                                    });
                                                  },
                                                  dropdownBuilder:
                                                      (context, selectedItem) =>
                                                          Text(
                                                    status != ''
                                                        ? status.toUpperCase()
                                                        : "Belum memilih status",
                                                    style: textStyleColorWhite,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: TextFormField(
                                                  controller: statusController,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: 'Status',
                                                    hintStyle:
                                                        textStyleColorWhite,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    idStatus == 2
                                        ? BootstrapRow(
                                            children: <BootstrapCol>[
                                              BootstrapCol(
                                                  sizes: 'col-md-6 col-12',
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 15),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Alasan Lost Prospect :",
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 20),
                                                        child: DropdownSearch<
                                                            ModelSelect>(
                                                          popupProps:
                                                              PopupProps.dialog(
                                                            // showSelectedItems: true,
                                                            dialogProps:
                                                                const DialogProps(
                                                              shape: Border.symmetric(
                                                                  vertical:
                                                                      BorderSide
                                                                          .none),
                                                            ),
                                                            showSearchBox: true,
                                                            searchFieldProps:
                                                                TextFieldProps(
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Search..",
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                      255,
                                                                      134,
                                                                      134,
                                                                      134,
                                                                    ),
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                      255,
                                                                      146,
                                                                      2,
                                                                      2,
                                                                    ),
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          items:
                                                              alasanLpOptions,
                                                          itemAsString: (ModelSelect
                                                                  alasanLp) =>
                                                              alasanLp.value
                                                                  .toUpperCase(),
                                                          dropdownDecoratorProps:
                                                              DropDownDecoratorProps(
                                                            dropdownSearchDecoration:
                                                                InputDecoration(
                                                              hintStyle:
                                                                  textStyleColorWhite,
                                                              labelText:
                                                                  'Alasan Lost Prospect',
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255,
                                                                  ),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255,
                                                                  ),
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                          ),
                                                          onChanged:
                                                              (ModelSelect?
                                                                  value) {
                                                            setState(() {
                                                              idAlasanLp =
                                                                  value!.id;
                                                              alasanLp =
                                                                  value.value;
                                                              alasanLostProspectController
                                                                      .text =
                                                                  idAlasanLp
                                                                      .toString();
                                                            });
                                                          },
                                                          dropdownBuilder: (context,
                                                                  selectedItem) =>
                                                              Text(
                                                            alasanLp != ''
                                                                ? alasanLp
                                                                    .toUpperCase()
                                                                : "Alasan lost prospect",
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: false,
                                                        child: TextFormField(
                                                          controller:
                                                              alasanLostProspectController,
                                                          autocorrect: false,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Alasan Lost Prospect',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              BootstrapCol(
                                                  sizes: 'col-md-6 col-12',
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 15),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "keterangan :",
                                                            style:
                                                                textStyleColorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 20),
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          autocorrect: false,
                                                          controller:
                                                              keteranganController,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Keterangan',
                                                            hintStyle:
                                                                textStyleColorWhite,
                                                            labelText:
                                                                'Keterangan',
                                                            labelStyle:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255,
                                                                ),
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          )
                                        : BootstrapRow(children: <BootstrapCol>[
                                            BootstrapCol(child: const Text("")),
                                          ]),
                                    BootstrapRow(
                                      children: [
                                        BootstrapCol(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Column(
                                              children: [
                                                OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    fixedSize: Size(
                                                      ResponsiveValue<double>(
                                                              context,
                                                              conditionalValues: [
                                                                const Condition
                                                                    .equals(
                                                                  name: TABLET,
                                                                  value: 200,
                                                                  landscapeValue:
                                                                      200,
                                                                ),
                                                                const Condition
                                                                    .largerThan(
                                                                    name:
                                                                        TABLET,
                                                                    value: 200,
                                                                    landscapeValue:
                                                                        200,
                                                                    breakpoint:
                                                                        800),
                                                              ],
                                                              defaultValue: 130)
                                                          .value,
                                                      ResponsiveValue<double>(
                                                        context,
                                                        conditionalValues: [
                                                          const Condition
                                                              .equals(
                                                              name: TABLET,
                                                              value: 55,
                                                              landscapeValue:
                                                                  55),
                                                          const Condition
                                                              .largerThan(
                                                              name: TABLET,
                                                              value: 55,
                                                              landscapeValue:
                                                                  55,
                                                              breakpoint: 800),
                                                        ],
                                                        defaultValue: 50,
                                                      ).value,
                                                    ),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                      255,
                                                      129,
                                                      127,
                                                      127,
                                                    ),
                                                  ).copyWith(
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith<
                                                                Color?>(
                                                      (Set<MaterialState>
                                                          states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .pressed)) {
                                                          return const Color
                                                              .fromARGB(
                                                            255,
                                                            1,
                                                            209,
                                                            29,
                                                          );
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (formkey.currentState!
                                                        .validate()) {
                                                      var prospect =
                                                          ListProspectData(
                                                        dateContact:
                                                            tglContactController
                                                                .text,
                                                        meetingPoint:
                                                            lokasiBertemuController
                                                                .text,
                                                        postalCodeID:
                                                            idKodePosController
                                                                .text,
                                                        ringArea:
                                                            idAreaController
                                                                .text,
                                                        referensiID:
                                                            sumberDataController
                                                                .text,
                                                        rencanaPembelian:
                                                            int.tryParse(
                                                                rencanaPembelianController
                                                                    .text),
                                                        branchBusinessID:
                                                            branchBusinessIDController
                                                                .text,
                                                        salesmanHeaderID:
                                                            salesmanIDController
                                                                .text,
                                                        prospectStatus:
                                                            int.tryParse(
                                                                prospectStatusController
                                                                    .text),
                                                        customerName:
                                                            nameContactContactController
                                                                .text,
                                                        handphone1:
                                                            noHP1ContactController
                                                                .text,
                                                        handphone2:
                                                            noHP2ContactController
                                                                .text,
                                                        gender: int.tryParse(
                                                            jKController.text),
                                                        customerAddres:
                                                            alamatController
                                                                .text,
                                                        postaclCodeACEID:
                                                            idKodePosS2Controller
                                                                .text,
                                                        ringAreaACE: int.tryParse(
                                                            idAreaS2Controller
                                                                .text),
                                                        email: emailController
                                                            .text,
                                                        customerTypeID:
                                                            idCustTypeS2Controller
                                                                .text,
                                                        pekerjaan:
                                                            jabatanController
                                                                .text,
                                                        kisaranHargaID:
                                                            hKendaraanController
                                                                .text,
                                                        customerStatusID:
                                                            tipePelangganController
                                                                .text,
                                                        vehicleGroupID1:
                                                            vGroupController
                                                                .text,
                                                        vehicleYear1:
                                                            tahunController
                                                                .text,
                                                        vehicleFuelID1:
                                                            vFuelController
                                                                .text,
                                                        transmisiVehicle1:
                                                            vTransmisiController
                                                                .text,
                                                        vehicleGroupID2:
                                                            vGroup2Controller
                                                                .text,
                                                        vehicleYear2:
                                                            tahun2Controller
                                                                .text,
                                                        vehicleFuelID2:
                                                            vFuel2Controller
                                                                .text,
                                                        transmisiVehicle2:
                                                            vTransmisi2Controller
                                                                .text,
                                                        payment:
                                                            cashLeasingController
                                                                .text,
                                                        downPayment:
                                                            dPController.text,
                                                        tenor: tenorController
                                                            .text,
                                                        q1: int.tryParse(
                                                            q1Controller.text),
                                                        q2: int.tryParse(
                                                            q2Controller.text),
                                                        q3: int.tryParse(
                                                            q3Controller.text),
                                                        q4: int.tryParse(
                                                            q4Controller.text),
                                                        q5: int.tryParse(
                                                            q5Controller.text),
                                                        q6: int.tryParse(
                                                            q6Controller.text),
                                                        trackingStatus:
                                                            int.tryParse(
                                                                statusController
                                                                    .text),
                                                        trackingReason:
                                                            int.tryParse(
                                                                alasanLostProspectController
                                                                    .text),
                                                        trackingInfo:
                                                            keteranganController
                                                                .text,
                                                      );

                                                      try {
                                                        var resp = await ref
                                                            .read(
                                                                prospectFormProvider)
                                                            .onSubmitProspect(
                                                                prospect);

                                                        if (resp.statusMessage ==
                                                            "Sucess") {
                                                          // lokasiBertemuController
                                                          //     .clear();
                                                          tipePelangganController
                                                              .clear();
                                                          formkey.currentState!
                                                              .reset();
                                                        }

                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const HomePage()),
                                                                (route) =>
                                                                    false);

                                                        successSubmit(
                                                            context, resp);
                                                      } catch (e) {
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const HomePage()),
                                                                (route) =>
                                                                    false);

                                                        catchError(context, e);
                                                      }
                                                    }
                                                  },
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Simpan",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              textStyleColorWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Watermark(),
            ],
          ),
        ),
      ),
    );
  }
}
