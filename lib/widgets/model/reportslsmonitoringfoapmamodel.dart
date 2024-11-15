// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListMonitroingFoaPMAResponse {
  ListMonitroingFoaPMAResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listMonitoringFoaPMA,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListMonitoringFoaPMA>? listMonitoringFoaPMA;

  ListMonitroingFoaPMAResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listMonitoringFoaPMA = (json['listMonitoringFoaPMA'] != null)
        ? List.from(json['listMonitoringFoaPMA'])
            .map((e) => ListMonitoringFoaPMA.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listMonitoringFoaPMA'] =
        listMonitoringFoaPMA!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListMonitoringFoaPMA {
  ListMonitoringFoaPMA({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.tipe,
    required this.headerCode,
    required this.headerName,
    required this.headerCode2,
    required this.headerName2,
    required this.dO,
    required this.foa,
    required this.pma,
    required this.others,
    required this.persenFoa,
    required this.persenPMA,
    required this.persenOthers,
    required this.title,
    required this.linkPage,
    required this.viewX,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String tipe;
  late final String headerCode;
  late final String headerName;
  late final String headerCode2;
  late final String headerName2;
  late final int dO;
  late final int foa;
  late final int pma;
  late final int others;
  late final int persenFoa;
  late final int persenPMA;
  late final int persenOthers;
  late final String title;
  late final String linkPage;
  late final String viewX;

  ListMonitoringFoaPMA.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    tipe = json['tipe'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    headerCode2 = json['headerCode2'];
    headerName2 = json['headerName2'];
    dO = json['dO'];
    foa = json['foa'];
    pma = json['pma'];
    others = json['others'];
    persenFoa = json['persenFoa'];
    persenPMA = json['persenPMA'];
    persenOthers = json['persenOthers'];
    title = json['title'];
    linkPage = json['linkPage'];
    viewX = json['viewX'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['tipe'] = tipe;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['headerCode2'] = headerCode2;
    _data['headerName2'] = headerName2;
    _data['dO'] = dO;
    _data['foa'] = foa;
    _data['pma'] = pma;
    _data['others'] = others;
    _data['persenFoa'] = persenFoa;
    _data['persenPMA'] = persenPMA;
    _data['persenOthers'] = persenOthers;
    _data['title'] = title;
    _data['linkPage'] = linkPage;
    _data['viewX'] = viewX;
    return _data;
  }
}
