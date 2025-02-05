// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptBodyPaintProspekSaBPResponse {
  ListRptBodyPaintProspekSaBPResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptProspekSaBP,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptProspekSaBP>? listRptProspekSaBP;

  ListRptBodyPaintProspekSaBPResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptProspekSaBP = (json['listRptProspekSaBP'] != null)
        ? List.from(json['listRptProspekSaBP'])
            .map((e) => ListRptProspekSaBP.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptProspekSaBP'] =
        listRptProspekSaBP!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptProspekSaBP {
  ListRptProspekSaBP({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerName,
    required this.headerCode,
    required this.validAll,
    required this.validSA,
    required this.prospekAll,
    required this.prospekSA,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerName;
  late final String headerCode;
  late final int validAll;
  late final int validSA;
  late final int prospekAll;
  late final int prospekSA;

  ListRptProspekSaBP.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerName = json['headerName'];
    headerCode = json['headerCode'];
    validAll = json['validAll'];
    validSA = json['validSA'];
    prospekAll = json['prospekAll'];
    prospekSA = json['prospekSA'];
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
    _data['validAll'] = validAll;
    _data['validSA'] = validSA;
    _data['prospekAll'] = prospekAll;
    _data['prospekSA'] = prospekSA;
    return _data;
  }
}
