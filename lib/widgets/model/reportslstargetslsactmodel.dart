// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptTSalesActualResponse {
  ListRptTSalesActualResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptTSalesActual,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptTSalesActual>? listRptTSalesActual;

  ListRptTSalesActualResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptTSalesActual = (json['listRptTSalesActual'] != null)
        ? List.from(json['listRptTSalesActual'])
            .map((e) => ListRptTSalesActual.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptTSalesActual'] =
        listRptTSalesActual!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptTSalesActual {
  ListRptTSalesActual({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerCode2,
    required this.headerName,
    required this.headerName2,
    required this.tCall,
    required this.call,
    required this.perCall,
    required this.tProspek,
    required this.prospek,
    required this.perProspek,
    required this.tHot,
    required this.hot,
    required this.perHot,
    required this.tSpk,
    required this.spk,
    required this.perSpk,
    required this.tDo,
    required this.dO,
    required this.perDo,
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
  late final int tCall;
  late final int call;
  late final int perCall;
  late final int tProspek;
  late final int prospek;
  late final int perProspek;
  late final int tHot;
  late final int hot;
  late final int perHot;
  late final int tSpk;
  late final int spk;
  late final int perSpk;
  late final int tDo;
  late final int dO;
  late final int perDo;
  late final String title;
  late final String tipe;

  ListRptTSalesActual.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerCode2 = json['headerCode2'];
    headerName = json['headerName'];
    headerName2 = json['headerName2'];
    tCall = json['tCall'];
    call = json['call'];
    perCall = json['perCall'];
    tProspek = json['tProspek'];
    prospek = json['prospek'];
    perProspek = json['perProspek'];
    tHot = json['tHot'];
    hot = json['hot'];
    perHot = json['perHot'];
    tSpk = json['tSpk'];
    spk = json['spk'];
    perSpk = json['perSpk'];
    tDo = json['tDo'];
    dO = json['dO'];
    perDo = json['perDo'];
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
    _data['tCall'] = tCall;
    _data['call'] = call;
    _data['perCall'] = perCall;
    _data['tProspek'] = tProspek;
    _data['prospek'] = prospek;
    _data['perProspek'] = perProspek;
    _data['tHot'] = tHot;
    _data['hot'] = hot;
    _data['perHot'] = perHot;
    _data['tSpk'] = tSpk;
    _data['spk'] = spk;
    _data['perSpk'] = perSpk;
    _data['tDo'] = tDo;
    _data['dO'] = dO;
    _data['perDo'] = perDo;
    _data['title'] = title;
    _data['tipe'] = tipe;
    return _data;
  }
}
