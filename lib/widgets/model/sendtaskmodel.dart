// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListSendTask {
  ListSendTask({
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

  //print objek data
  /* @override
  String toString() {
    return 'ListSendTask(iD: $iD, taskStatusID: $taskStatusACEID, taskView : $taskView, taskNote: $taskNote, branch: $taskBranchID)';
  } */

  ListSendTask.fromJson(Map<String, dynamic> djson) {
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

class SendTaskResponse {
  SendTaskResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListSendTask? data;

  SendTaskResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data =
        (json['data'] != null) ? ListSendTask.fromJson(json['data'][0]) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listReminderUpdateSendTask'] = data!.toJson();
    return _data;
  }
}
