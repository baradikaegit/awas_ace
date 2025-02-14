// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptAfterSlsFunnelingResponse {
  ListRptAfterSlsFunnelingResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptAfterSalesFunneling,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptAfterSalesFunneling>? listRptAfterSalesFunneling;

  ListRptAfterSlsFunnelingResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptAfterSalesFunneling = (json['listRptAfterSalesFunneling'] != null)
        ? List.from(json['listRptAfterSalesFunneling'])
            .map((e) => ListRptAfterSalesFunneling.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptAfterSalesFunneling'] =
        listRptAfterSalesFunneling!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptAfterSalesFunneling {
  ListRptAfterSalesFunneling({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerName,
    required this.data1,
    required this.connected,
    required this.contacted,
    required this.cai,
    required this.perConnected,
    required this.perContacted,
    required this.perCai,
    required this.tipe,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerName;
  late final int data1;
  late final int connected;
  late final int contacted;
  late final int cai;
  late final int perConnected;
  late final int perContacted;
  late final int perCai;
  late final String tipe;

  ListRptAfterSalesFunneling.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    data1 = json['data1'];
    connected = json['connected'];
    contacted = json['contacted'];
    cai = json['cai'];
    perConnected = json['perConnected'];
    perContacted = json['perContacted'];
    perCai = json['perCai'];
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
    _data['data1'] = data1;
    _data['connected'] = connected;
    _data['contacted'] = contacted;
    _data['cai'] = cai;
    _data['perConnected'] = perConnected;
    _data['perContacted'] = perContacted;
    _data['perCai'] = perCai;
    _data['tipe'] = tipe;
    return _data;
  }
}
