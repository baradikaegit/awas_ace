// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptSalesBocCaiBySalesResponse {
  ListRptSalesBocCaiBySalesResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listBocCaiBySales,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListBocCaiBySales>? listBocCaiBySales;

  ListRptSalesBocCaiBySalesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listBocCaiBySales = (json['listBocCaiBySales'] != null)
        ? List.from(json['listBocCaiBySales'])
            .map((e) => ListBocCaiBySales.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listBocCaiBySales'] =
        listBocCaiBySales!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListBocCaiBySales {
  ListBocCaiBySales({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.tipeCode,
    required this.headerCode,
    required this.headerName,
    required this.data1,
    required this.contacted,
    required this.boc,
    required this.cai,
    required this.persenContacted,
    required this.persenBoc,
    required this.persenCai,
    required this.title,
    required this.linkPage,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String tipeCode;
  late final String headerCode;
  late final String headerName;
  late final int data1;
  late final int contacted;
  late final int boc;
  late final int cai;
  late final int persenContacted;
  late final int persenBoc;
  late final int persenCai;
  late final String title;
  late final String linkPage;

  ListBocCaiBySales.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    tipeCode = json['tipeCode'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    data1 = json['data1'];
    contacted = json['contacted'];
    boc = json['boc'];
    cai = json['cai'];
    persenContacted = json['persenContacted'];
    persenBoc = json['persenBoc'];
    persenCai = json['persenCai'];
    title = json['title'];
    linkPage = json['linkPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['tipeCode'] = tipeCode;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['data1'] = data1;
    _data['contacted'] = contacted;
    _data['boc'] = boc;
    _data['cai'] = cai;
    _data['persenContacted'] = persenContacted;
    _data['persenBoc'] = persenBoc;
    _data['persenCai'] = persenCai;
    _data['title'] = title;
    _data['linkPage'] = linkPage;
    return _data;
  }
}
