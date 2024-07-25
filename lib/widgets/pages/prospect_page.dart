// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/widgets/main_page.dart';
import 'package:awas_ace/widgets/model/custtypemodel.dart';
import 'package:awas_ace/widgets/model/kisaranhargamodel.dart';
import 'package:awas_ace/widgets/model/sumberdatamodel.dart';
import 'package:awas_ace/widgets/model/tipepelangganmodel.dart';
import 'package:awas_ace/widgets/model/vgroupmodel.dart';
import 'package:awas_ace/widgets/model/wilayah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProspectPage extends StatefulWidget {
  const ProspectPage({super.key});

  static const String routeName = "/prospectPage";

  @override
  State<ProspectPage> createState() => _ProspectPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ProspectPageState extends State<ProspectPage>
    with TickerProviderStateMixin {
  //STEP 1
  TextEditingController tglContactController = TextEditingController();
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
  TextEditingController modelController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController bahanBakarController = TextEditingController();
  TextEditingController transmisiController = TextEditingController();
  TextEditingController alternativeModelController = TextEditingController();
  TextEditingController alternativeTahunController = TextEditingController();
  TextEditingController alternativeBahanBakarController =
      TextEditingController();
  TextEditingController alternativeTransmisiController =
      TextEditingController();
  TextEditingController cashLeasingController = TextEditingController();
  TextEditingController dPController = TextEditingController();
  TextEditingController tenorController = TextEditingController();
  TextEditingController tipeCustS4Controller = TextEditingController();

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
  String iDRencanaPembelian = '';
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
  String kendaraanVal = '';
  String tahunVal = '';
  String bahanBakarVal = '';
  String transmisiVal = '';
  String altKendaraanVal = '';
  String altTahunVal = '';
  String altBahanBakarVal = '';
  String altTransmisiVal = '';
  String cashLeasingVal = '';
  String dPVal = '';
  String tenorVal = '';
  String tipeCustS4Val = '';
  int? idTipeCustS4Val;
  int? idTc;

  bool check = false;

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

  List<ModelSelect> tipeCustOptions = [
    ModelSelect('Retail', 1),
    ModelSelect('Fleet', 2)
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

  List<ModelSelect> hargaKendaranOptions = [
    ModelSelect('130 jt s/d 250jt', 1),
    ModelSelect('251 jt s/d 400jt', 2),
    ModelSelect('401 jt s/d 600jt', 3),
    ModelSelect('> 600 jt', 4),
  ];

  List<ModelSelect> bahanBakarOptions = [
    ModelSelect('Bensin', 1),
    ModelSelect('Diesel', 2)
  ];

  List<ModelSelect> transmisiOptions = [
    ModelSelect('Automatic', 1),
    ModelSelect('Manual', 2)
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

  List<ModelSelect> tipeCustS4Options = [
    ModelSelect('Perorangan', 1),
    ModelSelect('Perusahaan', 2),
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Gagal mengambil data: Silahkan Login Kembali"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Terjadi Kesalahan: $error"),
        ),
      );
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Gagal mengambil data: Silahkan Login Kembali"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Terjadi Kesalahan: $error"),
        ),
      );
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Gagal mengambil data: Silahkan Login Kembali"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Terjadi Kesalahan: $error"),
        ),
      );
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Gagal mengambil data: Silahkan Login Kembali"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Terjadi Kesalahan: $error"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    tglContactController.text = "";
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    //fetchDataFromApi(idKab, idKec);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        indicatorPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        //indicatorWeight: 10.0,
        dividerColor: Colors.brown,
        unselectedLabelColor: Colors.amberAccent,
        labelColor: const Color.fromARGB(
          255,
          9,
          155,
          28,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: _tabController.index == 0
              ? const Color.fromARGB(255, 134, 134, 134)
              : _tabController.index == 1
                  ? const Color.fromARGB(255, 1, 53, 131)
                  : _tabController.index == 2
                      ? const Color.fromARGB(255, 202, 109, 2)
                      : const Color.fromARGB(255, 146, 2, 2),
        ),
        tabs: [
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sticky_note_2_outlined,
                  color:
                      _tabController.index == 0 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  " STEP 1",
                  style: TextStyle(
                    color:
                        _tabController.index == 0 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt_outlined,
                  color:
                      _tabController.index == 1 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  " STEP 2",
                  style: TextStyle(
                    color:
                        _tabController.index == 1 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car,
                  color:
                      _tabController.index == 2 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  "STEP 3",
                  style: TextStyle(
                    color:
                        _tabController.index == 2 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.handshake_outlined,
                  color:
                      _tabController.index == 3 ? Colors.white : Colors.amber,
                  size: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      const Condition.equals(
                          name: TABLET, value: 24.0, landscapeValue: 24.0),
                      const Condition.largerThan(
                          name: TABLET,
                          value: 24.0,
                          landscapeValue: 24.0,
                          breakpoint: 800),
                    ],
                    defaultValue: 20.0,
                  ).value,
                ),
                Text(
                  "STEP 4",
                  style: TextStyle(
                    color:
                        _tabController.index == 3 ? Colors.white : Colors.amber,
                    fontSize: ResponsiveValue<double>(
                      context,
                      conditionalValues: [
                        const Condition.equals(
                            name: TABLET, value: 14.0, landscapeValue: 14.0),
                        const Condition.largerThan(
                            name: TABLET,
                            value: 14.0,
                            landscapeValue: 14.0,
                            breakpoint: 800),
                      ],
                      defaultValue: 12.0,
                    ).value,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    if (idTipeCustS4Val != null) {
      tipeCustS4Controller =
          TextEditingController(text: idTipeCustS4Val.toString());
    } else {
      tipeCustS4Controller = TextEditingController(text: '1');
    }

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

    return DefaultTabController(
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
        body: TabBarView(
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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formkey,
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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              children: <Widget>[
                                BootstrapRow(
                                  children: <BootstrapCol>[
                                    BootstrapCol(
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tanggal Contact :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: tglContactController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Tanggal Contact',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Tanggal Contact',
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
                                                  borderSide: const BorderSide(
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
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2050),
                                                );
                                                if (pickedDate != null) {
                                                  String formatDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  setState(() {
                                                    tglContactController.text =
                                                        formatDate;
                                                  });
                                                } else {
                                                  //print("Tanggal tidak dipilih");
                                                  tglContactController.text =
                                                      "";
                                                }
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Lokasi Bertemu :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              autocorrect: false,
                                              controller:
                                                  lokasiBertemuController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Lokasi Bertemu',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Provinsi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
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
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Provinsi',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  nameProv = value!.text;
                                                  nameKab = '';
                                                  nameKec = '';
                                                  nameKel = '';
                                                  kodePosController.clear();
                                                  idKodePosController.clear();
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahProvinsi",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kota :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.text.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kota',
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKota/$nameProv",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kecamatan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.text.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kecamatan',
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKecamatan/$nameProv/$nameKab",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kelurahan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.text.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kelurahan',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  nameKel = value!.text;
                                                  fetchDataKodePos(
                                                      nameProv,
                                                      nameKab,
                                                      nameKec,
                                                      nameKel);

                                                  print(
                                                      "$nameProv, $nameKab, $nameKec, $nameKel");
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKelurahan/$nameProv/$nameKab/$nameKec",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kode Pos :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              controller: kodePosController,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              //controller: userNameCtr,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Kode Pos',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                              controller: idKodePosController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Kode Pos',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Area :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              autocorrect: false,
                                              controller: areaController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Area',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Sumber Data :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<SumberData>(
                                              popupProps: PopupProps.dialog(
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                    vertical: BorderSide.none,
                                                  ),
                                                ),
                                                showSearchBox: true,
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
                                                  labelText: 'Sumber Data',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  iDSumberData = value!.iD;
                                                  sumberData = value.name;
                                                  sumberDataController.text =
                                                      iDSumberData;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                sumberData != ''
                                                    ? sumberData.toUpperCase()
                                                    : "Belum memilih sumber data",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetSumberData",
                                                  ),
                                                );

                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allSumberData =
                                                    (jsonDecode(response.body)
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
                                              controller: sumberDataController,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                hintText: 'Sumber Data',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Rencana Pembelian :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<ModelSelect>(
                                              popupProps:
                                                  const PopupProps.dialog(
                                                dialogProps: DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                searchFieldProps:
                                                    TextFieldProps(
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              items: rencanaPembelianOptions,
                                              itemAsString: (ModelSelect
                                                      rencanaPembelianOptions) =>
                                                  rencanaPembelianOptions.value,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText:
                                                      'Rencana Pembelian',
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
                                              onChanged: (ModelSelect? value) {
                                                setState(() {
                                                  iDRencanaPembelian =
                                                      value!.id.toString();
                                                  rencanaPembelian =
                                                      value.value;
                                                  rencanaPembelianController
                                                          .text =
                                                      iDRencanaPembelian;

                                                  if (iDRencanaPembelian ==
                                                          '4' ||
                                                      iDRencanaPembelian ==
                                                          '5') {
                                                    prospectStatusController
                                                        .text = '1';
                                                  } else if (iDRencanaPembelian ==
                                                      '3') {
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
                                                hintText: 'Rencana Pembelian',
                                                hintStyle: textStyleColorWhite,
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
                                                hintStyle: textStyleColorWhite,
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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                //key: formkey,
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 20.0),
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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              children: <Widget>[
                                BootstrapRow(
                                  children: <BootstrapCol>[
                                    BootstrapCol(
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Nama Contact :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller:
                                                  nameContactContactController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Nama Contact',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "No HP1 :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller:
                                                  noHP1ContactController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'No HP1',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "No HP2 :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller:
                                                  noHP2ContactController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'No HP2',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Jenis Kelamin :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  1,
                                                  53,
                                                  131,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: jKOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
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
                                                                  80, 5, 80, 5),
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
                                                hintText: 'Jabatan',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Alamat :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: alamatController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Alamat',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Provinsi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.text.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Provinsi',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  nameProvS2 = value!.text;
                                                  nameKabS2 = '';
                                                  nameKecS2 = '';
                                                  nameKelS2 = '';
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
                                                    : "Belum memilih provinsi",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahProvinsi",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kota :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.text.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kota',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  nameKabS2 = value!.text;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKabS2 != ''
                                                    ? nameKabS2.toUpperCase()
                                                    : "Belum memilih kota",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKota/$nameProvS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "kecamatan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(item.text),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kecamatan',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  nameKecS2 = value!.text;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKecS2 != ''
                                                    ? nameKecS2.toUpperCase()
                                                    : "Belum memilih kecamatan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKecamatan/$nameProvS2/$nameKabS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kelurahan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Wilayah>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(item.text),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Kelurahan',
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
                                                    ? nameKelS2.toUpperCase()
                                                    : "Belum memilih kelurahan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetWilayahKelurahan/$nameProvS2/$nameKabS2/$nameKecS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listWilayah"];
                                                List<Wilayah> allModelWilayah =
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
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kode Pos :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              controller: kodePosS2Controller,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Kode Pos',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                              controller: idKodePosS2Controller,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Kode Pos',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Area :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: areaS2Controller,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Area',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                              controller: idAreaS2Controller,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Area',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "E-mail :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: emailController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'E-mail',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tipe Customer :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<CustType>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.name.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
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
                                              onChanged: (value) {
                                                setState(() {
                                                  idTipeCustS2 =
                                                      value!.iD.toString();
                                                  tipeCustS2 = value.name;
                                                  valTipeCutS2 = value.val;

                                                  idCustTypeS2Controller.text =
                                                      idTipeCustS2;
                                                  custTypeS2Controller.text =
                                                      tipeCustS2;
                                                  // print(
                                                  //     "idProvinsi : $nameProvS2");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                tipeCustS2 != ''
                                                    ? tipeCustS2.toUpperCase()
                                                    : "Belum memilih tipe customer",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetCustType",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allCustType =
                                                    (jsonDecode(response.body)
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Jabatan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<ModelSelect>(
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
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              items: jabatanOptions,
                                              itemAsString:
                                                  (ModelSelect jabatanOpt) =>
                                                      jabatanOpt.value,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Jabatan',
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
                                              onChanged: (ModelSelect? value) {
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Kisaran Harga Kendaraan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<KisaranHarga>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
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
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText:
                                                      'Kisaran Harga Kendaraan',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  idHargaKendaraan =
                                                      value!.iD.toString();
                                                  hargaKendaraan = value.name;

                                                  hKendaraanController.text =
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetKisaranHarga",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allKisaranHarga =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listKisaranHarga"];
                                                List<KisaranHarga>
                                                    allModelKisaranHarga = [];

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
                                              controller: hKendaraanController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Kisaran Harga Kendaraan',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tipe Pelanggan :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child:
                                                DropdownSearch<TipePelanggan>(
                                              popupProps: PopupProps.dialog(
                                                // showSelectedItems: true,
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
                                                      item.name.toUpperCase()),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Tipe Pelanggan',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  idTipePelanggan = value!.iD;
                                                  tipePelanggan = value.name;

                                                  tipePelangganController.text =
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
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetTipePelanggan",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allTipePelanggan =
                                                    (jsonDecode(response.body)
                                                            as Map<String,
                                                                dynamic>)[
                                                        "listTipePelanggan"];
                                                List<TipePelanggan>
                                                    allModelTipePelanggan = [];

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
                                                hintStyle: textStyleColorWhite,
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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 20.0),
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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              children: <Widget>[
                                BootstrapRow(
                                  children: <BootstrapCol>[
                                    BootstrapCol(
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Model :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Vgroup>(
                                              popupProps: PopupProps.dialog(
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
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
                                                  labelText: 'Model',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  kendaraanVal = value!.vgroup;
                                                  modelController.text =
                                                      kendaraanVal;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                kendaraanVal != ''
                                                    ? kendaraanVal.toUpperCase()
                                                    : "Belum memilih model",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetVgroup",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allVgroup = (jsonDecode(
                                                        response.body)
                                                    as Map<String,
                                                        dynamic>)["listVgroup"];
                                                List<Vgroup> allModelVgroup =
                                                    [];

                                                for (var element in allVgroup) {
                                                  allModelVgroup.add(
                                                    Vgroup(
                                                      vgroup: element["vgroup"],
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
                                              controller: modelController,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                hintText: 'Model',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tahun :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<String>(
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
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              items: [
                                                DateFormat('yyyy').format(
                                                    DateTime.utc(
                                                        DateTime.now().year +
                                                            1)),
                                                DateFormat('yyyy')
                                                    .format(DateTime.now()),
                                                DateFormat('yyyy').format(
                                                    DateTime.utc(
                                                        DateTime.now().year -
                                                            1))
                                              ],
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
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
                                              onChanged: (value) {
                                                setState(() {
                                                  tahunVal = value!;
                                                  tahunController.text =
                                                      tahunVal;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                tahunVal != ''
                                                    ? tahunVal
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Bahan Bakar :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  202,
                                                  109,
                                                  2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: bahanBakarOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(bahanBakarOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  bahanBakarVal = bahanBakarOptions[indexSelect].value.toUpperCase();
                                                                                  bahanBakarController.text = bahanBakarVal;
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
                                                                  80, 5, 80, 5),
                                                          child: Text(
                                                            bahanBakarVal != ''
                                                                ? bahanBakarVal
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
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              controller: bahanBakarController,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Bahan Bakar',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Transmisi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  202,
                                                  109,
                                                  2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: transmisiOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(transmisiOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  transmisiVal = transmisiOptions[indexSelect].value.toUpperCase();
                                                                                  transmisiController.text = transmisiVal;
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
                                                                  80, 5, 80, 5),
                                                          child: Text(
                                                            transmisiVal != ''
                                                                ? transmisiVal
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
                                              controller: transmisiController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Transmisi',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Model :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<Vgroup>(
                                              popupProps: PopupProps.dialog(
                                                dialogProps: const DialogProps(
                                                  shape: Border.symmetric(
                                                      vertical:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: true,
                                                itemBuilder: (context, item,
                                                        isSelected) =>
                                                    ListTile(
                                                  title: Text(
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
                                                  labelText: 'Model',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  altKendaraanVal =
                                                      value!.vgroup;
                                                  alternativeModelController
                                                      .text = altKendaraanVal;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                altKendaraanVal != ''
                                                    ? altKendaraanVal
                                                        .toUpperCase()
                                                    : "Belum memilih model",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "${urlApi()}Wilayah/GetVgroup",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allVgroup = (jsonDecode(
                                                        response.body)
                                                    as Map<String,
                                                        dynamic>)["listVgroup"];
                                                List<Vgroup> allModelVgroup =
                                                    [];

                                                for (var element in allVgroup) {
                                                  allModelVgroup.add(
                                                    Vgroup(
                                                      vgroup: element["vgroup"],
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
                                              controller:
                                                  alternativeModelController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Model',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tahun :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<String>(
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
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              items: [
                                                DateFormat('yyyy').format(
                                                    DateTime.utc(
                                                        DateTime.now().year +
                                                            1)),
                                                DateFormat('yyyy')
                                                    .format(DateTime.now()),
                                                DateFormat('yyyy').format(
                                                    DateTime.utc(
                                                        DateTime.now().year -
                                                            1))
                                              ],
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
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
                                              onChanged: (value) {
                                                setState(() {
                                                  altTahunVal = value!;
                                                  alternativeTahunController
                                                      .text = altTahunVal;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                altTahunVal != ''
                                                    ? altTahunVal
                                                    : "Belum memilih Tahun",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: false,
                                            child: TextFormField(
                                              controller:
                                                  alternativeTahunController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Tahun',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Bahan Bakar :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  202,
                                                  109,
                                                  2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: bahanBakarOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(bahanBakarOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  altBahanBakarVal = bahanBakarOptions[indexSelect].value.toUpperCase();
                                                                                  alternativeBahanBakarController.text = altBahanBakarVal;
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
                                                                  80, 5, 80, 5),
                                                          child: Text(
                                                            altBahanBakarVal !=
                                                                    ''
                                                                ? altBahanBakarVal
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
                                                  alternativeBahanBakarController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Bahan Bakar',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Transmisi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  202,
                                                  109,
                                                  2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: transmisiOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
                                                                          return GestureDetector(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                                                                                child: Text(transmisiOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  altTransmisiVal = transmisiOptions[indexSelect].value.toUpperCase();
                                                                                  alternativeTransmisiController.text = altTransmisiVal;
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
                                                                  80, 5, 80, 5),
                                                          child: Text(
                                                            altTransmisiVal !=
                                                                    ''
                                                                ? altTransmisiVal
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
                                                  alternativeTransmisiController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Transmisi',
                                                hintStyle: textStyleColorWhite,
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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 20.0),
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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              children: <Widget>[
                                BootstrapRow(
                                  children: <BootstrapCol>[
                                    BootstrapCol(
                                      sizes: 'col-md-6 col-12',
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Cash/Leasing :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  146,
                                                  2,
                                                  2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
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
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return ListView
                                                                    .separated(
                                                                        itemCount: cashLeasingOptions
                                                                            .length,
                                                                        separatorBuilder: (context,
                                                                            int
                                                                                int) {
                                                                          return const Divider();
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexSelect) {
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
                                                                  80, 5, 80, 5),
                                                          child: Text(
                                                            cashLeasingVal != ''
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
                                              controller: cashLeasingController,
                                              autocorrect: false,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Cash/Leasing',
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Down Payment :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<ModelSelect>(
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
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              onChanged: (ModelSelect? value) {
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tenor :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: DropdownSearch<ModelSelect>(
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
                                                  decoration: InputDecoration(
                                                    hintText: "Search...",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                          255,
                                                          1,
                                                          53,
                                                          131,
                                                        ),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
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
                                              items: tenorOptions,
                                              itemAsString:
                                                  (ModelSelect tenorOpt) =>
                                                      tenorOpt.value,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintStyle:
                                                      textStyleColorWhite,
                                                  labelText: 'Down Payment',
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
                                              onChanged: (ModelSelect? value) {
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
                                                    ? tenorVal
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
                                                hintStyle: textStyleColorWhite,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Tipe Customer :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: custTypeS2Controller,
                                              autocorrect: false,
                                              readOnly: true,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Tipe Customer',
                                                hintStyle: textStyleColorWhite,
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
                                                  borderSide: const BorderSide(
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'KTP Suami Istri + Kartu Keluarga / Surat Nikah + NPWP Debitur',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'PLN/PBB/AJB/Sertifikat Kepemilikan Rumah An. Debitur',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Fixed Line',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Rekening Koran 3 Bulan Terakhir',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Slip Gaji / Surat Ket Penghasilan (Karyawan)',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Siup, Npwp & Tdp (Pengusaha)',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Ktp Pengurus + Pemegang Saham',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'SIUP, TDP, BPWP',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Surat Pengesahan Menteri Kehakiman',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Surat Keterangan Domisili Perusahaan',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Rekening Koran 3 Bulan Terakhir',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        activeColor:
                                                            Colors.white,
                                                        checkColor: const Color
                                                            .fromARGB(
                                                          255,
                                                          146,
                                                          2,
                                                          2,
                                                        ),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.white),
                                                        value: check,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            check = value!;
                                                          });
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Akta Pendirian Dan Perubahannya',
                                                          style:
                                                              textStyleColorWhite,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Status :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              //controller: userNameCtr,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Status',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Status',
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
                                                  borderSide: const BorderSide(
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
                                  children: [
                                    BootstrapCol(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 20),
                                        child: Column(
                                          children: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                                                name: TABLET,
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
                                                      const Condition.equals(
                                                          name: TABLET,
                                                          value: 55,
                                                          landscapeValue: 55),
                                                      const Condition
                                                          .largerThan(
                                                          name: TABLET,
                                                          value: 55,
                                                          landscapeValue: 55,
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
                                                        .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
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
                                              onPressed: () {},
                                              child: Stack(
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
