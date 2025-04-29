// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptGeneralMntSaldoHistoryResponse {
  ListRptGeneralMntSaldoHistoryResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGeneralMonitoringSaldoHistory,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGeneralMonitoringSaldoHistory>?
      listRptGeneralMonitoringSaldoHistory;

  ListRptGeneralMntSaldoHistoryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGeneralMonitoringSaldoHistory =
        (json['listRptGeneralMonitoringSaldoHistory'] != null)
            ? List.from(json['listRptGeneralMonitoringSaldoHistory'])
                .map((e) => ListRptGeneralMonitoringSaldoHistory.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGeneralMonitoringSaldoHistory'] =
        listRptGeneralMonitoringSaldoHistory!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGeneralMonitoringSaldoHistory {
  ListRptGeneralMonitoringSaldoHistory({
    required this.rowGroup,
    required this.header1,
    required this.header2,
    required this.header3,
    required this.header4,
    required this.title,
    required this.amount,
    required this.totalAmount,
    required this.balanceStatus,
    required this.iD,
  });
  late final int rowGroup;
  late final String header1;
  late final String header2;
  late final String header3;
  late final String header4;
  late final String title;
  late final int amount;
  late final int totalAmount;
  late final String balanceStatus;
  late final String iD;

  ListRptGeneralMonitoringSaldoHistory.fromJson(Map<String, dynamic> json) {
    rowGroup = json['rowGroup'];
    header1 = json['header1'];
    header2 = json['header2'];
    header3 = json['header3'];
    header4 = json['header4'];
    title = json['title'];
    amount = json['amount'];
    totalAmount = json['totalAmount'];
    balanceStatus = json['balanceStatus'];
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
    _data['amount'] = amount;
    _data['totalAmount'] = totalAmount;
    _data['balanceStatus'] = balanceStatus;
    _data['iD'] = iD;
    return _data;
  }
}
