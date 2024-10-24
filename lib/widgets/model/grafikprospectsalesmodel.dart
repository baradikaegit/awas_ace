// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListGrafikProspectSalesResponse {
  ListGrafikProspectSalesResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listGrafikProspectSales,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListGrafikProspectSales>? listGrafikProspectSales;

  ListGrafikProspectSalesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listGrafikProspectSales = (json['listGrafikProspectSales']) != null
        ? List.from(json['listGrafikProspectSales'])
            .map((e) => ListGrafikProspectSales.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listGrafikProspectSales'] =
        listGrafikProspectSales!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListGrafikProspectSales {
  ListGrafikProspectSales({
    required this.num,
    required this.header,
    required this.today,
    required this.monthToDate,
  });
  late final int num;
  late final String header;
  late final int today;
  late final int monthToDate;

  ListGrafikProspectSales.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    header = json['header'];
    today = json['today'];
    monthToDate = json['monthToDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['header'] = header;
    _data['today'] = today;
    _data['monthToDate'] = monthToDate;
    return _data;
  }
}
