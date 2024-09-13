// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptProspekUeBpResponse {
  ListRptProspekUeBpResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptProspekUeBp,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptProspekUeBp>? listRptProspekUeBp;

  ListRptProspekUeBpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptProspekUeBp = (json['listRptProspekUeBp'] != null)
        ? List.from(json['listRptProspekUeBp'])
            .map((e) => ListRptProspekUeBp.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptProspekUeBp'] =
        listRptProspekUeBp!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptProspekUeBp {
  ListRptProspekUeBp({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerCode2,
    required this.headerName,
    required this.headerName2,
    required this.prospekUeBp,
    required this.ueBp,
    required this.persen,
    required this.title,
    required this.tipe,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerCode2;
  late final String headerName;
  late final String headerName2;
  late final int prospekUeBp;
  late final int ueBp;
  late final int persen;
  late final String title;
  late final String tipe;

  ListRptProspekUeBp.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerCode2 = json['headerCode2'];
    headerName = json['headerName'];
    headerName2 = json['headerName2'];
    prospekUeBp = json['prospekUeBp'];
    ueBp = json['ueBp'];
    persen = json['persen'];
    title = json['title'];
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerCode'] = headerCode;
    _data['headerCode2'] = headerCode2;
    _data['headerName'] = headerName;
    _data['headerName2'] = headerName2;
    _data['prospekUeBp'] = prospekUeBp;
    _data['ueBp'] = ueBp;
    _data['persen'] = persen;
    _data['title'] = title;
    _data['tipe'] = tipe;
    return _data;
  }
}
