// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptBodyPaintProspekBPUeGRResponse {
  ListRptBodyPaintProspekBPUeGRResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptProspekBPtoUeGR,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptProspekBPtoUeGR>? listRptProspekBPtoUeGR;

  ListRptBodyPaintProspekBPUeGRResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptProspekBPtoUeGR = (json['listRptProspekBPtoUeGR'] != null)
        ? List.from(json['listRptProspekBPtoUeGR'])
            .map((e) => ListRptProspekBPtoUeGR.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptProspekBPtoUeGR'] =
        listRptProspekBPtoUeGR!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptProspekBPtoUeGR {
  ListRptProspekBPtoUeGR({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerName,
    required this.headerCode,
    required this.ueBP,
    required this.prospek,
    required this.ueGRLcl,
    required this.ueGR,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerName;
  late final String headerCode;
  late final int ueBP;
  late final int prospek;
  late final int ueGRLcl;
  late final int ueGR;

  ListRptProspekBPtoUeGR.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerName = json['headerName'];
    headerCode = json['headerCode'];
    ueBP = json['ueBP'];
    prospek = json['prospek'];
    ueGRLcl = json['ueGRLcl'];
    ueGR = json['ueGR'];
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
    _data['ueBP'] = ueBP;
    _data['prospek'] = prospek;
    _data['ueGRLcl'] = ueGRLcl;
    _data['ueGR'] = ueGR;
    return _data;
  }
}
