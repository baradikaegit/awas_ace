// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptAfterSlsProspekGRUeBPResponse {
  ListRptAfterSlsProspekGRUeBPResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptProspekGRtoUeBP,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptProspekGRtoUeBP>? listRptProspekGRtoUeBP;

  ListRptAfterSlsProspekGRUeBPResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptProspekGRtoUeBP = (json['listRptProspekGRtoUeBP'] != null)
        ? List.from(json['listRptProspekGRtoUeBP'])
            .map((e) => ListRptProspekGRtoUeBP.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptProspekGRtoUeBP'] =
        listRptProspekGRtoUeBP!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptProspekGRtoUeBP {
  ListRptProspekGRtoUeBP({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerName,
    required this.headerCode,
    required this.ueGR,
    required this.prospek,
    required this.ueBP,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerName;
  late final String headerCode;
  late final int ueGR;
  late final int prospek;
  late final int ueBP;

  ListRptProspekGRtoUeBP.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerName = json['headerName'];
    headerCode = json['headerCode'];
    ueGR = json['ueGR'];
    prospek = json['prospek'];
    ueBP = json['ueBP'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerName'] = headerName;
    _data['headerCode'] = headerCode;
    _data['ueGR'] = ueGR;
    _data['prospek'] = prospek;
    _data['ueBP'] = ueBP;
    return _data;
  }
}
