// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptFunnelingDetailResponse {
  ListRptFunnelingDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptFunnelingDetail,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptFunnelingDetail>? listRptFunnelingDetail;

  ListRptFunnelingDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptFunnelingDetail = (json['listRptFunnelingDetail'] != null)
        ? List.from(json['listRptFunnelingDetail'])
            .map((e) => ListRptFunnelingDetail.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptFunnelingDetail'] =
        listRptFunnelingDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptFunnelingDetail {
  ListRptFunnelingDetail({
    required this.num,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerName,
    required this.call,
    required this.prospek,
    required this.hot,
    required this.spk,
    required this.dO,
    required this.title,
    required this.userName,
    required this.ssName,
    required this.ssCode,
  });
  late final int num;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerName;
  late final int call;
  late final int prospek;
  late final int hot;
  late final int spk;
  late final int dO;
  late final String title;
  late final String userName;
  late final String ssName;
  late final String ssCode;

  ListRptFunnelingDetail.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    call = json['call'];
    prospek = json['prospek'];
    hot = json['hot'];
    spk = json['spk'];
    dO = json['dO'];
    title = json['title'];
    userName = json['userName'];
    ssName = json['ssName'];
    ssCode = json['ssCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['call'] = call;
    _data['prospek'] = prospek;
    _data['hot'] = hot;
    _data['spk'] = spk;
    _data['dO'] = dO;
    _data['title'] = title;
    _data['userName'] = userName;
    _data['ssName'] = ssName;
    _data['ssCode'] = ssCode;
    return _data;
  }
}
