// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListSendTaskProspect {
  ListSendTaskProspect({
    this.iD,
    this.taskStatusACEID,
    this.taskView,
    this.taskBranchID,
    this.taskNote,
  });

  late String? iD;
  late String? taskStatusACEID;
  late String? taskView;
  late String? taskBranchID;
  late String? taskNote;

  ListSendTaskProspect.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    taskStatusACEID = djson['taskStatusACEID'];
    taskView = djson['taskView'];
    taskBranchID = djson['taskBranchID'];
    taskNote = djson['taskNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['taskStatusACEID'] = taskStatusACEID;
    _data['taskView'] = taskView;
    _data['taskBranchID'] = taskBranchID;
    _data['taskNote'] = taskNote;

    return _data;
  }
}

class SendTaskProspectResponse {
  SendTaskProspectResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListSendTaskProspect? data;

  SendTaskProspectResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListSendTaskProspect.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectUpdateSendTask'] = data!.toJson();
    return _data;
  }
}
