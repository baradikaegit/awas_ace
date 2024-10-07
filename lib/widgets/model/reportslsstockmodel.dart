// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptStockByModelResponse {
  ListRptStockByModelResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptStockByModel,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptStockByModel>? listRptStockByModel;

  ListRptStockByModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptStockByModel = (json['listRptStockByModel'] != null)
        ? List.from(json['listRptStockByModel'])
            .map((e) => ListRptStockByModel.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptStockByModel'] =
        listRptStockByModel!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptStockByModel {
  ListRptStockByModel({
    required this.num,
    required this.headerCode,
    required this.headerName,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.data4,
    required this.persentase,
    required this.umurTerlama,
    required this.title,
    required this.tipe,
    required this.linkCode,
  });
  late final int num;
  late final String headerCode;
  late final String headerName;
  late final int data1;
  late final int data2;
  late final int data3;
  late final int data4;
  late final String persentase;
  late final int umurTerlama;
  late final String title;
  late final String tipe;
  late final String linkCode;

  ListRptStockByModel.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    data1 = json['data1'];
    data2 = json['data2'];
    data3 = json['data3'];
    data4 = json['data4'];
    persentase = json['persentase'];
    umurTerlama = json['umurTerlama'];
    title = json['title'];
    tipe = json['tipe'];
    linkCode = json['linkCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['data1'] = data1;
    _data['data2'] = data2;
    _data['data3'] = data3;
    _data['data4'] = data4;
    _data['persentase'] = persentase;
    _data['umurTerlama'] = umurTerlama;
    _data['title'] = title;
    _data['tipe'] = tipe;
    _data['linkCode'] = linkCode;
    return _data;
  }
}
