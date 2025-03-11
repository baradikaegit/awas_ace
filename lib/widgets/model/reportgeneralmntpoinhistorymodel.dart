// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptGeneralMntPoinHistoryResponse {
  ListRptGeneralMntPoinHistoryResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGeneralMonitoringPoinHistory,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGeneralMonitoringPoinHistory>?
      listRptGeneralMonitoringPoinHistory;

  ListRptGeneralMntPoinHistoryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGeneralMonitoringPoinHistory =
        (json['listRptGeneralMonitoringPoinHistory'] != null)
            ? List.from(json['listRptGeneralMonitoringPoinHistory'])
                .map((e) => ListRptGeneralMonitoringPoinHistory.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGeneralMonitoringPoinHistory'] =
        listRptGeneralMonitoringPoinHistory!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGeneralMonitoringPoinHistory {
  ListRptGeneralMonitoringPoinHistory({
    required this.rowGroup,
    required this.header1,
    required this.header2,
    required this.header3,
    required this.header4,
    required this.title,
    required this.poin,
    required this.totalPoin,
    required this.totalRedeem,
    required this.poinTipe,
    required this.iD,
  });

  late final int rowGroup;
  late final String header1;
  late final String header2;
  late final String header3;
  late final String header4;
  late final String title;
  late final int poin;
  late final int totalPoin;
  late final int totalRedeem;
  late final String poinTipe;
  late final String iD;

  ListRptGeneralMonitoringPoinHistory.fromJson(Map<String, dynamic> json) {
    rowGroup = json['rowGroup'];
    header1 = json['header1'];
    header2 = json['header2'];
    header3 = json['header3'];
    header4 = json['header4'];
    title = json['title'];
    poin = json['poin'];
    totalPoin = json['totalPoin'];
    totalRedeem = json['totalRedeem'];
    poinTipe = json['poinTipe'];
    iD = json['iD'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rowGroup'] = rowGroup;
    _data['header1'] = header1;
    _data['header2'] = header2;
    _data['header3'] = header3;
    _data['header4'] = header4;
    _data['title'] = title;
    _data['poin'] = poin;
    _data['totalPoin'] = totalPoin;
    _data['totalRedeem'] = totalRedeem;
    _data['poinTipe'] = poinTipe;
    _data['iD'] = iD;

    return _data;
  }
}
