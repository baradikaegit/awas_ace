// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListProspectDariBengkelResponse {
  ListProspectDariBengkelResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectBengkel,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectBengkel>? listProspectBengkel;

  ListProspectDariBengkelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectBengkel = (json['listProspectBengkel'] != null)
        ? List.from(json['listProspectBengkel'])
            .map((e) => ListProspectBengkel.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectBengkel'] =
        listProspectBengkel!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectBengkel {
  ListProspectBengkel({
    required this.iD,
    required this.taskDateView,
    required this.taskView,
    required this.custName,
    required this.vtype,
    required this.policeNumber,
    required this.taskTypeName,
    required this.info,
    required this.statusName,
    required this.userName,
    required this.userBranch,
    required this.taskStatusACEID,
    required this.taskBranchID,
  });
  late final String iD;
  late final String taskDateView;
  late final String taskView;
  late final String custName;
  late final String vtype;
  late final String policeNumber;
  late final String taskTypeName;
  late final String info;
  late final String statusName;
  late final String userName;
  late final String userBranch;
  late final String taskStatusACEID;
  late final String taskBranchID;

  ListProspectBengkel.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    taskDateView = json['taskDateView'];
    taskView = json['taskView'];
    custName = json['custName'];
    vtype = json['vtype'];
    policeNumber = json['policeNumber'];
    taskTypeName = json['taskTypeName'];
    info = json['info'];
    statusName = json['statusName'];
    userName = json['userName'];
    userBranch = json['userBranch'];
    taskStatusACEID = json['taskStatusACEID'];
    taskBranchID = json['taskBranchID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['taskDateView'] = taskDateView;
    _data['taskView'] = taskView;
    _data['custName'] = custName;
    _data['vtype'] = vtype;
    _data['policeNumber'] = policeNumber;
    _data['taskTypeName'] = taskTypeName;
    _data['info'] = info;
    _data['statusName'] = statusName;
    _data['userName'] = userName;
    _data['userBranch'] = userBranch;
    _data['taskStatusACEID'] = taskStatusACEID;
    _data['taskBranchID'] = taskBranchID;
    return _data;
  }
}
