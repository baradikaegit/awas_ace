// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListReminderResponse {
  ListReminderResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listReminder,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListReminder>? listReminder;

  ListReminderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listReminder = (json['listReminder'] != null)
        ? List.from(json['listReminder'])
            .map((e) => ListReminder.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listReminder'] = listReminder!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListReminder {
  ListReminder({
    required this.iD,
    required this.taskDateView,
    required this.taskView,
    required this.custName,
    required this.vtype,
    required this.policeNumber,
    required this.taskTypeName,
    required this.info,
    required this.statusName,
    required this.userBranch,
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
  late final String userBranch;

  ListReminder.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    taskDateView = json['taskDateView'];
    taskView = json['taskView'];
    custName = json['custName'];
    vtype = json['vtype'];
    policeNumber = json['policeNumber'];
    taskTypeName = json['taskTypeName'];
    info = json['info'];
    statusName = json['statusName'];
    userBranch = json['userBranch'];
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
    _data['userBranch'] = userBranch;
    return _data;
  }
}
