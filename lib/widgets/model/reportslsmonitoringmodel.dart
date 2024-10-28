// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListMonitroingVolProfitMakerResponse {
  ListMonitroingVolProfitMakerResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listMonitoringVolProfitMaker,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListMonitoringVolProfitMaker>? listMonitoringVolProfitMaker;

  ListMonitroingVolProfitMakerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listMonitoringVolProfitMaker =
        (json['listMonitoringVolProfitMaker'] != null)
            ? List.from(json['listMonitoringVolProfitMaker'])
                .map((e) => ListMonitoringVolProfitMaker.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listMonitoringVolProfitMaker'] =
        listMonitoringVolProfitMaker!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListMonitoringVolProfitMaker {
  ListMonitoringVolProfitMaker({
    required this.num,
    required this.headerName,
    required this.isiHeader,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.growth,
    required this.color,
    required this.total,
    required this.title,
  });
  late final int num;
  late final String headerName;
  late final String isiHeader;
  late final int data1;
  late final int data2;
  late final int data3;
  late final int growth;
  late final String color;
  late final int total;
  late final String title;

  ListMonitoringVolProfitMaker.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    headerName = json['headerName'];
    isiHeader = json['isiHeader'];
    data1 = json['data1'];
    data2 = json['data2'];
    data3 = json['data3'];
    growth = json['growth'];
    color = json['color'];
    total = json['total'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['headerName'] = headerName;
    _data['isiHeader'] = isiHeader;
    _data['data1'] = data1;
    _data['data2'] = data2;
    _data['data3'] = data3;
    _data['growth'] = growth;
    _data['color'] = color;
    _data['total'] = total;
    _data['title'] = title;
    return _data;
  }
}
