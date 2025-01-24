// ignore_for_file: no_leading_underscores_for_local_identifiers

class ListProspectUpdateResponse {
  ListProspectUpdateResponse({
    this.prospectHId,
    this.prospectCode,
    this.dateContact,
    this.meetingPoint,
    this.postalCodeID,
    this.ringArea,
    this.referensiID,
    this.rencanaPembelian,
    this.prospectStatus,
    this.customerName,
    this.handphone1,
    this.handphone2,
    this.gender,
    this.customerAddres,
    this.postaclCodeACEID,
    this.ringAreaACE,
    this.email,
    this.customerTypeID,
    this.pekerjaan,
    this.kisaranHargaID,
    this.customerStatusID,
    this.vehicleGroupID1,
    this.vehicleYear1,
    this.vehicleFuelID1,
    this.transmisiVehicle1,
    this.vehicleGroupID2,
    this.vehicleYear2,
    this.vehicleFuelID2,
    this.transmisiVehicle2,
    this.payment,
    this.downPayment,
    this.tenor,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.q5,
    this.q6,
    this.trackingStatus,
    this.trackingReason,
    this.trackingInfo,
  });
  late String? prospectHId;
  late String? prospectCode;
  late String? dateContact;
  late String? meetingPoint;
  late String? postalCodeID;
  late String? ringArea;
  late String? referensiID;
  late int? rencanaPembelian;
  late int? prospectStatus;
  late String? customerName;
  late String? handphone1;
  late String? handphone2;
  late int? gender;
  late String? customerAddres;
  late String? postaclCodeACEID;
  late int? ringAreaACE;
  late String? email;
  late String? customerTypeID;
  late String? pekerjaan;
  late String? kisaranHargaID;
  late String? customerStatusID;
  late String? vehicleGroupID1;
  late String? vehicleYear1;
  late String? vehicleFuelID1;
  late String? transmisiVehicle1;
  late String? vehicleGroupID2;
  late String? vehicleYear2;
  late String? vehicleFuelID2;
  late String? transmisiVehicle2;
  late String? payment;
  late String? downPayment;
  late String? tenor;
  late int? q1;
  late int? q2;
  late int? q3;
  late int? q4;
  late int? q5;
  late int? q6;
  late int? trackingStatus;
  late int? trackingReason;
  late String? trackingInfo;

  ListProspectUpdateResponse.fromJson(Map<String, dynamic> djson) {
    prospectHId = djson['prospectHId'];
    prospectCode = djson['prospectCode'];
    dateContact = djson['dateContact'];
    meetingPoint = djson['meetingPoint'];
    postalCodeID = djson['postalCodeID'];
    ringArea = djson['ringArea'];
    referensiID = djson['referensiID'];
    rencanaPembelian = djson['rencanaPembelian'];
    prospectStatus = djson['prospectStatus'];
    customerName = djson['customerName'];
    handphone1 = djson['handphone1'];
    handphone2 = djson['handphone2'];
    gender = djson['gender'];
    customerAddres = djson['customerAddres'];
    postaclCodeACEID = djson['postaclCodeACEID'];
    ringAreaACE = djson['ringAreaACE'];
    email = djson['email'];
    customerTypeID = djson['customerTypeID'];
    pekerjaan = djson['pekerjaan'];
    kisaranHargaID = djson['kisaranHargaID'];
    customerStatusID = djson['customerStatusID'];
    vehicleGroupID1 = djson['vehicleGroupID1'];
    vehicleYear1 = djson['vehicleYear1'];
    vehicleFuelID1 = djson['vehicleFuelID1'];
    transmisiVehicle1 = djson['transmisiVehicle1'];
    vehicleGroupID2 = djson['vehicleGroupID2'];
    vehicleYear2 = djson['vehicleYear2'];
    vehicleFuelID2 = djson['vehicleFuelID2'];
    transmisiVehicle2 = djson['transmisiVehicle2'];
    payment = djson['payment'];
    downPayment = djson['downPayment'];
    tenor = djson['tenor'];
    q1 = djson['q1'];
    q2 = djson['q2'];
    q3 = djson['q3'];
    q4 = djson['q4'];
    q5 = djson['q5'];
    q6 = djson['q6'];
    trackingStatus = djson['trackingStatus'];
    trackingReason = djson['trackingReason'];
    trackingInfo = djson['trackingInfo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prospectHId'] = prospectHId;
    _data['prospectCode'] = prospectCode;
    _data['dateContact'] = dateContact;
    _data['meetingPoint'] = meetingPoint;
    _data['postalCodeID'] = postalCodeID;
    _data['ringArea'] = ringArea;
    _data['referensiID'] = referensiID;
    _data['rencanaPembelian'] = rencanaPembelian;
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

class UpdateProspectResponse {
  UpdateProspectResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListProspectUpdateResponse? data;

  UpdateProspectResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListProspectUpdateResponse.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectSalesUpdate'] = data!.toJson();
    return _data;
  }
}
