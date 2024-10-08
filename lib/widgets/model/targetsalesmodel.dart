// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListTargetSalesResponse {
  ListTargetSalesResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listTargetSales,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListTargetSales>? listTargetSales;

  ListTargetSalesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listTargetSales = (json['listTargetSales'] != null)
        ? List.from(json['listTargetSales'])
            .map((e) => ListTargetSales.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listTargetSales'] = listTargetSales!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListTargetSales {
  ListTargetSales({
    required this.iD,
    required this.branchBusinessUnitID,
    required this.salesCode,
    required this.ssCode,
    required this.tahun,
    required this.bulan,
    required this.call,
    required this.prospect,
    required this.hot,
    required this.spk,
    required this.dO,
    required this.branch,
    required this.bulanNum,
  });
  late final String iD;
  late final String branchBusinessUnitID;
  late final String salesCode;
  late final String ssCode;
  late final int tahun;
  late final String bulan;
  late final int call;
  late final int prospect;
  late final int hot;
  late final int spk;
  late final int dO;
  late final String branch;
  late final int bulanNum;

  ListTargetSales.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    branchBusinessUnitID = json['branchBusinessUnitID'];
    salesCode = json['salesCode'];
    ssCode = json['ssCode'];
    tahun = json['tahun'];
    bulan = json['bulan'];
    call = json['call'];
    prospect = json['prospect'];
    hot = json['hot'];
    spk = json['spk'];
    dO = json['dO'];
    branch = json['branch'];
    bulanNum = json['bulanNum'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['salesCode'] = salesCode;
    _data['ssCode'] = ssCode;
    _data['tahun'] = tahun;
    _data['bulan'] = bulan;
    _data['call'] = call;
    _data['prospect'] = prospect;
    _data['hot'] = hot;
    _data['spk'] = spk;
    _data['dO'] = dO;
    _data['branch'] = branch;
    _data['bulanNum'] = bulanNum;
    return _data;
  }
}

//add target sales
class ListEntryTargetSales {
  ListEntryTargetSales({
    required this.branchBusinessUnitID,
    required this.salesmanID,
    required this.tahun,
    required this.bulan,
    required this.call,
    required this.prospect,
    required this.hot,
    required this.spk,
    required this.dO,
  });

  late String? branchBusinessUnitID;
  late String? salesmanID;
  late String? tahun;
  late int? bulan;
  late int? call;
  late int? prospect;
  late int? hot;
  late int? spk;
  late int? dO;

  ListEntryTargetSales.fromJson(Map<String, dynamic> json) {
    branchBusinessUnitID = json['branchBusinessUnitID'];
    salesmanID = json['salesmanID'];
    tahun = json['tahun'];
    bulan = json['bulan'];
    call = json['call'];
    prospect = json['prospect'];
    hot = json['hot'];
    spk = json['spk'];
    dO = json['dO'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['salesmanID'] = salesmanID;
    _data['tahun'] = tahun;
    _data['bulan'] = bulan;
    _data['call'] = call;
    _data['prospect'] = prospect;
    _data['hot'] = hot;
    _data['spk'] = spk;
    _data['dO'] = dO;

    return _data;
  }
}

class TargetSalesResponse {
  TargetSalesResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListEntryTargetSales? data;

  TargetSalesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListEntryTargetSales.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listTargetSales'] = data!.toJson();
    return _data;
  }
}
