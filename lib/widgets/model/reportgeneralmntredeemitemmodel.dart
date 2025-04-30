// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptGeneralMntRedeemItemResponse {
  ListRptGeneralMntRedeemItemResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptGeneralMonitoringRedeemItem,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptGeneralMonitoringRedeemItem>?
      listRptGeneralMonitoringRedeemItem;

  ListRptGeneralMntRedeemItemResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptGeneralMonitoringRedeemItem =
        (json['listRptGeneralMonitoringRedeemItem'] != null)
            ? List.from(json['listRptGeneralMonitoringRedeemItem'])
                .map((e) => ListRptGeneralMonitoringRedeemItem.fromJson(e))
                .toList()
            : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptGeneralMonitoringRedeemItem'] =
        listRptGeneralMonitoringRedeemItem!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptGeneralMonitoringRedeemItem {
  ListRptGeneralMonitoringRedeemItem({
    required this.iD,
    required this.title,
    required this.description,
    required this.poinIDR,
    required this.poin,
    required this.images,
  });
  late final String iD;
  late final String title;
  late final String description;
  late final String poinIDR;
  late final int poin;
  late final String images;

  ListRptGeneralMonitoringRedeemItem.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    title = json['title'];
    description = json['description'];
    poinIDR = json['poinIDR'];
    poin = json['poin'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['title'] = title;
    _data['description'] = description;
    _data['poinIDR'] = poinIDR;
    _data['poin'] = poin;
    _data['images'] = images;
    return _data;
  }
}

//add entry redeem poin
class ListEntryRedeemPoin {
  ListEntryRedeemPoin({
    this.redeemItemID,
    this.poin,
    this.title,
  });

  late String? redeemItemID;
  late int? poin;
  late String? title;

  ListEntryRedeemPoin.fromJson(Map<String, dynamic> djson) {
    redeemItemID = djson['redeemItemID'];
    poin = djson['poin'];
    title = djson['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['redeemItemID'] = redeemItemID;
    _data['poin'] = poin;
    _data['title'] = title;

    return _data;
  }

  //print
  // @override
  // String toString() {
  //   return 'ListEntryRedeemPoin(redeemItemID: $redeemItemID, poin: $poin, title: $title)';
  // }
}

class EntryRedeemPoinResponse {
  EntryRedeemPoinResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListEntryRedeemPoin? data;

  EntryRedeemPoinResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListEntryRedeemPoin.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRedeemPoin'] = data!.toJson();
    return _data;
  }
}
