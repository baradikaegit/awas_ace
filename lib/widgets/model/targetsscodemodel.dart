// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListTargetSSCodeResponse {
  ListTargetSSCodeResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listSSCode,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListSSCode>? listSSCode;

  ListTargetSSCodeResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listSSCode = (json['listSSCode'] != null)
        ? List.from(json['listSSCode'])
            .map((e) => ListSSCode.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listSSCode'] = listSSCode!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListSSCode {
  ListSSCode({
    required this.salesCode,
    required this.salesName,
    required this.ssCode,
    required this.ssName,
  });
  late final String salesCode;
  late final String salesName;
  late final String ssCode;
  late final String ssName;

  ListSSCode.fromJson(Map<String, dynamic> json) {
    salesCode = json['salesCode'];
    salesName = json['salesName'];
    ssCode = json['ssCode'];
    ssName = json['ssName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['salesCode'] = salesCode;
    _data['salesName'] = salesName;
    _data['ssCode'] = ssCode;
    _data['ssName'] = ssName;
    return _data;
  }
}
