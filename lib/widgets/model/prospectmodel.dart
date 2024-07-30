// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProspectListResponse {
  ProspectListResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectData,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectData> listProspectData;

  ProspectListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectData = List.from(json['listProspectData'])
        .map((e) => ListProspectData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectData'] =
        listProspectData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectData {
  ListProspectData({
    required this.dateContact,
    required this.meetingPoint,
    required this.postalCodeID,
    required this.ringArea,
    required this.referensiID,
    required this.rencanaPembelian,
    required this.branchBusinessID,
    required this.salesmanHeaderID,
    required this.prospectStatus,
    required this.customerName,
    required this.handphone1,
    required this.handphone2,
    required this.gender,
    required this.customerAddres,
    required this.postaclCodeACEID,
    required this.ringAreaACE,
    required this.email,
    required this.customerTypeID,
    required this.pekerjaan,
    required this.kisaranHargaID,
    required this.customerStatusID,
    required this.vehicleGroupID1,
    required this.vehicleYear1,
    required this.vehicleFuelID1,
    required this.transmisiVehicle1,
    required this.vehicleGroupID2,
    required this.vehicleYear2,
    required this.vehicleFuelID2,
    required this.transmisiVehicle2,
    required this.payment,
    required this.downPayment,
    required this.tenor,
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.q5,
    required this.q6,
    required this.trackingStatus,
    required this.trackingReason,
    required this.trackingInfo,
  });
  late final String dateContact;
  late final String meetingPoint;
  late final String postalCodeID;
  late final String ringArea;
  late final String referensiID;
  late final int? rencanaPembelian;
  late final String branchBusinessID;
  late final String salesmanHeaderID;
  late final int? prospectStatus;
  late final String customerName;
  late final String handphone1;
  late final String handphone2;
  late final int? gender;
  late final String customerAddres;
  late final String postaclCodeACEID;
  late final int? ringAreaACE;
  late final String email;
  late final String customerTypeID;
  late final String pekerjaan;
  late final String kisaranHargaID;
  late final String customerStatusID;
  late final String vehicleGroupID1;
  late final String vehicleYear1;
  late final String vehicleFuelID1;
  late final String transmisiVehicle1;
  late final String vehicleGroupID2;
  late final String vehicleYear2;
  late final String vehicleFuelID2;
  late final String transmisiVehicle2;
  late final String payment;
  late final String downPayment;
  late final String tenor;
  late final int? q1;
  late final int? q2;
  late final int? q3;
  late final int? q4;
  late final int? q5;
  late final int? q6;
  late final int? trackingStatus;
  late final int? trackingReason;
  late final String trackingInfo;

  ListProspectData.fromJson(Map<String, dynamic> json) {
    dateContact = json['dateContact'];
    meetingPoint = json['meetingPoint'];
    postalCodeID = json['postalCodeID'];
    ringArea = json['ringArea'];
    referensiID = json['referensiID'];
    rencanaPembelian = json['rencanaPembelian'];
    branchBusinessID = json['branchBusinessID'];
    salesmanHeaderID = json['salesmanHeaderID'];
    prospectStatus = json['prospectStatus'];
    customerName = json['customerName'];
    handphone1 = json['handphone1'];
    handphone2 = json['handphone2'];
    gender = json['gender'];
    customerAddres = json['customerAddres'];
    postaclCodeACEID = json['postaclCodeACEID'];
    ringAreaACE = json['ringAreaACE'];
    email = json['email'];
    customerTypeID = json['customerTypeID'];
    pekerjaan = json['pekerjaan'];
    kisaranHargaID = json['kisaranHargaID'];
    customerStatusID = json['customerStatusID'];
    vehicleGroupID1 = json['vehicleGroupID1'];
    vehicleYear1 = json['vehicleYear1'];
    vehicleFuelID1 = json['vehicleFuelID1'];
    transmisiVehicle1 = json['transmisiVehicle1'];
    vehicleGroupID2 = json['vehicleGroupID2'];
    vehicleYear2 = json['vehicleYear2'];
    vehicleFuelID2 = json['vehicleFuelID2'];
    transmisiVehicle2 = json['transmisiVehicle2'];
    payment = json['payment'];
    downPayment = json['downPayment'];
    tenor = json['tenor'];
    q1 = json['q1'];
    q2 = json['q2'];
    q3 = json['q3'];
    q4 = json['q4'];
    q5 = json['q5'];
    q6 = json['q6'];
    trackingStatus = json['trackingStatus'];
    trackingReason = json['trackingReason'];
    trackingInfo = json['trackingInfo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dateContact'] = dateContact;
    _data['meetingPoint'] = meetingPoint;
    _data['postalCodeID'] = postalCodeID;
    _data['ringArea'] = ringArea;
    _data['referensiID'] = referensiID;
    _data['rencanaPembelian'] = rencanaPembelian;
    _data['branchBusinessID'] = branchBusinessID;
    _data['salesmanHeaderID'] = salesmanHeaderID;
    _data['prospectStatus'] = prospectStatus;
    _data['customerName'] = customerName;
    _data['handphone1'] = handphone1;
    _data['handphone2'] = handphone2;
    _data['gender'] = gender;
    _data['customerAddres'] = customerAddres;
    _data['postaclCodeACEID'] = postaclCodeACEID;
    _data['ringAreaACE'] = ringAreaACE;
    _data['email'] = email;
    _data['customerTypeID'] = customerTypeID;
    _data['pekerjaan'] = pekerjaan;
    _data['kisaranHargaID'] = kisaranHargaID;
    _data['customerStatusID'] = customerStatusID;
    _data['vehicleGroupID1'] = vehicleGroupID1;
    _data['vehicleYear1'] = vehicleYear1;
    _data['vehicleFuelID1'] = vehicleFuelID1;
    _data['transmisiVehicle1'] = transmisiVehicle1;
    _data['vehicleGroupID2'] = vehicleGroupID2;
    _data['vehicleYear2'] = vehicleYear2;
    _data['vehicleFuelID2'] = vehicleFuelID2;
    _data['transmisiVehicle2'] = transmisiVehicle2;
    _data['payment'] = payment;
    _data['downPayment'] = downPayment;
    _data['tenor'] = tenor;
    _data['q1'] = q1;
    _data['q2'] = q2;
    _data['q3'] = q3;
    _data['q4'] = q4;
    _data['q5'] = q5;
    _data['q6'] = q6;
    _data['trackingStatus'] = trackingStatus;
    _data['trackingReason'] = trackingReason;
    _data['trackingInfo'] = trackingInfo;
    return _data;
  }
}

//add prospect

class ProspectResponse {
  ProspectResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });
  late final int statusCode;
  late final String statusMessage;
  late final ListProspectData? data;

  ProspectResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage']!;
    data = (json['data'] != null)
        ? ListProspectData.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listregistration'] = data!.toJson();
    return _data;
  }
}
