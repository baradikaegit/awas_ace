// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptProspekVsResponse {
  ListRptProspekVsResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptProspekSpk,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptProspekSpk>? listRptProspekSpk;

  ListRptProspekVsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptProspekSpk = (json['listRptProspekSpk'] != null)
        ? List.from(json['listRptProspekSpk'])
            .map((e) => ListRptProspekSpk.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptProspekSpk'] =
        listRptProspekSpk!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptProspekSpk {
  ListRptProspekSpk({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerCode2,
    required this.headerName,
    required this.headerName2,
    required this.prospek,
    required this.prospekValid,
    required this.spk,
    required this.dO,
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
  late final int prospek;
  late final int prospekValid;
  late final int spk;
  late final int dO;
  late final String title;
  late final String tipe;

  ListRptProspekSpk.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerCode2 = json['headerCode2'];
    headerName = json['headerName'];
    headerName2 = json['headerName2'];
    prospek = json['prospek'];
    prospekValid = json['prospekValid'];
    spk = json['spk'];
    dO = json['dO'];
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
    _data['prospek'] = prospek;
    _data['prospekValid'] = prospekValid;
    _data['spk'] = spk;
    _data['dO'] = dO;
    _data['title'] = title;
    _data['tipe'] = tipe;
    return _data;
  }
}
