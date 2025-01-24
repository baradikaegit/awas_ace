// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/provider/prospect_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/api_error.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/widgets/main_page.dart';
import 'package:awas_ace/widgets/model/custtypemodel.dart';
import 'package:awas_ace/widgets/model/kisaranhargamodel.dart';
import 'package:awas_ace/widgets/model/prospectupdatemodel.dart';
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

class ProspectEditPage extends ConsumerStatefulWidget {
  final Object? linkPageObj;
  const ProspectEditPage({super.key, required this.linkPageObj});

  static const String routeName = "/prospectEditPage";

  @override
  _ProspectEditPageState createState() => _ProspectEditPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ProspectEditPageState extends ConsumerState<ProspectEditPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // final formkey = GlobalKey<FormState>();

  //STEP 1
  final TextEditingController prospectHIdController = TextEditingController();
  TextEditingController tglContactController = TextEditingController();
  final TextEditingController branchBusinessIDController =
      TextEditingController();
  final TextEditingController salesmanIDController = TextEditingController();
  final TextEditingController prospectCodeController = TextEditingController();
  TextEditingController lokasiBertemuController = TextEditingController();
  TextEditingController idKodePosController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController idAreaController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController sumberDataController = TextEditingController();
  TextEditingController rencanaPembelianController = TextEditingController();
  TextEditingController prospectStatusController = TextEditingController();

  //STEP 2
  TextEditingController nameContactContactController = TextEditingController();
  TextEditingController noHP1ContactController = TextEditingController();
  TextEditingController noHP2ContactController = TextEditingController();
  TextEditingController jKController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  final TextEditingController idKodePosS2Controller = TextEditingController();
  final TextEditingController kodePosS2Controller = TextEditingController();
  final TextEditingController idAreaS2Controller = TextEditingController();
  final TextEditingController areaS2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idCustTypeS2Controller = TextEditingController();
  TextEditingController custTypeS2Controller = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController hKendaraanController = TextEditingController();
  TextEditingController tipePelangganController = TextEditingController();

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
  String dateContact = '';
  String tglKontak = '';
  String nameProv = '';
  String nameProvEdit = '';
  String nameKab = '';
  String nameKabEdit = '';
  String nameKec = '';
  String nameKecEdit = '';
  String nameKel = '';
  String nameKelEdit = '';
  String idKodePos = '';
  String idKodePosEdit = '';
  String kodePos = '';
  String kodePosEdit = '';
  String idArea = '';
  String idAreaEdit = '';
  String area = '';
  String areaEdit = '';
  String iDSumberData = '';
  String iDSumberDataEdit = '';
  String sumberData = '';
  String sumberDataEdit = '';
  int? iDRencanaPembelian;
  int? iDRencanaPembelianEdit;
  String rencanaPembelian = '';
  String rencanaPembelianEdit = '';

  //STEP 2
  String jkValue = '';
  String jkValueEdit = '';
  int jkId = 0;
  int jkIdEdit = 0;
  String nameProvS2 = '';
  String nameProvS2Edit = '';
  String nameKabS2 = '';
  String nameKabS2Edit = '';
  String nameKecS2 = '';
  String nameKecS2Edit = '';
  String nameKelS2 = '';
  String nameKelS2Edit = '';
  String idKodePosS2 = '';
  String idKodePosS2Edit = '';
  String kodePosS2 = '';
  String kodePosS2Edit = '';
  String idAreaS2 = '';
  String idAreaS2Edit = '';
  String areaS2 = '';
  String areaS2Edit = '';
  String idTipeCustS2 = '';
  String idTipeCustS2Edit = '';
  String tipeCustS2 = '';
  String tipeCustS2Edit = '';
  int? valTipeCutS2;
  int? valTipeCustS2Edit;
  String jabatanVal = '';
  String jabatanValEdit = '';
  String hargaKendaraan = '';
  String hargaKendaraanEdit = '';
  String idHargaKendaraan = '';
  String idHargaKendaraanEdit = '';
  String idTipePelanggan = '';
  String idTipePelangganEdit = '';
  String tipePelanggan = '';
  String tipePelangganEdit = '';

  //STEP 3
  String idVGroup = '';
  String vGroup = '';
  String vGroupEdit = '';
  String tahunVal = '';
  String tahunValEdit = '';
  String idVfuel = '';
  String vFuel = '';
  String vFuelEdit = '';
  String idVtransmisi = '';
  String vTransmisi = '';
  String vTransmisiEdit = '';
  String idVGroup2 = '';
  String vGroup2 = '';
  String vGroup2Edit = '';
  String tahunVal2 = '';
  String tahunVal2Edit = '';
  String idVfuel2 = '';
  String vFuel2 = '';
  String vFuel2Edit = '';
  String idVtransmisi2 = '';
  String vTransmisi2 = '';
  String vTransmisi2Edit = '';

  //STEP 4
  String cashLeasingVal = '';
  String cashLeasingValEdit = '';
  String dPVal = '';
  String dPValEdit = '';
  String tenorVal = '';
  String tenorValEdit = '';
  bool checkQ1 = false;
  bool checkQ1Edit = true;
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
  int? idStatusEdit;
  String status = '';
  String statusEdit = '';
  int? idAlasanLp;
  int? idAlasanLpEdit;
  String alasanLp = '';
  String alasanLpEdit = '';

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

  @override
  void initState() {
    super.initState();
    // tglContactController.text = dateNow;

    q1Controller.text = '0';
    q2Controller.text = '0';
    q3Controller.text = '0';
    q4Controller.text = '0';
    q5Controller.text = '0';
    q6Controller.text = '0';
    alasanLostProspectController.text = '0';
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    loadSharedPreference();
  }

  void _handleTabSelection() {
    setState(() {});
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

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        dividerHeight: 0,
        indicatorColor: _tabController.index == 0
            ? const Color.fromARGB(
                255,
                134,
                134,
                134,
              )
            : _tabController.index == 1
                ? const Color.fromARGB(
                    255,
                    1,
                    53,
                    131,
                  )
                : _tabController.index == 2
                    ? const Color.fromARGB(
                        255,
                        202,
                        109,
                        2,
                      )
                    : const Color.fromARGB(
                        255,
                        146,
                        2,
                        2,
                      ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
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
                color: _tabController.index == 0
                    ? const Color.fromARGB(
                        255,
                        134,
                        134,
                        134,
                      )
                    : const Color.fromARGB(
                        255,
                        3,
                        116,
                        18,
                      ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "STEP 1 ",
                    style: TextStyle(
                      color: _tabController.index == 0
                          ? Colors.white
                          : Colors.amber,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
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
                          color: _tabController.index == 0
                              ? Colors.white
                              : Colors.amber,
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
                color: _tabController.index == 1
                    ? const Color.fromARGB(
                        255,
                        1,
                        53,
                        131,
                      )
                    : const Color.fromARGB(
                        255,
                        3,
                        116,
                        18,
                      ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "STEP 2 ",
                    style: TextStyle(
                      color: _tabController.index == 1
                          ? Colors.white
                          : Colors.amber,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
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
                          color: _tabController.index == 1
                              ? Colors.white
                              : Colors.amber,
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
                color: _tabController.index == 2
                    ? const Color.fromARGB(
                        255,
                        202,
                        109,
                        2,
                      )
                    : const Color.fromARGB(
                        255,
                        3,
                        116,
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
                      color: _tabController.index == 2
                          ? Colors.white
                          : Colors.amber,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
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
                          color: _tabController.index == 2
                              ? Colors.white
                              : Colors.amber,
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
                color: _tabController.index == 3
                    ? const Color.fromARGB(
                        255,
                        146,
                        2,
                        2,
                      )
                    : const Color.fromARGB(
                        255,
                        3,
                        116,
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
                      color: _tabController.index == 2
                          ? Colors.white
                          : Colors.amber,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.equals(
                              name: TABLET, value: 16.0, landscapeValue: 16.0),
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
                          color: _tabController.index == 2
                              ? Colors.white
                              : Colors.amber,
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
      );

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
              "Edit Prospect Sales",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
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
                  child: _tabBar,
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
              Consumer(
                builder: (context, ref, child) {
                  var linkPageObj = widget.linkPageObj.toString();

                  final prospectSlsEdit =
                      ref.watch(prospectSalesdetail(linkPageObj));

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  return ref.refresh(
                                    prospectSalesdetail(linkPageObj),
                                  );
                                },
                                child: prospectSlsEdit.when(
                                  data: (data) {
                                    for (int i = 0;
                                        i <
                                            data.listProspectSalesDetail!
                                                .length;
                                        i++) {
                                      // tglContactController.text = data
                                      //     .listProspectSalesDetail![i]
                                      //     .dateContact;

                                      dateContact = DateFormat('MM/dd/yyyy')
                                          .format(DateTime.now());

                                      tglContactController.text = dateContact;

                                      lokasiBertemuController.text = data
                                          .listProspectSalesDetail![i]
                                          .meetingPoint;

                                      prospectHIdController.text =
                                          data.listProspectSalesDetail![i].iD;

                                      prospectCodeController.text = data
                                          .listProspectSalesDetail![i]
                                          .prospectCode;

                                      nameProvEdit = data
                                          .listProspectSalesDetail![i].provinsi;

                                      if (nameProv == '') {
                                        nameKabEdit = data
                                            .listProspectSalesDetail![i].kota;
                                        nameKecEdit = data
                                            .listProspectSalesDetail![i]
                                            .kecamatan;
                                        nameKelEdit = data
                                            .listProspectSalesDetail![i]
                                            .kelurahan;
                                        kodePosEdit = data
                                            .listProspectSalesDetail![i]
                                            .postalCode;
                                        idKodePosEdit = data
                                            .listProspectSalesDetail![i]
                                            .postalCodeId;
                                        idAreaEdit = data
                                            .listProspectSalesDetail![i].area
                                            .toString();
                                        areaEdit = data
                                            .listProspectSalesDetail![i]
                                            .ringKet;

                                        kodePosController.text = kodePosEdit;
                                        idKodePosController.text =
                                            idKodePosEdit;
                                        idAreaController.text = idAreaEdit;
                                        areaController.text = areaEdit;
                                      } else {
                                        nameKabEdit = "Belum memilih kota";
                                        nameKecEdit = "Belum memilih kecamatan";
                                        nameKelEdit = "Belum memilih kelurahan";
                                        kodePosEdit = "Belum memilih Kode Pos";
                                      }

                                      if (sumberData == '') {
                                        sumberDataEdit = data
                                            .listProspectSalesDetail![i]
                                            .referensi;
                                        iDSumberDataEdit = data
                                            .listProspectSalesDetail![i]
                                            .referensiId;

                                        sumberDataController.text =
                                            iDSumberDataEdit;
                                      }

                                      if (rencanaPembelian == '') {
                                        iDRencanaPembelianEdit = data
                                            .listProspectSalesDetail![i]
                                            .rencanaPembelian;

                                        rencanaPembelianController.text =
                                            iDRencanaPembelianEdit.toString();

                                        prospectStatusController.text = data
                                            .listProspectSalesDetail![i]
                                            .prospectStatus
                                            .toString();

                                        if (iDRencanaPembelianEdit == 1) {
                                          rencanaPembelianEdit =
                                              '1 Minggu Kedepan';
                                        } else if (iDRencanaPembelianEdit ==
                                            2) {
                                          rencanaPembelianEdit =
                                              '2 Minggu Kedepan';
                                        } else if (iDRencanaPembelianEdit ==
                                            3) {
                                          rencanaPembelianEdit =
                                              '3 Minggu Kedepan';
                                        } else if (iDRencanaPembelianEdit ==
                                            4) {
                                          rencanaPembelianEdit =
                                              '1 Bulan Kedepan';
                                        } else {
                                          rencanaPembelianEdit =
                                              'Lebih Dari 1 Bulan Kedepan';
                                        }
                                      }

                                      nameContactContactController.text = data
                                          .listProspectSalesDetail![i]
                                          .customerName;

                                      noHP1ContactController.text = data
                                          .listProspectSalesDetail![i]
                                          .handphone1;
                                      noHP2ContactController.text = data
                                          .listProspectSalesDetail![i]
                                          .handphone2;

                                      if (jkValue == '') {
                                        jkIdEdit = data
                                            .listProspectSalesDetail![i].gender;

                                        if (jkIdEdit == 1) {
                                          jkValueEdit = 'Laki-Laki';
                                        } else {
                                          jkValueEdit = 'Perempuan';
                                        }
                                        jKController.text = jkIdEdit.toString();
                                      }

                                      alamatController.text = data
                                          .listProspectSalesDetail![i]
                                          .customerAddres;

                                      nameProvS2Edit = data
                                          .listProspectSalesDetail![i]
                                          .provinsi2;

                                      if (nameProvS2 == '') {
                                        nameKabS2Edit = data
                                            .listProspectSalesDetail![i].kota2;
                                        nameKecS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .kecamatan2;
                                        nameKelS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .kelurahan2;
                                        kodePosS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .postalCode2;
                                        idKodePosS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .postalCodeId2;
                                        idAreaS2Edit = data
                                            .listProspectSalesDetail![i].area
                                            .toString();
                                        areaS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .ringKet2;

                                        kodePosS2Controller.text =
                                            kodePosS2Edit;
                                        idKodePosS2Controller.text =
                                            idKodePosEdit;
                                        idAreaS2Controller.text = idAreaS2Edit;
                                        areaS2Controller.text = areaS2Edit;
                                      } else {
                                        nameKabS2Edit = "Belum memilih kota";
                                        nameKecS2Edit =
                                            "Belum memilih kecamatan";
                                        nameKelS2Edit =
                                            "Belum memilih kelurahan";
                                        kodePosS2Edit =
                                            "Belum memilih Kode Pos";
                                      }

                                      emailController.text = data
                                          .listProspectSalesDetail![i].email;

                                      if (tipeCustS2 == '') {
                                        tipeCustS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .customerType;

                                        custTypeS2Controller.text =
                                            tipeCustS2Edit;

                                        idTipeCustS2Edit = data
                                            .listProspectSalesDetail![i]
                                            .custTypeId;
                                        idCustTypeS2Controller.text =
                                            idTipeCustS2Edit;

                                        valTipeCutS2 = data
                                            .listProspectSalesDetail![i]
                                            .customerVal;
                                      } else {
                                        tipeCustS2Edit =
                                            "Belum memilih tipe customer";
                                      }

                                      if (jabatanVal == '') {
                                        jabatanValEdit = data
                                            .listProspectSalesDetail![i]
                                            .pekerjaan;

                                        jabatanController.text = jabatanValEdit;
                                      } else {
                                        jabatanValEdit =
                                            "Belum memilih jabatan";
                                      }

                                      if (hargaKendaraan == '') {
                                        hargaKendaraanEdit = data
                                            .listProspectSalesDetail![i]
                                            .kisaranHarga;

                                        hKendaraanController.text = data
                                            .listProspectSalesDetail![i]
                                            .kisaranHargaId;
                                      } else {
                                        tipePelangganEdit =
                                            "Belum memilih kisaran harga kendaraan";
                                      }

                                      if (tipePelanggan == '') {
                                        tipePelangganEdit = data
                                            .listProspectSalesDetail![i]
                                            .customerStatus;

                                        tipePelangganController.text = data
                                            .listProspectSalesDetail![i]
                                            .custStatusId;
                                      } else {
                                        tipePelangganEdit =
                                            "Belum memilih tipe pelanggan";
                                      }

                                      //CUSTOMER REQUEST
                                      if (vGroup == '') {
                                        vGroupEdit = data
                                            .listProspectSalesDetail![i]
                                            .vgroup1;

                                        vGroupController.text = data
                                            .listProspectSalesDetail![i]
                                            .vgroup1Id;
                                      } else {
                                        vGroupEdit = "Belum memilih model";
                                      }

                                      if (tahunVal == '') {
                                        tahunValEdit = data
                                            .listProspectSalesDetail![i]
                                            .vehicleYear1;
                                        tahunController.text = tahunValEdit;
                                      } else {
                                        tahunValEdit = "Belum memilih tahun";
                                      }

                                      if (vFuel == '') {
                                        vFuelEdit = data
                                            .listProspectSalesDetail![i]
                                            .vehicleFuel1;

                                        vFuelController.text = data
                                            .listProspectSalesDetail![i]
                                            .vehicleFuel1Id;
                                      } else {
                                        vFuelEdit = "Belum memilih bahan bakar";
                                      }

                                      if (vTransmisi == '') {
                                        vTransmisiEdit = data
                                            .listProspectSalesDetail![i]
                                            .transmisiV1;

                                        vTransmisiController.text = data
                                            .listProspectSalesDetail![i]
                                            .transmisiV1Id;
                                      } else {
                                        vTransmisiEdit =
                                            "Belum memilih transmisi";
                                      }
                                      //CUSTOMER REQUEST

                                      //ALTERNATIVE
                                      if (vGroup2 == '') {
                                        if (data.listProspectSalesDetail![i]
                                                .vgroup2 ==
                                            '') {
                                          vGroup2Edit = "Belum memilih model";
                                        } else {
                                          vGroup2Edit = data
                                              .listProspectSalesDetail![i]
                                              .vgroup2;

                                          vGroup2Controller.text = data
                                              .listProspectSalesDetail![i]
                                              .vgroup2Id;
                                        }
                                      } else {
                                        vGroup2Edit = "Belum memilih model";
                                      }

                                      if (tahunVal2 == '') {
                                        if (data.listProspectSalesDetail![i]
                                                .vehicleYear2 ==
                                            '') {
                                          tahunVal2Edit = "Belum memilih tahun";
                                        } else {
                                          tahunVal2Edit = data
                                              .listProspectSalesDetail![i]
                                              .vehicleYear2;
                                          tahun2Controller.text = tahunVal2Edit;
                                        }
                                      } else {
                                        tahunVal2Edit = "Belum memilih tahun";
                                      }

                                      if (vFuel2 == '') {
                                        if (data.listProspectSalesDetail![i]
                                                .vehicleFuel2 ==
                                            '') {
                                          vFuel2Edit =
                                              "Belum memilih bahan bakar";
                                        } else {
                                          vFuel2Edit = data
                                              .listProspectSalesDetail![i]
                                              .vehicleFuel2;

                                          vFuel2Controller.text = data
                                              .listProspectSalesDetail![i]
                                              .vehicleFuel2Id;
                                        }
                                      } else {
                                        vFuel2Edit =
                                            "Belum memilih bahan bakar";
                                      }

                                      if (vTransmisi2 == '') {
                                        if (data.listProspectSalesDetail![i]
                                                .transmisiV2 ==
                                            '') {
                                          vTransmisi2Edit =
                                              "Belum memilih transmisi";
                                        } else {
                                          vTransmisi2Edit = data
                                              .listProspectSalesDetail![i]
                                              .transmisiV2;

                                          vTransmisi2Controller.text = data
                                              .listProspectSalesDetail![i]
                                              .transmisiV2Id;
                                        }
                                      } else {
                                        vTransmisi2Edit =
                                            "Belum memilih transmisi";
                                      }
                                      //ALTERNATIVE

                                      if (cashLeasingVal == '') {
                                        cashLeasingValEdit = data
                                            .listProspectSalesDetail![i]
                                            .payment;

                                        cashLeasingController.text =
                                            cashLeasingValEdit;
                                      } else {
                                        cashLeasingValEdit = "Choose";
                                      }

                                      if (dPVal == '') {
                                        dPValEdit = data
                                            .listProspectSalesDetail![i]
                                            .downPayment;

                                        dPController.text = dPValEdit;
                                      } else {
                                        dPValEdit =
                                            "Belum memilih Down Payment";
                                      }

                                      if (tenorVal == '') {
                                        tenorValEdit = data
                                            .listProspectSalesDetail![i].tenor;

                                        tenorController.text = tenorValEdit;
                                      } else {
                                        tenorValEdit = "Belum memilih tenor";
                                      }

                                      if (status == '') {
                                        idStatusEdit = data
                                            .listProspectSalesDetail![i]
                                            .trackingStatus;

                                        idStatusEdit == 1
                                            ? statusEdit = 'Prospect'
                                            : statusEdit = 'Lost Prospect';

                                        statusController.text =
                                            idStatusEdit.toString();
                                      }

                                      if (alasanLp == '') {
                                        data.listProspectSalesDetail![i]
                                                    .trackingReason ==
                                                0
                                            ? alasanLpEdit =
                                                'Alasan lost prospect'
                                            : idAlasanLpEdit = data
                                                .listProspectSalesDetail![i]
                                                .trackingReason;

                                        idAlasanLpEdit == 1
                                            ? alasanLpEdit = 'Discount'
                                            : idAlasanLpEdit == 2
                                                ? alasanLpEdit =
                                                    'Stock Tidak Tersedia'
                                                : idAlasanLpEdit == 3
                                                    ? alasanLpEdit =
                                                        'Beli Brand Lain'
                                                    : idAlasanLpEdit == 4
                                                        ? alasanLpEdit =
                                                            'Leasing'
                                                        : idAlasanLpEdit == 5
                                                            ? alasanLpEdit =
                                                                'Force Major'
                                                            : alasanLpEdit =
                                                                'Alasann lost prospect';

                                        idAlasanLpEdit == null
                                            ? alasanLostProspectController
                                                .text = '0'
                                            : alasanLostProspectController
                                                    .text =
                                                idAlasanLpEdit.toString();
                                        keteranganController.text = data
                                            .listProspectSalesDetail![i]
                                            .trackingInfo;
                                      } else {
                                        alasanLpEdit = 'Alasan lost prospect';
                                      }

                                      // if (checkQ1 == false) {
                                      // if (data.listProspectSalesDetail![i].q1 ==
                                      //     '1') {
                                      //   checkQ1 = true;
                                      // } else if (data
                                      //         .listProspectSalesDetail![i].q1 ==
                                      //     '0') {
                                      //   checkQ1 = false;
                                      // }
                                      // } else {
                                      //   checkQ1 = false;
                                      // }
                                    }

                                    return TabBarView(
                                      controller: _tabController,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              134,
                                              134,
                                              134,
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "PROSPECTING",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      BootstrapContainer(
                                                        fluid: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 30, 0, 0),
                                                        children: <Widget>[
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tanggal Contact :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            tglContactController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tanggal Contact',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Tanggal Contact',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          DateTime?
                                                                              pickedDate =
                                                                              await showDatePicker(
                                                                            context:
                                                                                context,
                                                                            initialDate:
                                                                                DateTime.now(),
                                                                            firstDate:
                                                                                DateTime(2000),
                                                                            lastDate:
                                                                                DateTime(2050),
                                                                          );
                                                                          if (pickedDate !=
                                                                              null) {
                                                                            String
                                                                                formatDate =
                                                                                DateFormat('MM/dd/yyyy').format(pickedDate);

                                                                            setState(() {
                                                                              tglContactController.text = formatDate;
                                                                            });
                                                                          } else {
                                                                            //print("Tanggal tidak dipilih");

                                                                            tglContactController.text =
                                                                                dateContact;

                                                                            print(dateContact);
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            branchBusinessIDController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'BranchBusinessID',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            salesmanIDController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'SalesmanID',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            prospectHIdController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'ID',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            prospectCodeController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Prospect Code',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Lokasi Bertemu :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        controller:
                                                                            lokasiBertemuController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Lokasi bertemu tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Lokasi Bertemu',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Lokasi Bertemu',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Provinsi :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (nameProvEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.text == '') {
                                                                              return "Provinsi tidak boleh kosong";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Provinsi',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameProv =
                                                                                value!.text;
                                                                            nameKab =
                                                                                '';
                                                                            nameKabEdit =
                                                                                '';
                                                                            nameKec =
                                                                                '';
                                                                            nameKel =
                                                                                '';
                                                                            kodePosController.clear();
                                                                            idKodePosController.clear();
                                                                            idAreaController.clear();
                                                                            areaController.clear();
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameProv != ''
                                                                              ? nameProv.toUpperCase()
                                                                              : nameProvEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kota :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (nameKabEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.text == '') {
                                                                              return "Kota tidak boleh kosong";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kota',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKab =
                                                                                value!.text;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameKab != ''
                                                                              ? nameKab.toUpperCase()
                                                                              : nameKabEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kecamatan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (nameKecEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.text == '') {
                                                                              return "Kecamatan tidak boleh kosong";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kecamatan',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKec =
                                                                                value!.text;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameKec != ''
                                                                              ? nameKec.toUpperCase()
                                                                              : nameKecEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kelurahan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (nameKelEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.text == '') {
                                                                              return "Kelurahan tidak boleh kosong";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kelurahan',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKel =
                                                                                value!.text;
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
                                                                              : nameKelEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kode Pos :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        readOnly:
                                                                            true,
                                                                        controller:
                                                                            kodePosController,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Kode Pos tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Kode Pos',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Kode Pos',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            idKodePosController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Kode Pos',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Area :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        readOnly:
                                                                            true,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        controller:
                                                                            areaController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Area tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Area',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Area',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            idAreaController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Area',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Sumber Data :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          SumberData>(
                                                                        validator:
                                                                            (val) {
                                                                          if (sumberDataEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.name == '') {
                                                                              return "Sumber data tidak boleh kosong.";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(
                                                                              vertical: BorderSide.none,
                                                                            ),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Sumber Data',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            iDSumberData =
                                                                                value!.iD;
                                                                            sumberData =
                                                                                value.name;
                                                                            sumberDataController.text =
                                                                                iDSumberData;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          sumberData != ''
                                                                              ? sumberData.toUpperCase()
                                                                              : sumberDataEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allSumberData = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listSumberData"];
                                                                          List<SumberData>
                                                                              allModelSumberData =
                                                                              [];

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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            sumberDataController,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Sumber Data',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Rencana Pembelian :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          ModelSelect>(
                                                                        validator:
                                                                            (val) {
                                                                          if (rencanaPembelianEdit ==
                                                                              '') {
                                                                            if (val == null ||
                                                                                val.value == '') {
                                                                              return "Rencana pembelian tidak boleh kosong.";
                                                                            }
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items:
                                                                            rencanaPembelianOptions,
                                                                        itemAsString: (ModelSelect rencanaPembelianOptions) => rencanaPembelianOptions
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (ModelSelect?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            iDRencanaPembelian =
                                                                                value!.id;
                                                                            rencanaPembelian =
                                                                                value.value;
                                                                            rencanaPembelianController.text =
                                                                                iDRencanaPembelian.toString();

                                                                            if (iDRencanaPembelian == 4 ||
                                                                                iDRencanaPembelian == 5) {
                                                                              prospectStatusController.text = '1';
                                                                            } else if (iDRencanaPembelian == 3) {
                                                                              prospectStatusController.text = '2';
                                                                            } else {
                                                                              prospectStatusController.text = '3';
                                                                            }
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          rencanaPembelian != ''
                                                                              ? rencanaPembelian.toUpperCase()
                                                                              : rencanaPembelianEdit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            rencanaPembelianController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Rencana Pembelian',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            prospectStatusController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Prospect Status',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                              1,
                                              53,
                                              131,
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "GREETING & QUALIFYING",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0,
                                                                left: 20.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Profile",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 15,
                                                        thickness: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      BootstrapContainer(
                                                        fluid: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 30, 0, 0),
                                                        children: <Widget>[
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Nama Contact :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            nameContactContactController,
                                                                        autocorrect:
                                                                            false,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Nama contact tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Nama Contact',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Nama Contact',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "No HP1 :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            noHP1ContactController,
                                                                        autocorrect:
                                                                            false,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "No HP1 tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'No HP1',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'No HP1',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "No HP2 :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            noHP2ContactController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "No HP2 tidak boleh kosong.";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'No HP2',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'No HP2',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Jenis Kelamin :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            55,
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            20,
                                                                            0,
                                                                            25,
                                                                            0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            1,
                                                                            53,
                                                                            131,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(10),
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                const Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255,
                                                                            ),
                                                                            width:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            ConstrainedBox(
                                                                          constraints:
                                                                              const BoxConstraints(
                                                                            minWidth:
                                                                                double.infinity,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showModalBottomSheet(
                                                                                        shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.vertical(
                                                                                            top: Radius.circular(20.0),
                                                                                          ),
                                                                                        ),
                                                                                        context: context,
                                                                                        builder: (context) {
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
                                                                                    padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                                                                                    child: Text(
                                                                                      jkValue != '' ? jkValue : jkValueEdit,
                                                                                      style: textStyleColorWhite,
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            jKController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Jenis Kelamin',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Alamat :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            alamatController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Alamat tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Alamat',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Alamat',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Provinsi :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.text == '') {
                                                                            return "Provinsi tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Provinsi',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameProvS2 =
                                                                                value!.text;
                                                                            nameKabS2 =
                                                                                '';
                                                                            nameKecS2 =
                                                                                '';
                                                                            nameKelS2 =
                                                                                '';
                                                                            idKodePosS2Controller.clear();
                                                                            kodePosS2Controller.clear();

                                                                            // print(
                                                                            //     "idProvinsi : $nameProvS2");
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameProvS2 != ''
                                                                              ? nameProvS2.toUpperCase()
                                                                              : nameProvS2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kota :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.text == '') {
                                                                            return "Kota tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kota',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKabS2 =
                                                                                value!.text;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameKabS2 != ''
                                                                              ? nameKabS2.toUpperCase()
                                                                              : nameKabS2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "kecamatan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.text == '') {
                                                                            return "Kecamatan tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kecamatan',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKecS2 =
                                                                                value!.text;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          nameKecS2 != ''
                                                                              ? nameKecS2.toUpperCase()
                                                                              : nameKecS2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kelurahan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Wilayah>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.text == '') {
                                                                            return "Kelurahan tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.text.toUpperCase()),
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
                                                                                'Kelurahan',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            nameKelS2 =
                                                                                value!.text;
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
                                                                              ? nameKelS2.toUpperCase()
                                                                              : nameKelS2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allWilayah = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listWilayah"];
                                                                          List<Wilayah>
                                                                              allModelWilayah =
                                                                              [];

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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kode Pos :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        readOnly:
                                                                            true,
                                                                        controller:
                                                                            kodePosS2Controller,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Kode pos tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Kode Pos',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Kode Pos',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            idKodePosS2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Kode Pos',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Area :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        readOnly:
                                                                            true,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            areaS2Controller,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Area tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Area',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Area',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            idAreaS2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Area',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "E-mail :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            emailController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty ||
                                                                              !value.toString().contains('@')) {
                                                                            return "E-mail tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'E-mail',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'E-mail',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tipe Customer :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          CustType>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.name == '') {
                                                                            return "Tipe Customer tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.name.toUpperCase()),
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idTipeCustS2 =
                                                                                value!.iD.toString();
                                                                            tipeCustS2 =
                                                                                value.name;
                                                                            valTipeCutS2 =
                                                                                value.val;

                                                                            idCustTypeS2Controller.text =
                                                                                idTipeCustS2;
                                                                            custTypeS2Controller.text =
                                                                                tipeCustS2;

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
                                                                            print("ValTipe : $valTipeCutS2");
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          tipeCustS2 != ''
                                                                              ? tipeCustS2.toUpperCase()
                                                                              : tipeCustS2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allCustType = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listCustType"];
                                                                          List<CustType>
                                                                              allModelCustType =
                                                                              [];

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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            idCustTypeS2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tipe Customer',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Jabatan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          ModelSelect>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.value == '') {
                                                                            return "Jabatan tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            const PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search...",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color.fromARGB(
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
                                                                        items:
                                                                            jabatanOptions,
                                                                        itemAsString: (ModelSelect jabatanOpt) => jabatanOpt
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
                                                                                'Jabatan',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (ModelSelect?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            //print(value);
                                                                            jabatanVal =
                                                                                value!.value;
                                                                            jabatanController.text =
                                                                                jabatanVal;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          jabatanVal != ''
                                                                              ? jabatanVal.toUpperCase()
                                                                              : jabatanValEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            jabatanController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Jabatan',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Kisaran Harga Kendaraan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          KisaranHarga>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.name == '') {
                                                                            return "Kisaran harga kendaraan tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.name),
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idHargaKendaraan =
                                                                                value!.iD.toString();
                                                                            hargaKendaraan =
                                                                                value.name;

                                                                            hKendaraanController.text =
                                                                                idHargaKendaraan;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          hargaKendaraan != ''
                                                                              ? hargaKendaraan
                                                                              : hargaKendaraanEdit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allKisaranHarga = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listKisaranHarga"];
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            hKendaraanController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Kisaran Harga Kendaraan',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tipe Pelanggan :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          TipePelanggan>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.name == '') {
                                                                            return "Tipe pelanggan tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    1,
                                                                                    53,
                                                                                    131,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(item.name.toUpperCase()),
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idTipePelanggan =
                                                                                value!.iD;
                                                                            tipePelanggan =
                                                                                value.name;

                                                                            tipePelangganController.text =
                                                                                idTipePelanggan;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          tipePelanggan != ''
                                                                              ? tipePelanggan
                                                                              : tipePelangganEdit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allTipePelanggan = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listTipePelanggan"];
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            tipePelangganController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tipe Pelanggan',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                              202,
                                              109,
                                              2,
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "PERSENTATION",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0,
                                                                left: 20.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Customer Request",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 15,
                                                        thickness: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      BootstrapContainer(
                                                        fluid: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 30, 0, 0),
                                                        children: <Widget>[
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Model :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Vgroup>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.vgroup == '') {
                                                                            return "Model tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
                                                                              item.vgroup.toUpperCase(),
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
                                                                            labelText:
                                                                                'Model',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVGroup =
                                                                                value!.iD;
                                                                            vGroup =
                                                                                value.vgroup;
                                                                            vGroupController.text =
                                                                                idVGroup;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vGroup != ''
                                                                              ? vGroup.toUpperCase()
                                                                              : vGroupEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVgroup = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<Vgroup>
                                                                              allModelVgroup =
                                                                              [];

                                                                          for (var element
                                                                              in allVgroup) {
                                                                            allModelVgroup.add(
                                                                              Vgroup(
                                                                                iD: element["iD"],
                                                                                vgroup: element["vgroup"],
                                                                              ),
                                                                            );
                                                                          }
                                                                          return allModelVgroup;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            vGroupController,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        autocorrect:
                                                                            false,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Model',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tahun :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          String>(
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Tahun tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items: [
                                                                          DateFormat('yyyy').format(DateTime.utc(DateTime.now().year +
                                                                              1)),
                                                                          DateFormat('yyyy')
                                                                              .format(DateTime.now()),
                                                                          DateFormat('yyyy').format(DateTime.utc(DateTime.now().year -
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
                                                                            labelText:
                                                                                'Tahun',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            tahunVal =
                                                                                value!;

                                                                            tahunController.text =
                                                                                tahunVal.toString();
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          tahunVal != ''
                                                                              ? tahunVal.toString()
                                                                              : tahunValEdit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        controller:
                                                                            tahunController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tahun',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Tahun',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Bahan Bakar :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          VfuelTransmisi>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.name == '') {
                                                                            return "Bahan bakar tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Bahan Bakar',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVfuel =
                                                                                value!.iD;
                                                                            vFuel =
                                                                                value.name;
                                                                            vFuelController.text =
                                                                                idVfuel;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vFuel != ''
                                                                              ? vFuel.toUpperCase()
                                                                              : vFuelEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVfuelTransmisi = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<VfuelTransmisi>
                                                                              allModelVfuelTransmisi =
                                                                              [];

                                                                          for (var element
                                                                              in allVfuelTransmisi) {
                                                                            allModelVfuelTransmisi.add(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        controller:
                                                                            vFuelController,
                                                                        autocorrect:
                                                                            false,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Bahan Bakar',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Transmisi :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          VfuelTransmisi>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.name == '') {
                                                                            return "Transmisi tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Transmisi',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVtransmisi =
                                                                                value!.iD;
                                                                            vTransmisi =
                                                                                value.name;
                                                                            vTransmisiController.text =
                                                                                idVtransmisi;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vTransmisi != ''
                                                                              ? vTransmisi.toUpperCase()
                                                                              : vTransmisiEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVfuelTransmisi = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<VfuelTransmisi>
                                                                              allModelVfuelTransmisi =
                                                                              [];

                                                                          for (var element
                                                                              in allVfuelTransmisi) {
                                                                            allModelVfuelTransmisi.add(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            vTransmisiController,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Transmisi',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                            ),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "ALTERNATIVE",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255,
                                                                  ),
                                                                  fontSize:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        12.5,
                                                                  ).value,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            height: 15,
                                                            thickness: 2,
                                                            indent: 0,
                                                            endIndent: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                          ),
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Model :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          Vgroup>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
                                                                              item.vgroup.toUpperCase(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        dropdownDecoratorProps:
                                                                            DropDownDecoratorProps(
                                                                          dropdownSearchDecoration:
                                                                              InputDecoration(
                                                                            hintStyle:
                                                                                textStyleColorWhite,
                                                                            labelText:
                                                                                'Model',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVGroup2 =
                                                                                value!.iD;
                                                                            vGroup2 =
                                                                                value.vgroup;
                                                                            vGroup2Controller.text =
                                                                                idVGroup2;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vGroup2 != ''
                                                                              ? vGroup2.toUpperCase()
                                                                              : data.listProspectSalesDetail![0].vgroup2 == ''
                                                                                  ? vGroup2Edit
                                                                                  : vGroup2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVgroup = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<Vgroup>
                                                                              allModelVgroup =
                                                                              [];

                                                                          for (var element
                                                                              in allVgroup) {
                                                                            allModelVgroup.add(
                                                                              Vgroup(
                                                                                iD: element["iD"],
                                                                                vgroup: element["vgroup"],
                                                                              ),
                                                                            );
                                                                          }
                                                                          return allModelVgroup;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            vGroup2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Model',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tahun :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          String>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items: [
                                                                          DateFormat('yyyy').format(DateTime.utc(DateTime.now().year +
                                                                              1)),
                                                                          DateFormat('yyyy')
                                                                              .format(DateTime.now()),
                                                                          DateFormat('yyyy').format(DateTime.utc(DateTime.now().year -
                                                                              1))
                                                                        ],
                                                                        dropdownDecoratorProps:
                                                                            DropDownDecoratorProps(
                                                                          dropdownSearchDecoration:
                                                                              InputDecoration(
                                                                            hintStyle:
                                                                                textStyleColorWhite,
                                                                            labelText:
                                                                                'Tahun',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            tahunVal2 =
                                                                                value!;

                                                                            tahun2Controller.text =
                                                                                tahunVal2;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          tahunVal2 != ''
                                                                              ? tahunVal2.toString()
                                                                              : tahunVal2Edit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            tahun2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tahun',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Bahan Bakar :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          VfuelTransmisi>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Bahan Bakar',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVfuel2 =
                                                                                value!.iD;
                                                                            vFuel2 =
                                                                                value.name;
                                                                            vFuel2Controller.text =
                                                                                idVfuel2;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vFuel2 != ''
                                                                              ? vFuel2.toUpperCase()
                                                                              : data.listProspectSalesDetail![0].vehicleFuel2 == ''
                                                                                  ? vFuel2Edit
                                                                                  : vFuel2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVfuelTransmisi2 = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<VfuelTransmisi>
                                                                              allModelVfuelTransmisi2 =
                                                                              [];

                                                                          for (var element
                                                                              in allVfuelTransmisi2) {
                                                                            allModelVfuelTransmisi2.add(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            vFuel2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Bahan Bakar',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Transmisi :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          VfuelTransmisi>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    202,
                                                                                    109,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          itemBuilder: (context, item, isSelected) =>
                                                                              ListTile(
                                                                            title:
                                                                                Text(
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
                                                                            labelText:
                                                                                'Transmisi',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            idVtransmisi2 =
                                                                                value!.iD;
                                                                            vTransmisi2 =
                                                                                value.name;
                                                                            vTransmisi2Controller.text =
                                                                                idVtransmisi2;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          vTransmisi2 != ''
                                                                              ? vTransmisi2.toUpperCase()
                                                                              : data.listProspectSalesDetail![0].transmisiV2 == ''
                                                                                  ? vTransmisi2Edit
                                                                                  : vTransmisi2Edit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                        asyncItems:
                                                                            (String
                                                                                filter) async {
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
                                                                          List allVfuelTransmisi2 = (jsonDecode(response.body) as Map<
                                                                              String,
                                                                              dynamic>)["listVgroup"];
                                                                          List<VfuelTransmisi>
                                                                              allModelVfuelTransmisi2 =
                                                                              [];

                                                                          for (var element
                                                                              in allVfuelTransmisi2) {
                                                                            allModelVfuelTransmisi2.add(
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            vTransmisi2Controller,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Transmisi',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                              146,
                                              2,
                                              2,
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "NEGOTIATION & CLOSING",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 25.0,
                                                                left: 20.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Skema Pembayaran",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveValue<
                                                                      double>(
                                                                context,
                                                                conditionalValues: [
                                                                  const Condition
                                                                      .equals(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0),
                                                                  const Condition.largerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value:
                                                                          17.0,
                                                                      landscapeValue:
                                                                          17.0,
                                                                      breakpoint:
                                                                          800),
                                                                ],
                                                                defaultValue:
                                                                    12.5,
                                                              ).value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 15,
                                                        thickness: 2,
                                                        indent: 0,
                                                        endIndent: 0,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      BootstrapContainer(
                                                        fluid: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 30, 0, 0),
                                                        children: <Widget>[
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Cash/Leasing :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            55,
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            20,
                                                                            0,
                                                                            25,
                                                                            0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            146,
                                                                            2,
                                                                            2,
                                                                          ),
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(10),
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                const Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255,
                                                                            ),
                                                                            width:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            ConstrainedBox(
                                                                          constraints:
                                                                              const BoxConstraints(
                                                                            minWidth:
                                                                                double.infinity,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showModalBottomSheet(
                                                                                        shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.vertical(
                                                                                            top: Radius.circular(20.0),
                                                                                          ),
                                                                                        ),
                                                                                        context: context,
                                                                                        builder: (context) {
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
                                                                                    padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                                                                                    child: Text(
                                                                                      cashLeasingVal != '' ? cashLeasingVal : cashLeasingValEdit,
                                                                                      style: textStyleColorWhite,
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
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cashLeasingController,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Cash/Leasing',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Down Payment :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          ModelSelect>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items:
                                                                            dPOptions,
                                                                        itemAsString:
                                                                            (ModelSelect dPOpt) =>
                                                                                dPOpt.value,
                                                                        dropdownDecoratorProps:
                                                                            DropDownDecoratorProps(
                                                                          dropdownSearchDecoration:
                                                                              InputDecoration(
                                                                            hintStyle:
                                                                                textStyleColorWhite,
                                                                            labelText:
                                                                                'Down Payment',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (ModelSelect?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            //print(value);
                                                                            dPVal =
                                                                                value!.value;
                                                                            dPController.text =
                                                                                dPVal;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          dPVal != ''
                                                                              ? dPVal
                                                                              : dPValEdit,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            dPController,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Down Payment',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tenor :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          ModelSelect>(
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items:
                                                                            tenorOptions,
                                                                        itemAsString: (ModelSelect tenorOpt) => tenorOpt
                                                                            .value
                                                                            .toUpperCase(),
                                                                        dropdownDecoratorProps:
                                                                            DropDownDecoratorProps(
                                                                          dropdownSearchDecoration:
                                                                              InputDecoration(
                                                                            hintStyle:
                                                                                textStyleColorWhite,
                                                                            labelText:
                                                                                'Down Payment',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (ModelSelect?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            //print(value);
                                                                            tenorVal =
                                                                                value!.value;
                                                                            tenorController.text =
                                                                                tenorVal;
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          tenorVal != ''
                                                                              ? tenorVal.toUpperCase()
                                                                              : tenorValEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            tenorController,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Tenor',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                            ),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "SYARAT KELENGKAPAN DOKUMEN",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255,
                                                                  ),
                                                                  fontSize:
                                                                      ResponsiveValue<
                                                                          double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        12.5,
                                                                  ).value,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            height: 15,
                                                            thickness: 2,
                                                            indent: 0,
                                                            endIndent: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                          ),
                                                          BootstrapRow(
                                                            children: <BootstrapCol>[
                                                              BootstrapCol(
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Tipe Customer 2 :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        controller:
                                                                            custTypeS2Controller,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Tipe Customer tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        autocorrect:
                                                                            false,
                                                                        readOnly:
                                                                            true,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                          hintText:
                                                                              'Tipe Customer',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          labelText:
                                                                              'Tipe Customer',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
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
                                                                                BorderRadius.circular(10.0),
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: valTipeCutS2 ==
                                                                            null ||
                                                                        valTipeCutS2 ==
                                                                            1
                                                                    ? Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ1,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ1 = value!;
                                                                                      if (checkQ1 == true) {
                                                                                        q1Controller.text = '1';
                                                                                      } else {
                                                                                        q1Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'KTP Suami Istri + Kartu Keluarga / Surat Nikah + NPWP Debitur',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q1Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q1',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ2,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ2 = value!;
                                                                                      if (checkQ2 == true) {
                                                                                        q2Controller.text = '1';
                                                                                      } else {
                                                                                        q2Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'PLN/PBB/AJB/Sertifikat Kepemilikan Rumah An. Debitur',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q2Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q2',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ3,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ3 = value!;
                                                                                      if (checkQ3 == true) {
                                                                                        q3Controller.text = '1';
                                                                                      } else {
                                                                                        q3Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Fixed Line',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q3Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q3',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ4,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ4 = value!;
                                                                                      if (checkQ4 == true) {
                                                                                        q4Controller.text = '1';
                                                                                      } else {
                                                                                        q4Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Rekening Koran 3 Bulan Terakhir',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q4Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q4',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ5,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ5 = value!;
                                                                                      if (checkQ5 == true) {
                                                                                        q5Controller.text = '1';
                                                                                      } else {
                                                                                        q5Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Slip Gaji / Surat Ket Penghasilan (Karyawan)',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q5Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q5',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ6,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ6 = value!;
                                                                                      if (checkQ6 == true) {
                                                                                        q6Controller.text = '1';
                                                                                      } else {
                                                                                        q6Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Siup, Npwp & Tdp (Pengusaha)',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q6Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q6',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ7,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ7 = value!;
                                                                                      if (checkQ7 == true) {
                                                                                        q1Controller.text = '1';
                                                                                      } else {
                                                                                        q1Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Ktp Pengurus + Pemegang Saham',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q1Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q7',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ8,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ8 = value!;
                                                                                      if (checkQ8 == true) {
                                                                                        q2Controller.text = '1';
                                                                                      } else {
                                                                                        q2Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'SIUP, TDP, BPWP',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q2Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q8',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ9,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ9 = value!;
                                                                                      if (checkQ9 == true) {
                                                                                        q3Controller.text = '1';
                                                                                      } else {
                                                                                        q3Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Surat Pengesahan Menteri Kehakiman',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q3Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q9',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ10,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ10 = value!;
                                                                                      if (checkQ10 == true) {
                                                                                        q4Controller.text = '1';
                                                                                      } else {
                                                                                        q4Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Surat Keterangan Domisili Perusahaan',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q4Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q10',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ11,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ11 = value!;
                                                                                      if (checkQ11 == true) {
                                                                                        q5Controller.text = '1';
                                                                                      } else {
                                                                                        q5Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Rekening Koran 3 Bulan Terakhir',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q5Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q11',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Checkbox(
                                                                                  activeColor: Colors.white,
                                                                                  checkColor: const Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  side: const BorderSide(color: Colors.white),
                                                                                  value: checkQ12,
                                                                                  onChanged: (bool? value) {
                                                                                    setState(() {
                                                                                      checkQ12 = value!;
                                                                                      if (checkQ12 == true) {
                                                                                        q6Controller.text = '1';
                                                                                      } else {
                                                                                        q6Controller.text = '0';
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Akta Pendirian Dan Perubahannya',
                                                                                    style: textStyleColorWhite,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                false,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: q6Controller,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Perorangan Q12',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                sizes:
                                                                    'col-md-6 col-12',
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          15),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Status :",
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                      child: DropdownSearch<
                                                                          ModelSelect>(
                                                                        validator:
                                                                            (val) {
                                                                          if (val == null ||
                                                                              val.value == '') {
                                                                            return "Status tidak boleh kosong";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        popupProps:
                                                                            PopupProps.dialog(
                                                                          // showSelectedItems: true,
                                                                          dialogProps:
                                                                              const DialogProps(
                                                                            shape:
                                                                                Border.symmetric(vertical: BorderSide.none),
                                                                          ),
                                                                          showSearchBox:
                                                                              true,
                                                                          searchFieldProps:
                                                                              TextFieldProps(
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Search..",
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    134,
                                                                                    134,
                                                                                    134,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    146,
                                                                                    2,
                                                                                    2,
                                                                                  ),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        items:
                                                                            statusOptions,
                                                                        itemAsString: (ModelSelect statusOpt) => statusOpt
                                                                            .value
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
                                                                            labelText:
                                                                                'Status',
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
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (ModelSelect?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            //print(value);
                                                                            idStatus =
                                                                                value!.id;
                                                                            status =
                                                                                value.value;
                                                                            statusController.text =
                                                                                idStatus.toString();
                                                                          });
                                                                        },
                                                                        dropdownBuilder:
                                                                            (context, selectedItem) =>
                                                                                Text(
                                                                          status != ''
                                                                              ? status.toUpperCase()
                                                                              : statusEdit.toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            statusController,
                                                                        autocorrect:
                                                                            false,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Status',
                                                                          hintStyle:
                                                                              textStyleColorWhite,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
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
                                                          idStatus == null &&
                                                                  idStatusEdit ==
                                                                      2
                                                              ? BootstrapRow(
                                                                  children: <BootstrapCol>[
                                                                    BootstrapCol(
                                                                      sizes:
                                                                          'col-md-6 col-12',
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Alasan Lost Prospect :",
                                                                                style: textStyleColorWhite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                20),
                                                                            child:
                                                                                DropdownSearch<ModelSelect>(
                                                                              popupProps: PopupProps.dialog(
                                                                                // showSelectedItems: true,
                                                                                dialogProps: const DialogProps(
                                                                                  shape: Border.symmetric(vertical: BorderSide.none),
                                                                                ),
                                                                                showSearchBox: true,
                                                                                searchFieldProps: TextFieldProps(
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "Search..",
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(
                                                                                        color: Color.fromARGB(
                                                                                          255,
                                                                                          134,
                                                                                          134,
                                                                                          134,
                                                                                        ),
                                                                                        width: 2,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(
                                                                                        color: Color.fromARGB(
                                                                                          255,
                                                                                          146,
                                                                                          2,
                                                                                          2,
                                                                                        ),
                                                                                        width: 2,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              items: alasanLpOptions,
                                                                              itemAsString: (ModelSelect alasanLp) => alasanLp.value.toUpperCase(),
                                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                dropdownSearchDecoration: InputDecoration(
                                                                                  hintStyle: textStyleColorWhite,
                                                                                  labelText: 'Alasan Lost Prospect',
                                                                                  labelStyle: const TextStyle(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                    ),
                                                                                  ),
                                                                                  enabledBorder: const OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                      ),
                                                                                      width: 2,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onChanged: (ModelSelect? value) {
                                                                                setState(() {
                                                                                  idAlasanLp = value!.id;
                                                                                  alasanLp = value.value;
                                                                                  alasanLostProspectController.text = idAlasanLp.toString();
                                                                                });
                                                                              },
                                                                              dropdownBuilder: (context, selectedItem) => Text(
                                                                                alasanLp != '' ? alasanLp.toUpperCase() : alasanLpEdit.toUpperCase(),
                                                                                style: textStyleColorWhite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                true,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: alasanLostProspectController,
                                                                              autocorrect: false,
                                                                              style: const TextStyle(color: Colors.white),
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Alasan Lost Prospect',
                                                                                hintStyle: textStyleColorWhite,
                                                                                enabledBorder: const OutlineInputBorder(
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
                                                                      sizes:
                                                                          'col-md-6 col-12',
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                15),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "keterangan :",
                                                                                style: textStyleColorWhite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                20),
                                                                            child:
                                                                                TextFormField(
                                                                              style: const TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                              autocorrect: false,
                                                                              controller: keteranganController,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Keterangan',
                                                                                hintStyle: textStyleColorWhite,
                                                                                labelText: 'Keterangan',
                                                                                labelStyle: const TextStyle(
                                                                                  color: Color.fromARGB(
                                                                                    255,
                                                                                    255,
                                                                                    255,
                                                                                    255,
                                                                                  ),
                                                                                ),
                                                                                enabledBorder: const OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                      255,
                                                                                    ),
                                                                                    width: 2,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : idStatus == 2
                                                                  ? BootstrapRow(
                                                                      children: <BootstrapCol>[
                                                                        BootstrapCol(
                                                                          sizes:
                                                                              'col-md-6 col-12',
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                                                child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    "Alasan Lost Prospect :",
                                                                                    style: textStyleColorWhite,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                                                                child: DropdownSearch<ModelSelect>(
                                                                                  popupProps: PopupProps.dialog(
                                                                                    // showSelectedItems: true,
                                                                                    dialogProps: const DialogProps(
                                                                                      shape: Border.symmetric(vertical: BorderSide.none),
                                                                                    ),
                                                                                    showSearchBox: true,
                                                                                    searchFieldProps: TextFieldProps(
                                                                                      decoration: InputDecoration(
                                                                                        hintText: "Search..",
                                                                                        enabledBorder: OutlineInputBorder(
                                                                                          borderSide: const BorderSide(
                                                                                            color: Color.fromARGB(
                                                                                              255,
                                                                                              134,
                                                                                              134,
                                                                                              134,
                                                                                            ),
                                                                                            width: 2,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderSide: const BorderSide(
                                                                                            color: Color.fromARGB(
                                                                                              255,
                                                                                              146,
                                                                                              2,
                                                                                              2,
                                                                                            ),
                                                                                            width: 2,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  items: alasanLpOptions,
                                                                                  itemAsString: (ModelSelect alasanLp) => alasanLp.value.toUpperCase(),
                                                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                    dropdownSearchDecoration: InputDecoration(
                                                                                      hintStyle: textStyleColorWhite,
                                                                                      labelText: 'Alasan Lost Prospect',
                                                                                      labelStyle: const TextStyle(
                                                                                        color: Color.fromARGB(
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                        ),
                                                                                      ),
                                                                                      enabledBorder: const OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color.fromARGB(
                                                                                            255,
                                                                                            255,
                                                                                            255,
                                                                                            255,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(
                                                                                          color: Color.fromARGB(
                                                                                            255,
                                                                                            255,
                                                                                            255,
                                                                                            255,
                                                                                          ),
                                                                                          width: 2,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  onChanged: (ModelSelect? value) {
                                                                                    setState(() {
                                                                                      idAlasanLp = value!.id;
                                                                                      alasanLp = value.value;
                                                                                      alasanLostProspectController.text = idAlasanLp.toString();
                                                                                    });
                                                                                  },
                                                                                  dropdownBuilder: (context, selectedItem) => Text(
                                                                                    alasanLp != '' ? alasanLp.toUpperCase() : alasanLpEdit.toUpperCase(),
                                                                                    style: textStyleColorWhite,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Visibility(
                                                                                visible: true,
                                                                                child: TextFormField(
                                                                                  controller: alasanLostProspectController,
                                                                                  autocorrect: false,
                                                                                  style: const TextStyle(color: Colors.white),
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Alasan Lost Prospect',
                                                                                    hintStyle: textStyleColorWhite,
                                                                                    enabledBorder: const OutlineInputBorder(
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
                                                                          sizes:
                                                                              'col-md-6 col-12',
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                                                child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    "keterangan :",
                                                                                    style: textStyleColorWhite,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                                                                child: TextFormField(
                                                                                  style: const TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  autocorrect: false,
                                                                                  controller: keteranganController,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Keterangan',
                                                                                    hintStyle: textStyleColorWhite,
                                                                                    labelText: 'Keterangan',
                                                                                    labelStyle: const TextStyle(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                        255,
                                                                                      ),
                                                                                    ),
                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color.fromARGB(
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(
                                                                                        color: Color.fromARGB(
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                          255,
                                                                                        ),
                                                                                        width: 2,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : BootstrapRow(
                                                                      children: <BootstrapCol>[
                                                                        BootstrapCol(
                                                                          child:
                                                                              const Text(""),
                                                                        ),
                                                                      ],
                                                                    ),
                                                          BootstrapRow(
                                                            children: [
                                                              BootstrapCol(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          20),
                                                                  child: Column(
                                                                    children: [
                                                                      OutlinedButton(
                                                                        style: OutlinedButton
                                                                            .styleFrom(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          fixedSize:
                                                                              Size(
                                                                            ResponsiveValue<double>(context,
                                                                                    conditionalValues: [
                                                                                      const Condition.equals(
                                                                                        name: TABLET,
                                                                                        value: 200,
                                                                                        landscapeValue: 200,
                                                                                      ),
                                                                                      const Condition.largerThan(name: TABLET, value: 200, landscapeValue: 200, breakpoint: 800),
                                                                                    ],
                                                                                    defaultValue: 130)
                                                                                .value,
                                                                            ResponsiveValue<double>(
                                                                              context,
                                                                              conditionalValues: [
                                                                                const Condition.equals(name: TABLET, value: 55, landscapeValue: 55),
                                                                                const Condition.largerThan(name: TABLET, value: 55, landscapeValue: 55, breakpoint: 800),
                                                                              ],
                                                                              defaultValue: 50,
                                                                            ).value,
                                                                          ),
                                                                          elevation:
                                                                              0,
                                                                          backgroundColor:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            129,
                                                                            127,
                                                                            127,
                                                                          ),
                                                                        ).copyWith(
                                                                          overlayColor:
                                                                              MaterialStateProperty.resolveWith<Color?>(
                                                                            (Set<MaterialState>
                                                                                states) {
                                                                              if (states.contains(MaterialState.pressed)) {
                                                                                return const Color.fromARGB(
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
                                                                        onPressed:
                                                                            () async {
                                                                          // if (formkey
                                                                          //     .currentState!
                                                                          //     .validate()) {
                                                                          var updateProspect =
                                                                              ListProspectUpdateResponse(
                                                                            prospectHId:
                                                                                prospectHIdController.text,
                                                                            prospectCode:
                                                                                prospectCodeController.text,
                                                                            dateContact:
                                                                                tglContactController.text,
                                                                            meetingPoint:
                                                                                lokasiBertemuController.text,
                                                                            postalCodeID:
                                                                                idKodePosController.text,
                                                                            ringArea:
                                                                                idAreaController.text,
                                                                            referensiID:
                                                                                sumberDataController.text,
                                                                            rencanaPembelian:
                                                                                int.tryParse(rencanaPembelianController.text),
                                                                            prospectStatus:
                                                                                int.tryParse(prospectStatusController.text),
                                                                            customerName:
                                                                                nameContactContactController.text,
                                                                            handphone1:
                                                                                noHP1ContactController.text,
                                                                            handphone2:
                                                                                noHP2ContactController.text,
                                                                            gender:
                                                                                int.tryParse(jKController.text),
                                                                            customerAddres:
                                                                                alamatController.text,
                                                                            postaclCodeACEID:
                                                                                idKodePosS2Controller.text,
                                                                            ringAreaACE:
                                                                                int.tryParse(idAreaS2Controller.text),
                                                                            email:
                                                                                emailController.text,
                                                                            customerTypeID:
                                                                                idCustTypeS2Controller.text,
                                                                            pekerjaan:
                                                                                jabatanController.text,
                                                                            kisaranHargaID:
                                                                                hKendaraanController.text,
                                                                            customerStatusID:
                                                                                tipePelangganController.text,
                                                                            vehicleGroupID1:
                                                                                vGroupController.text,
                                                                            vehicleYear1:
                                                                                tahunController.text,
                                                                            vehicleFuelID1:
                                                                                vFuelController.text,
                                                                            transmisiVehicle1:
                                                                                vTransmisiController.text,
                                                                            vehicleGroupID2:
                                                                                vGroup2Controller.text,
                                                                            vehicleYear2:
                                                                                tahun2Controller.text,
                                                                            vehicleFuelID2:
                                                                                vFuel2Controller.text,
                                                                            transmisiVehicle2:
                                                                                vTransmisi2Controller.text,
                                                                            payment:
                                                                                cashLeasingController.text,
                                                                            downPayment:
                                                                                dPController.text,
                                                                            tenor:
                                                                                tenorController.text,
                                                                            q1: int.tryParse(q1Controller.text),
                                                                            q2: int.tryParse(q2Controller.text),
                                                                            q3: int.tryParse(q3Controller.text),
                                                                            q4: int.tryParse(q4Controller.text),
                                                                            q5: int.tryParse(q5Controller.text),
                                                                            q6: int.tryParse(q6Controller.text),
                                                                            trackingStatus:
                                                                                int.tryParse(statusController.text),
                                                                            trackingReason:
                                                                                int.tryParse(alasanLostProspectController.text),
                                                                            trackingInfo:
                                                                                keteranganController.text,
                                                                          );

                                                                          try {
                                                                            var resp =
                                                                                await ref.read(updateProspectFormProviderDetail).onUpdateProspect(updateProspect);

                                                                            print(" 1: ${tglContactController.text} ${prospectHIdController.text} ${prospectCodeController.text}");
                                                                            print(" 2: ${lokasiBertemuController.text} ${idKodePosController.text} ${idAreaController.text}");
                                                                            print(" 3: ${sumberDataController.text} ${int.tryParse(rencanaPembelianController.text)} ${nameContactContactController.text}");
                                                                            print(" 4: ${int.tryParse(prospectStatusController.text)} ${int.tryParse(rencanaPembelianController.text)} ${nameContactContactController.text}");
                                                                            print(" 5: ${noHP1ContactController.text} ${noHP2ContactController.text} ${int.tryParse(jKController.text)}");
                                                                            print(" 6: ${alamatController.text} ${idKodePosS2Controller.text} ${int.tryParse(idAreaS2Controller.text)}");
                                                                            print(" 7: ${emailController.text} ${idCustTypeS2Controller.text} ${jabatanController.text}");
                                                                            print(" 8: ${hKendaraanController.text} ${tipePelangganController.text} ${vGroupController.text}");
                                                                            print(" 9: ${tahunController.text} ${vFuelController.text} ${vTransmisiController.text}");
                                                                            print(" 10: ${vGroup2Controller.text} ${tahun2Controller.text} ${vFuel2Controller.text}");
                                                                            print(" 11: ${vTransmisi2Controller.text} ${cashLeasingController.text} ${dPController.text}");
                                                                            print(" 12: ${tenorController.text} ${int.tryParse(q1Controller.text)} ${int.tryParse(q2Controller.text)}");
                                                                            print(" 13: ${int.tryParse(q3Controller.text)} ${int.tryParse(q4Controller.text)} ${int.tryParse(q5Controller.text)}");
                                                                            print(" 14: ${int.tryParse(q6Controller.text)} ${int.tryParse(statusController.text)} ${int.tryParse(alasanLostProspectController.text)}");
                                                                            print(" 15: ${keteranganController.text} ");

                                                                            if (resp.statusMessage ==
                                                                                "Success Updated") {
                                                                              tglContactController.clear();
                                                                              lokasiBertemuController.clear();
                                                                              formkey.currentState!.reset();
                                                                            }

                                                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()),
                                                                                (route) => false);

                                                                            sucessUpdate(context);
                                                                          } catch (e) {
                                                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()),
                                                                                (route) => false);

                                                                            catchError(
                                                                              context,
                                                                              e,
                                                                            );
                                                                          }
                                                                          // }
                                                                        },
                                                                        child:
                                                                            Stack(
                                                                          children: <Widget>[
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "Simpan",
                                                                                textAlign: TextAlign.center,
                                                                                style: textStyleColorWhite,
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
                                    );
                                  },
                                  error: (err, stack) => Text('Error $err'),
                                  loading: () => const Center(
                                    child: Column(
                                      children: [loadingAnimation()],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sucessUpdate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: ("Sucess Updated" == "Sucess Updated")
            ? Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text("Message : Sucess Updated"),
      ),
    );
  }
}
