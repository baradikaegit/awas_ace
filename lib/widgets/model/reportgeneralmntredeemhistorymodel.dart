// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptRedeemHistoryResponse {
  ListRptRedeemHistoryResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGeneralMonitoringRedeemHistory,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGeneralMonitoringRedeemHistory>?
      listRptGeneralMonitoringRedeemHistory;

  ListRptRedeemHistoryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGeneralMonitoringRedeemHistory =
        (json['listRptGeneralMonitoringRedeemHistory'] != null)
            ? List.from(json['listRptGeneralMonitoringRedeemHistory'])
                .map((e) => ListRptGeneralMonitoringRedeemHistory.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGeneralMonitoringRedeemHistory'] =
        listRptGeneralMonitoringRedeemHistory!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGeneralMonitoringRedeemHistory {
  ListRptGeneralMonitoringRedeemHistory({
    required this.iD,
    required this.createdOn,
    required this.poin,
    required this.title,
    required this.images,
    required this.description,
    required this.name,
  });
  late final String iD;
  late final String createdOn;
  late final String poin;
  late final String title;
  late final String images;
  late final String description;
  late final String name;

  ListRptGeneralMonitoringRedeemHistory.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    createdOn = json['createdOn'];
    poin = json['poin'];
    title = json['title'];
    images = json['images'];
    description = json['description'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['createdOn'] = createdOn;
    _data['poin'] = poin;
    _data['title'] = title;
    _data['images'] = images;
    _data['description'] = description;
    _data['name'] = name;
    return _data;
  }
}
