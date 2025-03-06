// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptGeneralMntSaldoResponse {
  ListRptGeneralMntSaldoResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGeneralMonitoringSaldo,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGeneralMonitoringSaldo>? listRptGeneralMonitoringSaldo;

  ListRptGeneralMntSaldoResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGeneralMonitoringSaldo =
        (json['listRptGeneralMonitoringSaldo'] != null)
            ? List.from(json['listRptGeneralMonitoringSaldo'])
                .map((e) => ListRptGeneralMonitoringSaldo.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGeneralMonitoringSaldo'] =
        listRptGeneralMonitoringSaldo!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGeneralMonitoringSaldo {
  ListRptGeneralMonitoringSaldo({
    required this.num,
    required this.headerCode,
    required this.headerName,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.data4,
    required this.title,
    required this.tipe,
  });
  late final int num;
  late final String headerCode;
  late final String headerName;
  late final String data1;
  late final String data2;
  late final String data3;
  late final String data4;
  late final String title;
  late final String tipe;

  ListRptGeneralMonitoringSaldo.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    data1 = json['data1'];
    data2 = json['data2'];
    data3 = json['data3'];
    data4 = json['data4'];
    title = json['title'];
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['data1'] = data1;
    _data['data2'] = data2;
    _data['data3'] = data3;
    _data['data4'] = data4;
    _data['title'] = title;
    _data['tipe'] = tipe;
    return _data;
  }
}
