// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProspectSalesListResponse {
  ProspectSalesListResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectSales,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectSales>? listProspectSales;

  ProspectSalesListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectSales = (json['listProspectSales'] != null)
        ? List.from(json['listProspectSales'])
            .map((e) => ListProspectSales.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectSales'] =
        listProspectSales!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectSales {
  ListProspectSales({
    required this.iD,
    required this.branch,
    required this.prospectCode,
    required this.prospectDate,
    required this.salesCode,
    required this.salesman,
    required this.prospectStatus,
    required this.prospectStatusName,
    required this.meetingPoint,
    required this.codeRef,
    required this.referensi,
    required this.customerCode,
    required this.customerName,
    required this.type,
  });
  late final String iD;
  late final String branch;
  late final String prospectCode;
  late final String prospectDate;
  late final String salesCode;
  late final String salesman;
  late final String prospectStatus;
  late final String prospectStatusName;
  late final String meetingPoint;
  late final String codeRef;
  late final String referensi;
  late final String customerCode;
  late final String customerName;
  late final String type;

  ListProspectSales.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    branch = json['branch'];
    prospectCode = json['prospectCode'];
    prospectDate = json['prospectDate'];
    salesCode = json['salesCode'];
    salesman = json['salesman'];
    prospectStatus = json['prospectStatus'];
    prospectStatusName = json['prospectStatusName'];
    meetingPoint = json['meetingPoint'];
    codeRef = json['codeRef'];
    referensi = json['referensi'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['branch'] = branch;
    _data['prospectCode'] = prospectCode;
    _data['prospectDate'] = prospectDate;
    _data['salesCode'] = salesCode;
    _data['salesman'] = salesman;
    _data['prospectStatus'] = prospectStatus;
    _data['prospectStatusName'] = prospectStatusName;
    _data['meetingPoint'] = meetingPoint;
    _data['codeRef'] = codeRef;
    _data['referensi'] = referensi;
    _data['customerCode'] = customerCode;
    _data['customerName'] = customerName;
    _data['type'] = type;
    return _data;
  }
}
