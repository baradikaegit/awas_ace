// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
import 'dart:convert';

class ListSvcKendaraanDetailResponse {
  ListSvcKendaraanDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listSvcKendaraanDetail,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListSvcKendaraanDetail>? listSvcKendaraanDetail;

  ListSvcKendaraanDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listSvcKendaraanDetail = (json['listSvcKendaraanDetail'] != null)
        ? List.from(json['listSvcKendaraanDetail'])
            .map((e) => ListSvcKendaraanDetail.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listSvcKendaraanDetail'] =
        listSvcKendaraanDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListSvcKendaraanDetail {
  ListSvcKendaraanDetail({
    required this.iD,
    required this.taskStatusID,
    required this.taskType,
    required this.taskDateView,
    required this.info,
    required this.usernameSA,
    required this.usernameSAName,
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
    required this.vColor,
    required this.year,
    required this.bookingDate,
    required this.branchBusinessUnitBookingID,
    required this.branchBusinessUnitBooking,
    required this.lastService,
    required this.lastServiceDate,
    required this.countTaskDetail,
  });
  late final String iD;
  late final String taskStatusID;
  late final String taskType;
  late final String taskDateView;
  late final String info;
  late final String usernameSA;
  late final String usernameSAName;
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
  late final String vColor;
  late final String year;
  late final String bookingDate;
  late final String branchBusinessUnitBookingID;
  late final String branchBusinessUnitBooking;
  late final String lastService;
  late final String lastServiceDate;
  late final List<CountTaskDetail>? countTaskDetail;

  ListSvcKendaraanDetail.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    taskStatusID = djson['taskStatusID'];
    taskType = djson['taskType'];
    taskDateView = djson['taskDateView'];
    info = djson['info'];
    usernameSA = djson['usernameSA'];
    usernameSAName = djson['usernameSAName'];
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
    vColor = djson['vColor'];
    year = djson['year'];
    bookingDate = djson['bookingDate'];
    branchBusinessUnitBookingID = djson['branchBusinessUnitBookingID'];
    branchBusinessUnitBooking = djson['branchBusinessUnitBooking'];
    lastService = djson['lastService'];
    lastServiceDate = djson['lastServiceDate'];
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
    _data['taskDateView'] = taskDateView;
    _data['info'] = info;
    _data['usernameSA'] = usernameSA;
    _data['usernameSAName'] = usernameSAName;
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
    _data['vColor'] = vColor;
    _data['year'] = year;
    _data['lastService'] = lastService;
    _data['lastServiceDate'] = lastServiceDate;
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

//update svc kendaraan
class ListSvcKendaraanUpdate {
  ListSvcKendaraanUpdate(
      {this.iD,
      this.taskStatusID,
      this.taskNote,
      this.branchBussinessUnitBookingID,
      this.bookingDate});

  late String? iD;
  late String? taskStatusID;
  late String? taskNote;
  late String? branchBussinessUnitBookingID;
  late String? bookingDate;

  //print objek data
/*   @override
  String toString() {
    return 'ListSvcKendaraanUpdate(iD: $iD, taskStatusID: $taskStatusID, taskNote: $taskNote, branchBussinessUnitBookingID: $branchBussinessUnitBookingID, bookingDate: $bookingDate)';
  } */

  ListSvcKendaraanUpdate.fromJson(Map<String, dynamic> djson) {
    iD = djson['iD'];
    taskStatusID = djson['taskStatusID'];
    taskNote = djson['taskNote'];
    branchBussinessUnitBookingID = djson['branchBussinessUnitBookingID'];
    bookingDate = djson['bookingDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iD'] = iD;
    _data['taskStatusID'] = taskStatusID;
    _data['taskNote'] = taskNote;
    _data['branchBussinessUnitBookingID'] = branchBussinessUnitBookingID;
    _data['bookingDate'] = bookingDate;

    return _data;
  }
}

class UpdateSvcKendaraanResponse {
  UpdateSvcKendaraanResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListSvcKendaraanUpdate? data;

  UpdateSvcKendaraanResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListSvcKendaraanUpdate.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listSvcKendaraanUpdate'] = data!.toJson();
    return _data;
  }
}
