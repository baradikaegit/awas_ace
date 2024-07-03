import 'dart:convert';

import 'package:awas_ace/widgets/model/wilayah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';

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
  TextEditingController tglcontact = TextEditingController();
  final TextEditingController kodePos = TextEditingController();
  late TabController _tabController;

  String idProv = '';
  String nameProv = '';
  String idKab = '';
  String nameKab = '';
  String idKec = '';
  String nameKec = '';
  String idKel = '';
  String nameKel = '';
  String idKodePos = '';

  String idProvS2 = '';
  String nameProvS2 = '';
  String idKabS2 = '';
  String nameKabS2 = '';
  String idKecS2 = '';
  String nameKecS2 = '';
  String idKelS2 = '';
  String nameKelS2 = '';

  String jkValue = '';
  int jkId = 0;
  String tipeCustVal = '';
  String jabatan = '';
  String kisaranHargaKendaraan = '';
  String tipePelanggan = '';

  final List _dataFromApi = [];
  //final List<Map<String, dynamic>> _dataFromApi = [];

  List<ModelSelect> selectOptions = [
    ModelSelect('Laki - Laki', 1),
    ModelSelect('Perempuan', 2)
  ];

  List<ModelSelect> tipeCustOptions = [
    ModelSelect('Retail', 1),
    ModelSelect('Fleet', 2)
  ];

  void fetchDataFromApi(String idKab, String idKec) async {
    var url = Uri.parse(
      'https://alamat.thecloudalert.com/api/kodepos/get/?d_kabkota_id=$idKab&d_kecamatan_id=$idKec',
    );

    //print(url);
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List data =
            (jsonDecode(response.body) as Map<String, dynamic>)["result"];

        for (var element in data) {
          _dataFromApi.add(element);
        }

        setState(() {
          for (int a = 0; a < _dataFromApi.length; a++) {
            idKodePos = _dataFromApi[a]["text"];
            kodePos.text = idKodePos;
            print("KodePos : $idKodePos");
          }
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    tglcontact.text = "";
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sticky_note_2_outlined,
                  color:
                      _tabController.index == 0 ? Colors.white : Colors.amber,
                ),
                Text(
                  " STEP 1",
                  style: TextStyle(
                    color:
                        _tabController.index == 0 ? Colors.white : Colors.amber,
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
                ),
                Text(
                  " STEP 2",
                  style: TextStyle(
                    color:
                        _tabController.index == 1 ? Colors.white : Colors.amber,
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
                ),
                Text(
                  "STEP 3",
                  style: TextStyle(
                    color:
                        _tabController.index == 2 ? Colors.white : Colors.amber,
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
                ),
                Text(
                  "STEP 4",
                  style: TextStyle(
                    color:
                        _tabController.index == 3 ? Colors.white : Colors.amber,
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
          title: const Text("Entry Prospect Sales"),
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
                                              controller: tglcontact,
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
                                                    tglcontact.text =
                                                        formatDate;
                                                  });
                                                } else {
                                                  //print("Tanggal tidak dipilih");
                                                  tglcontact.text = "";
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
                                                // showSelectedItems: true,
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
                                                  idProv = value!.id;
                                                  nameProv = value.text;
                                                  print("idProvinsi : $idProv");
                                                });
                                              },
                                              // onChanged: (value) =>
                                              //     idProv = value?.id,

                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameProv != ''
                                                    ? nameProv
                                                    : "Belum memilih provinsi",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    //"https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey",
                                                    "https://alamat.thecloudalert.com/api/provinsi/get/",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKab = value!.id;
                                                  nameKab = value.text;
                                                  fetchDataFromApi(
                                                      idKab, idKec);
                                                  print("Kota : $idKab");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKab != ''
                                                    ? nameKab
                                                    : "Belum memilih kota",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/kabkota/get/?d_provinsi_id=$idProv",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKec = value!.id;
                                                  nameKec = value.text;
                                                  fetchDataFromApi(
                                                      idKab, idKec);
                                                  print("Kecamatan : $idKec");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKec != ''
                                                    ? nameKec
                                                    : "Belum memilih kecamatan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/kecamatan/get/?d_kabkota_id=$idKab",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKel = value!.id;
                                                  nameKel = value.text;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKel != ''
                                                    ? nameKel
                                                    : "Belum memilih kelurahan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                      "https://alamat.thecloudalert.com/api/kelurahan/get/?d_kecamatan_id=$idKec"),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                              controller: kodePos,
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
                                                "Sumber Data :",
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
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Sumber Data',
                                                hintStyle: textStyleColorWhite,
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
                                                "Rencana Pembelian :",
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
                                              //controller: userNameCtr,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Rencana Pembelian',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Rencana Pembelian',
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
                                              //controller: userNameCtr,
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
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                  255,
                                                  148,
                                                  148,
                                                  148,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
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
                                                                        itemCount: selectOptions
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
                                                                                child: Text(selectOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  jkValue = selectOptions[indexSelect].value.toUpperCase();
                                                                                  jkId = selectOptions[indexSelect].id;
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
                                                                  15,
                                                                  80,
                                                                  15),
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
                                              //controller: userNameCtr,
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
                                                  idProvS2 = value!.id;
                                                  nameProvS2 = value.text;
                                                  print(
                                                      "idProvinsi : $idProvS2");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameProvS2 != ''
                                                    ? nameProvS2
                                                    : "Belum memilih provinsi",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/provinsi/get/",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKabS2 = value!.id;
                                                  nameKabS2 = value.text;

                                                  print("Kota : $idKabS2");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKabS2 != ''
                                                    ? nameKabS2
                                                    : "Belum memilih kota",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/kabkota/get/?d_provinsi_id=$idProvS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKecS2 = value!.id;
                                                  nameKecS2 = value.text;

                                                  print("Kecamatan : $idKecS2");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKecS2 != ''
                                                    ? nameKecS2
                                                    : "Belum memilih kecamatan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/kecamatan/get/?d_kabkota_id=$idKabS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                                  idKelS2 = value!.id;
                                                  nameKelS2 = value.text;

                                                  print("kelurahan : $idKelS2");
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                nameKelS2 != ''
                                                    ? nameKelS2
                                                    : "Belum memilih kelurahan",
                                                style: textStyleColorWhite,
                                              ),
                                              asyncItems:
                                                  (String filter) async {
                                                var response = await http.get(
                                                  Uri.parse(
                                                    "https://alamat.thecloudalert.com/api/kelurahan/get/?d_kecamatan_id=$idKecS2",
                                                  ),
                                                );
                                                if (response.statusCode !=
                                                    200) {
                                                  return [];
                                                }
                                                List allWilayah =
                                                    (jsonDecode(response.body)
                                                        as Map<String,
                                                            dynamic>)["result"];
                                                List<Wilayah> allModelWilayah =
                                                    [];

                                                for (var element
                                                    in allWilayah) {
                                                  allModelWilayah.add(
                                                    Wilayah(
                                                      id: element["id"],
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
                                              //controller: userNameCtr,
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
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 25, 0),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                  255,
                                                  148,
                                                  148,
                                                  148,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
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
                                                                        itemCount: tipeCustOptions
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
                                                                                child: Text(tipeCustOptions[indexSelect].value.toUpperCase()),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  tipeCustVal = tipeCustOptions[indexSelect].value.toUpperCase();
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
                                                                  15,
                                                                  80,
                                                                  15),
                                                          child: Text(
                                                            tipeCustVal != ''
                                                                ? tipeCustVal
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
                                            child: DropdownSearch<String>(
                                              popupProps:
                                                  const PopupProps.dialog(
                                                // showSelectedItems: true,
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
                                              items: const [
                                                "Karyawan Swasta",
                                                "PNS",
                                                "Karyawan BUMN",
                                                "Wiraswasta / Bisnis / Usaha",
                                                "Pelajar / Mahasiswa",
                                                "Profesional (Dokter, Polisi, Pengacara, Militer)",
                                                "Bapak / Ibu Rumah Tangga",
                                                "Lainnya",
                                              ],
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
                                              onChanged: (value) {
                                                setState(() {
                                                  //print(value);
                                                  jabatan = value!;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                jabatan != ''
                                                    ? jabatan
                                                    : "Belum memilih Jabatan",
                                                style: textStyleColorWhite,
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
                                            child: DropdownSearch<String>(
                                              popupProps:
                                                  const PopupProps.dialog(
                                                // showSelectedItems: true,
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
                                              items: const [
                                                '130 jt s/d 250jt',
                                                '251 jt s/d 400jt',
                                                '401 jt s/d 600jt',
                                                '> 600 jt'
                                              ],
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
                                                  print(value);
                                                  kisaranHargaKendaraan =
                                                      value!;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                kisaranHargaKendaraan != ''
                                                    ? kisaranHargaKendaraan
                                                    : "Belum memilih Kisaran Harga Kendaraan",
                                                style: textStyleColorWhite,
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
                                            child: DropdownSearch<String>(
                                              popupProps:
                                                  const PopupProps.dialog(
                                                // showSelectedItems: true,
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
                                              items: const [
                                                'First Buyer',
                                                'Replacement',
                                                'Additional',
                                              ],
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
                                                  print(value);
                                                  tipePelanggan = value!;
                                                });
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                tipePelanggan != ''
                                                    ? tipePelanggan
                                                    : "Belum memilih Tipe Pelanggan",
                                                style: textStyleColorWhite,
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
                                            child: TextFormField(
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Model',
                                                hintStyle: textStyleColorWhite,
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
                                                "Tahun :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
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
                                                "Bahan Bakar :",
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
                                                hintText: 'Bahan Bakar',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Bahan Bakar',
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
                                                "Transmisi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Transmisi',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Transmisi',
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
                                            child: TextFormField(
                                              //controller: userNameCtr,
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Model',
                                                hintStyle: textStyleColorWhite,
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
                                                "Tahun :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
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
                                                "Bahan Bakar :",
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
                                                hintText: 'Bahan Bakar',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Bahan Bakar',
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
                                                "Transmisi :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Transmisi',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Transmisi',
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
                                            child: TextFormField(
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Cash/Leasing',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Cash/Leasing',
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
                                                "Down Payment :",
                                                style: textStyleColorWhite,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: TextFormField(
                                              autocorrect: false,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: 'Down Payment',
                                                hintStyle: textStyleColorWhite,
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
                                                "Tenor :",
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
                                                hintText: 'Tenor',
                                                hintStyle: textStyleColorWhite,
                                                labelText: 'Tenor',
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
                                              //controller: userNameCtr,
                                              autocorrect: false,
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
