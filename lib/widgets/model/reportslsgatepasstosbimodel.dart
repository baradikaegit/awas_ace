// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptGatepassToSbiResponse {
  ListRptGatepassToSbiResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGatepassToSBI,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGatepassToSBI>? listRptGatepassToSBI;

  ListRptGatepassToSbiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGatepassToSBI = (json['listRptGatepassToSBI'] != null)
        ? List.from(json['listRptGatepassToSBI'])
            .map((e) => ListRptGatepassToSBI.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGatepassToSBI'] =
        listRptGatepassToSBI!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGatepassToSBI {
  ListRptGatepassToSBI({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerName,
    required this.headerCode2,
    required this.gatepass,
    required this.sbi,
    required this.persentase,
    required this.title,
    required this.tipe,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerName;
  late final String headerCode2;
  late final int gatepass;
  late final int sbi;
  late final String persentase;
  late final String title;
  late final String tipe;

  ListRptGatepassToSBI.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    headerCode2 = json['headerCode2'];
    gatepass = json['gatepass'];
    sbi = json['sbi'];
    persentase = json['persentase'];
    title = json['title'];
    tipe = json['tipe'];
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
    _data['headerCode2'] = headerCode2;
    _data['gatepass'] = gatepass;
    _data['sbi'] = sbi;
    _data['persentase'] = persentase;
    _data['title'] = title;
    _data['tipe'] = tipe;
    return _data;
  }
}
