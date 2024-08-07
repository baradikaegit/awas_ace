// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListReferensiResponse {
  ListReferensiResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listCallin,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListCallin>? listCallin;

  ListReferensiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listCallin = (json['listCallin'] != null)
        ? List.from(json['listCallin'])
            .map((e) => ListCallin.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listCallin'] = listCallin!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListCallin {
  ListCallin({
    required this.referensiID,
    required this.code,
    required this.name,
    required this.callCustomerDetailID,
    required this.amount,
    required this.callDate,
    required this.callCustomerHeaderID,
    required this.branchBusinessUnitID,
    required this.salesmanHeaderID,
    required this.days,
    required this.type,
  });
  late final String referensiID;
  late final String code;
  late final String name;
  late final String callCustomerDetailID;
  late final String callDate;
  late final int amount;
  late final String callCustomerHeaderID;
  late final String branchBusinessUnitID;
  late final String salesmanHeaderID;
  late final int days;
  late final String type;

  ListCallin.fromJson(Map<String, dynamic> json) {
    referensiID = json['referensiID'];
    code = json['code'];
    name = json['name'];
    callCustomerDetailID = json['callCustomerDetailID'];
    callDate = json['callDate'];
    amount = json['amount'];
    callCustomerHeaderID = json['callCustomerHeaderID'];
    branchBusinessUnitID = json['branchBusinessUnitID'];
    salesmanHeaderID = json['salesmanHeaderID'];
    days = json['days'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['referensiID'] = referensiID;
    _data['code'] = code;
    _data['name'] = name;
    _data['callCustomerDetailID'] = callCustomerDetailID;
    _data['callDate'] = callDate;
    _data['amount'] = amount;
    _data['callCustomerHeaderID'] = callCustomerHeaderID;
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['salesmanHeaderID'] = salesmanHeaderID;
    _data['days'] = days;
    _data['type'] = type;
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
