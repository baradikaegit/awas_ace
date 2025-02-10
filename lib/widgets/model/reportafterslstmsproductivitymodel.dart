// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptAfterSlsTMSPRoductivityResponse {
  ListRptAfterSlsTMSPRoductivityResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptTMSProductivity,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptTMSProductivity>? listRptTMSProductivity;

  ListRptAfterSlsTMSPRoductivityResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptTMSProductivity = (json['listRptTMSProductivity'] != null)
        ? List.from(json['listRptTMSProductivity'])
            .map((e) => ListRptTMSProductivity.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptTMSProductivity'] =
        listRptTMSProductivity!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptTMSProductivity {
  ListRptTMSProductivity({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.tms,
    required this.productivity,
    required this.persen,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final int tms;
  late final double? productivity;
  late final int persen;

  ListRptTMSProductivity.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    tms = json['tms'];
    productivity = json['productivity'];
    persen = json['persen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerCode'] = headerCode;
    _data['tms'] = tms;
    _data['productivity'] = productivity;
    _data['persen'] = persen;
    return _data;
  }
}
