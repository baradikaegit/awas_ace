// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
import 'dart:convert';

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
    required this.countTaskDetail,
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
  late final List<CountTaskDetail>? countTaskDetail;

  ListProspectBengkelDetail.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    taskStatusID = djson['taskStatusID'];
    taskType = djson['taskType'];
    info = djson['info'];
    vtype = djson['vtype'];
    chassisNumber = djson['chassisNumber'];
    salesCode = djson['salesCode'];
    salesName = djson['salesName'];
    ssCode = djson['ssCode'];
    ssName = djson['ssName'];
    policeNumber = djson['policeNumber'];
    custName = djson['custName'];
    custHomePhone = djson['custHomePhone'];
    custPhone = djson['custPhone'];
    driverName = djson['driverName'];
    driverHomePhone = djson['driverHomePhone'];
    driverPhone = djson['driverPhone'];
    statusName = djson['statusName'];
    countTaskDetail = (djson['countTaskDetail'] != "")
        ? List.from(json.decode(djson['countTaskDetail']))
            .map((e) => CountTaskDetail.fromJson(e))
            .toList()
        : null;
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
    _data['countTaskDetail'] = countTaskDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CountTaskDetail {
  CountTaskDetail({
    required this.Rn,
    required this.CreatedDate,
    required this.Name,
    required this.TaskNote,
  });
  late final int Rn;
  late final String CreatedDate;
  late final String Name;
  late final String TaskNote;

  CountTaskDetail.fromJson(Map<String, dynamic> json) {
    Rn = json['Rn'];
    CreatedDate = json['CreatedDate'];
    Name = json['Name'];
    TaskNote = json['TaskNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Rn'] = Rn;
    _data['CreatedDate'] = CreatedDate;
    _data['Name'] = Name;
    _data['TaskNote'] = TaskNote;
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
