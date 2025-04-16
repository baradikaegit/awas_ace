// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListProfileResponse {
  ListProfileResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listGetProfileTeam,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListGetProfileTeam>? listGetProfileTeam;

  ListProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listGetProfileTeam = (json['listGetProfileTeam'] != null)
        ? List.from(json['listGetProfileTeam'])
            .map((e) => ListGetProfileTeam.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listGetProfileTeam'] =
        listGetProfileTeam!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListGetProfileTeam {
  ListGetProfileTeam({
    required this.branch,
    required this.salesCode,
    required this.salesName,
    required this.ssCode,
    required this.ssName,
    required this.kodeJabatan,
    required this.totalStatus1,
    required this.totalStatus2,
    required this.totalStatus3,
  });
  late final String branch;
  late final String salesCode;
  late final String salesName;
  late final String ssCode;
  late final String ssName;
  late final String kodeJabatan;
  late final int totalStatus1;
  late final int totalStatus2;
  late final int totalStatus3;

  ListGetProfileTeam.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    salesCode = json['salesCode'];
    salesName = json['salesName'];
    ssCode = json['ssCode'];
    ssName = json['ssName'];
    kodeJabatan = json['kodeJabatan'];
    totalStatus1 = json['totalStatus1'];
    totalStatus2 = json['totalStatus2'];
    totalStatus3 = json['totalStatus3'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['branch'] = branch;
    _data['salesCode'] = salesCode;
    _data['salesName'] = salesName;
    _data['ssCode'] = ssCode;
    _data['ssName'] = ssName;
    _data['kodeJabatan'] = kodeJabatan;
    _data['totalStatus1'] = totalStatus1;
    _data['totalStatus2'] = totalStatus2;
    _data['totalStatus3'] = totalStatus3;
    return _data;
  }
}
