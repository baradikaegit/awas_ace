// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListProspectDariBengkelDetailResponse {
  ListProspectDariBengkelDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectBengkelDetail,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectBengkelDetail>? listProspectBengkelDetail;

  ListProspectDariBengkelDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectBengkelDetail = (json['listProspectBengkelDetail'] != null)
        ? List.from(json['listProspectBengkelDetail'])
            .map((e) => ListProspectBengkelDetail.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectBengkelDetail'] =
        listProspectBengkelDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectBengkelDetail {
  ListProspectBengkelDetail({
    required this.iD,
    required this.taskStatusID,
    required this.taskType,
    required this.info,
    required this.vtype,
    required this.chassisNumber,
    required this.salesCode,
    required this.salesName,
    required this.ssCode,
    required this.ssName,
    required this.policeNumber,
    required this.custName,
    required this.custHomePhone,
    required this.custPhone,
    required this.driverName,
    required this.driverHomePhone,
    required this.driverPhone,
    required this.statusName,
  });
  late final String iD;
  late final String taskStatusID;
  late final String taskType;
  late final String info;
  late final String vtype;
  late final String chassisNumber;
  late final String salesCode;
  late final String salesName;
  late final String ssCode;
  late final String ssName;
  late final String policeNumber;
  late final String custName;
  late final String custHomePhone;
  late final String custPhone;
  late final String driverName;
  late final String driverHomePhone;
  late final String driverPhone;
  late final String statusName;

  ListProspectBengkelDetail.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    taskStatusID = json['taskStatusID'];
    taskType = json['taskType'];
    info = json['info'];
    vtype = json['vtype'];
    chassisNumber = json['chassisNumber'];
    salesCode = json['salesCode'];
    salesName = json['salesName'];
    ssCode = json['ssCode'];
    ssName = json['ssName'];
    policeNumber = json['policeNumber'];
    custName = json['custName'];
    custHomePhone = json['custHomePhone'];
    custPhone = json['custPhone'];
    driverName = json['driverName'];
    driverHomePhone = json['driverHomePhone'];
    driverPhone = json['driverPhone'];
    statusName = json['statusName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['taskStatusID'] = taskStatusID;
    _data['taskType'] = taskType;
    _data['info'] = info;
    _data['vtype'] = vtype;
    _data['chassisNumber'] = chassisNumber;
    _data['salesCode'] = salesCode;
    _data['salesName'] = salesName;
    _data['ssCode'] = ssCode;
    _data['ssName'] = ssName;
    _data['policeNumber'] = policeNumber;
    _data['custName'] = custName;
    _data['custHomePhone'] = custHomePhone;
    _data['custPhone'] = custPhone;
    _data['driverName'] = driverName;
    _data['driverHomePhone'] = driverHomePhone;
    _data['driverPhone'] = driverPhone;
    _data['statusName'] = statusName;
    return _data;
  }
}

//update prospect dari bengkel
class ListProspectbengkelUpdate {
  ListProspectbengkelUpdate({
    this.iD,
    this.taskStatusID,
    this.info,
  });

  late String? iD;
  late String? taskStatusID;
  late String? info;

  ListProspectbengkelUpdate.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    taskStatusID = djson['taskStatusID'];
    info = djson['info'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['taskStatusID'] = taskStatusID;
    _data['info'] = info;

    return _data;
  }
}

class UpdateProspectDariBengkelResponse {
  UpdateProspectDariBengkelResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListProspectbengkelUpdate? data;

  UpdateProspectDariBengkelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListProspectbengkelUpdate.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectbengkelUpdate'] = data!.toJson();
    return _data;
  }
}
