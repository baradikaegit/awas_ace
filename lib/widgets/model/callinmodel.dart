// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListReferensiResponse {
  ListReferensiResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listCallin,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListCallin>? listCallin;

  ListReferensiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listCallin = (json['listCallin'] != null)
        ? List.from(json['listCallin'])
            .map((e) => ListCallin.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listCallin'] = listCallin!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListCallin {
  ListCallin({
    required this.referensiID,
    required this.code,
    required this.name,
    required this.callCustomerDetailID,
    required this.amount,
    required this.callDate,
    required this.callCustomerHeaderID,
    required this.branchBusinessUnitID,
    required this.salesmanHeaderID,
    required this.days,
    required this.type,
  });
  late final String referensiID;
  late final String code;
  late final String name;
  late final String callCustomerDetailID;
  late final String callDate;
  late final int amount;
  late final String callCustomerHeaderID;
  late final String branchBusinessUnitID;
  late final String salesmanHeaderID;
  late final int days;
  late final String type;

  ListCallin.fromJson(Map<String, dynamic> json) {
    referensiID = json['referensiID'];
    code = json['code'];
    name = json['name'];
    callCustomerDetailID = json['callCustomerDetailID'];
    callDate = json['callDate'];
    amount = json['amount'];
    callCustomerHeaderID = json['callCustomerHeaderID'];
    branchBusinessUnitID = json['branchBusinessUnitID'];
    salesmanHeaderID = json['salesmanHeaderID'];
    days = json['days'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['referensiID'] = referensiID;
    _data['code'] = code;
    _data['name'] = name;
    _data['callCustomerDetailID'] = callCustomerDetailID;
    _data['callDate'] = callDate;
    _data['amount'] = amount;
    _data['callCustomerHeaderID'] = callCustomerHeaderID;
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['salesmanHeaderID'] = salesmanHeaderID;
    _data['days'] = days;
    _data['type'] = type;
    return _data;
  }
}

//add call
class ListEntryCallin {
  ListEntryCallin({
    this.callCustomerHeaderID,
    this.branchBusinessUnitID,
    this.salesmanHeaderID,
    this.callDate,
  });

  late String? callCustomerHeaderID;
  late String? branchBusinessUnitID;
  late String? salesmanHeaderID;
  late String? callDate;

  ListEntryCallin.fromJson(Map<String, dynamic> djson) {
    callCustomerHeaderID = djson['callCustomerHeaderID'];
    branchBusinessUnitID = djson['branchBusinessUnitID'];
    salesmanHeaderID = djson['salesmanHeaderID'];
    callDate = djson['callDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['callCustomerHeaderID'] = callCustomerHeaderID;
    _data['branchBusinessUnitID'] = branchBusinessUnitID;
    _data['salesmanHeaderID'] = salesmanHeaderID;
    _data['callDate'] = callDate;

    return _data;
  }
}

class ListEntryCallinDetail {
  ListEntryCallinDetail({
    this.callCustomerHeaderID2,
    this.referensiID,
    this.amount,
  });

  late String? callCustomerHeaderID2;
  late String? referensiID;
  late int? amount;

  ListEntryCallinDetail.fromJson(Map<String, dynamic> djson) {
    callCustomerHeaderID2 = djson['callCustomerHeaderID2'];
    referensiID = djson['referensiID'];
    amount = djson['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['callCustomerHeaderID2'] = callCustomerHeaderID2;
    _data['referensiID'] = referensiID;
    _data['amount'] = amount;
    return _data;
  }
}

class CallResponse {
  CallResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListEntryCallin? data;

  CallResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListEntryCallin.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listCallin'] = data!.toJson();
    return _data;
  }
}

//update call
class ListUpdateCallin {
  ListUpdateCallin({
    this.iD,
    this.referensiID,
    this.amount,
  });

  late String? iD;
  late String? referensiID;
  late int? amount;

  ListUpdateCallin.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    referensiID = djson['referensiID'];
    amount = djson['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['referensiID'] = referensiID;
    _data['amount'] = amount;

    return _data;
  }
}

class UpdateCallResponse {
  UpdateCallResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListUpdateCallin? data;

  UpdateCallResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListUpdateCallin.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listCallin'] = data!.toJson();
    return _data;
  }
}
