// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListSVCCountResponse {
  ListSVCCountResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listSvcCount,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListSvcCount>? listSvcCount;

  ListSVCCountResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listSvcCount = (json['listSvcCount'] != null)
        ? List.from(json['listSvcCount'])
            .map((e) => ListSvcCount.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listSvcCount'] = listSvcCount!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListSvcCount {
  ListSvcCount({
    required this.tipe,
    required this.countSVC,
  });
  late final String tipe;
  late final String countSVC;

  ListSvcCount.fromJson(Map<String, dynamic> json) {
    tipe = json['tipe'];
    countSVC = json['countSVC'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tipe'] = tipe;
    _data['countSVC'] = countSVC;
    return _data;
  }
}
