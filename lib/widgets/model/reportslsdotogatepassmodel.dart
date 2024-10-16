// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptDoToGatepassResponse {
  ListRptDoToGatepassResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptDoToGatepass,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptDoToGatepass>? listRptDoToGatepass;

  ListRptDoToGatepassResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptDoToGatepass = (json['listRptDoToGatepass'] != null)
        ? List.from(json['listRptDoToGatepass'])
            .map((e) => ListRptDoToGatepass.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptDoToGatepass'] =
        listRptDoToGatepass!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptDoToGatepass {
  ListRptDoToGatepass({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerName,
    required this.dO,
    required this.gatepass,
    required this.persentase,
    required this.title,
    required this.tipe,
    required this.linkPage,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerName;
  late final int dO;
  late final int gatepass;
  late final String persentase;
  late final String title;
  late final String tipe;
  late final String linkPage;

  ListRptDoToGatepass.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    dO = json['dO'];
    gatepass = json['gatepass'];
    persentase = json['persentase'];
    title = json['title'];
    tipe = json['tipe'];
    linkPage = json['linkPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['dO'] = dO;
    _data['gatepass'] = gatepass;
    _data['persentase'] = persentase;
    _data['title'] = title;
    _data['tipe'] = tipe;
    _data['linkPage'] = linkPage;
    return _data;
  }
}
