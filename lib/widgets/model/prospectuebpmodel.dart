// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListProspectUEBP {
  ListProspectUEBP({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectUEBPData,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectUEBPData>? listProspectUEBPData;

  ListProspectUEBP.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectUEBPData = (json['listProspectUEBPData'] != null)
        ? List.from(json['listProspectUEBPData'])
            .map((e) => ListProspectUEBPData.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectUEBPData'] =
        listProspectUEBPData!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectUEBPData {
  ListProspectUEBPData({
    required this.iD,
    required this.branchBusinessUnitID,
    required this.branchBPID,
    required this.vehicleTypeID,
    required this.nomorPolisi,
    required this.nama,
    required this.noHandPhone,
    required this.tahunKendaraan,
    required this.keterangan,
    required this.branch,
    required this.branchBP,
    required this.vtype,
  });
  late final String iD;
  late final String branchBusinessUnitID;
  late final String branchBPID;
  late final String vehicleTypeID;
  late final String nomorPolisi;
  late final String nama;
  late final String noHandPhone;
  late final String tahunKendaraan;
  late final String keterangan;
  late final String branch;
  late final String branchBP;
  late final String vtype;

  ListProspectUEBPData.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    branchBusinessUnitID = json['branchBusinessUnitID'];
    branchBPID = json['branchBPID'];
    vehicleTypeID = json['vehicleTypeID'];
    nomorPolisi = json['nomorPolisi'];
    nama = json['nama'];
    noHandPhone = json['noHandPhone'];
    tahunKendaraan = json['tahunKendaraan'];
    keterangan = json['keterangan'];
    branch = json['branch'];
    branchBP = json['branchBP'];
    vtype = json['vtype'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['branchBPID'] = branchBPID;
    _data['vehicleTypeID'] = vehicleTypeID;
    _data['nomorPolisi'] = nomorPolisi;
    _data['nama'] = nama;
    _data['noHandPhone'] = noHandPhone;
    _data['tahunKendaraan'] = tahunKendaraan;
    _data['keterangan'] = keterangan;
    _data['branch'] = branch;
    _data['branchBP'] = branchBP;
    _data['vtype'] = vtype;
    return _data;
  }
}

//add prospect ue bp
class ListEntryProspectUEBP {
  ListEntryProspectUEBP({
    this.branchBusinessUnitID,
    this.branchBPID,
    this.customerServiceID,
    this.vehicleTypeID,
    this.nomorPolisi,
    this.nama,
    this.noHandPhone,
    this.tahunKendaraan,
    this.keterangan,
  });

  late String? branchBusinessUnitID;
  late String? branchBPID;
  late String? customerServiceID;
  late String? vehicleTypeID;
  late String? nomorPolisi;
  late String? nama;
  late String? noHandPhone;
  late String? tahunKendaraan;
  late String? keterangan;

  ListEntryProspectUEBP.fromJson(Map<String, dynamic> djson) {
    branchBusinessUnitID = djson['branchBusinessUnitID'];
    branchBPID = djson['branchBPID'];
    customerServiceID = djson['customerServiceID'];
    vehicleTypeID = djson['vehicleTypeID'];
    nomorPolisi = djson['nomorPolisi'];
    nama = djson['nama'];
    noHandPhone = djson['noHandPhone'];
    tahunKendaraan = djson['tahunKendaraan'];
    keterangan = djson['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['branchBPID'] = branchBPID;
    _data['customerServiceID'] = customerServiceID;
    _data['vehicleTypeID'] = vehicleTypeID;
    _data['nomorPolisi'] = nomorPolisi;
    _data['nama'] = nama;
    _data['noHandPhone'] = noHandPhone;
    _data['tahunKendaraan'] = tahunKendaraan;
    _data['keterangan'] = keterangan;

    return _data;
  }
}

class ProspectUEBPResponse {
  ProspectUEBPResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListEntryProspectUEBP? data;

  ProspectUEBPResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListEntryProspectUEBP.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectUEBPData'] = data!.toJson();
    return _data;
  }
}
