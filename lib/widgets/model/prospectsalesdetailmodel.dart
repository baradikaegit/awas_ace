// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProspectSalesDetailResponse {
  ProspectSalesDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listProspectSalesDetail,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListProspectSalesDetail>? listProspectSalesDetail;

  ProspectSalesDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listProspectSalesDetail = (json['listProspectSalesDetail'] != null)
        ? List.from(json['listProspectSalesDetail'])
            .map((e) => ListProspectSalesDetail.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProspectSalesDetail'] =
        listProspectSalesDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProspectSalesDetail {
  ListProspectSalesDetail({
    required this.iD,
    required this.branch,
    required this.prospectCode,
    required this.prospectDate,
    required this.salesCode,
    required this.salesman,
    required this.prospectStatus,
    required this.trackingStatus,
    required this.trackingReason,
    required this.trackingInfo,
    required this.dateContact,
    required this.meetingPoint,
    required this.referensiId,
    required this.codeRef,
    required this.referensi,
    required this.rencanaPembelian,
    required this.ringArea,
    required this.ringKet,
    required this.postalCodeId,
    required this.postalCode,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.custCode,
    required this.customerName,
    required this.handphone1,
    required this.handphone2,
    required this.gender,
    required this.email,
    required this.pekerjaan,
    required this.customerAddres,
    required this.postalCodeId2,
    required this.postalCode2,
    required this.kelurahan2,
    required this.kecamatan2,
    required this.kota2,
    required this.provinsi2,
    required this.area,
    required this.ringKet2,
    required this.vgroup1Id,
    required this.vgCode1,
    required this.vgroup1,
    required this.vehicleYear1,
    required this.vehicleFuel1Id,
    required this.vehicleFuel1,
    required this.transmisiV1Id,
    required this.transmisiV1,
    required this.vgroup2Id,
    required this.vgCode2,
    required this.vgroup2,
    required this.vehicleYear2,
    required this.vehicleFuel2Id,
    required this.vehicleFuel2,
    required this.transmisiV2Id,
    required this.transmisiV2,
    required this.payment,
    required this.downPayment,
    required this.tenor,
    required this.kisaranHargaId,
    required this.kisaranHarga,
    required this.custTypeId,
    required this.customerType,
    required this.customerVal,
    required this.custStatusId,
    required this.customerStatus,
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.q5,
    required this.q6,
  });
  late final String iD;
  late final String branch;
  late final String prospectCode;
  late final String prospectDate;
  late final String salesCode;
  late final String salesman;
  late final int prospectStatus;
  late final int trackingStatus;
  late final int trackingReason;
  late final String trackingInfo;
  late final String dateContact;
  late final String meetingPoint;
  late final String referensiId;
  late final String codeRef;
  late final String referensi;
  late final int rencanaPembelian;
  late final int ringArea;
  late final String ringKet;
  late final String postalCodeId;
  late final String postalCode;
  late final String kelurahan;
  late final String kecamatan;
  late final String kota;
  late final String provinsi;
  late final String custCode;
  late final String customerName;
  late final String handphone1;
  late final String handphone2;
  late final int gender;
  late final String email;
  late final String pekerjaan;
  late final String customerAddres;
  late final String postalCodeId2;
  late final String postalCode2;
  late final String kelurahan2;
  late final String kecamatan2;
  late final String kota2;
  late final String provinsi2;
  late final int area;
  late final String ringKet2;
  late final String vgroup1Id;
  late final String vgCode1;
  late final String vgroup1;
  late final String vehicleYear1;
  late final String vehicleFuel1Id;
  late final String vehicleFuel1;
  late final String transmisiV1Id;
  late final String transmisiV1;
  late final String vgroup2Id;
  late final String vgCode2;
  late final String vgroup2;
  late final String vehicleYear2;
  late final String vehicleFuel2Id;
  late final String vehicleFuel2;
  late final String transmisiV2Id;
  late final String transmisiV2;
  late final String payment;
  late final String downPayment;
  late final String tenor;
  late final String kisaranHargaId;
  late final String kisaranHarga;
  late final String custTypeId;
  late final String customerType;
  late final int customerVal;
  late final String custStatusId;
  late final String customerStatus;
  late final String q1;
  late final String q2;
  late final String q3;
  late final String q4;
  late final String q5;
  late final String q6;

  ListProspectSalesDetail.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    branch = json['branch'];
    prospectCode = json['prospectCode'];
    prospectDate = json['prospectDate'];
    salesCode = json['salesCode'];
    salesman = json['salesman'];
    prospectStatus = json['prospectStatus'];
    trackingStatus = json['trackingStatus'];
    trackingReason = json['trackingReason'];
    trackingInfo = json['trackingInfo'];
    dateContact = json['dateContact'];
    meetingPoint = json['meetingPoint'];
    referensiId = json['referensiId'];
    codeRef = json['codeRef'];
    referensi = json['referensi'];
    rencanaPembelian = json['rencanaPembelian'];
    ringArea = json['ringArea'];
    ringKet = json['ringKet'];
    postalCodeId = json['postalCodeId'];
    postalCode = json['postalCode'];
    kelurahan = json['kelurahan'];
    kecamatan = json['kecamatan'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    custCode = json['custCode'];
    customerName = json['customerName'];
    handphone1 = json['handphone1'];
    handphone2 = json['handphone2'];
    gender = json['gender'];
    email = json['email'];
    pekerjaan = json['pekerjaan'];
    customerAddres = json['customerAddres'];
    postalCodeId2 = json['postalCodeId2'];
    postalCode2 = json['postalCode2'];
    kelurahan2 = json['kelurahan2'];
    kecamatan2 = json['kecamatan2'];
    kota2 = json['kota2'];
    provinsi2 = json['provinsi2'];
    area = json['area'];
    ringKet2 = json['ringKet2'];
    vgroup1Id = json['vgroup1Id'];
    vgCode1 = json['vgCode1'];
    vgroup1 = json['vgroup1'];
    vehicleYear1 = json['vehicleYear1'];
    vehicleFuel1Id = json['vehicleFuel1Id'];
    vehicleFuel1 = json['vehicleFuel1'];
    transmisiV1Id = json['transmisiV1Id'];
    transmisiV1 = json['transmisiV1'];
    vgroup2Id = json['vgroup2Id'];
    vgCode2 = json['vgCode2'];
    vgroup2 = json['vgroup2'];
    vehicleYear2 = json['vehicleYear2'];
    vehicleFuel2Id = json['vehicleFuel2Id'];
    vehicleFuel2 = json['vehicleFuel2'];
    transmisiV2Id = json['transmisiV2Id'];
    transmisiV2 = json['transmisiV2'];
    payment = json['payment'];
    downPayment = json['downPayment'];
    tenor = json['tenor'];
    kisaranHargaId = json['kisaranHargaId'];
    kisaranHarga = json['kisaranHarga'];
    custTypeId = json['custTypeId'];
    customerType = json['customerType'];
    customerVal = json['customerVal'];
    custStatusId = json['custStatusId'];
    customerStatus = json['customerStatus'];
    q1 = json['q1'];
    q2 = json['q2'];
    q3 = json['q3'];
    q4 = json['q4'];
    q5 = json['q5'];
    q6 = json['q6'];
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
    _data['trackingStatus'] = trackingStatus;
    _data['trackingReason'] = trackingReason;
    _data['trackingInfo'] = trackingInfo;
    _data['dateContact'] = dateContact;
    _data['meetingPoint'] = meetingPoint;
    _data['referensiId'] = referensiId;
    _data['codeRef'] = codeRef;
    _data['referensi'] = referensi;
    _data['rencanaPembelian'] = rencanaPembelian;
    _data['ringArea'] = ringArea;
    _data['ringKet'] = ringKet;
    _data['postalCodeId'] = postalCodeId;
    _data['postalCode'] = postalCode;
    _data['kelurahan'] = kelurahan;
    _data['kecamatan'] = kecamatan;
    _data['kota'] = kota;
    _data['provinsi'] = provinsi;
    _data['custCode'] = custCode;
    _data['customerName'] = customerName;
    _data['handphone1'] = handphone1;
    _data['handphone2'] = handphone2;
    _data['gender'] = gender;
    _data['email'] = email;
    _data['pekerjaan'] = pekerjaan;
    _data['customerAddres'] = customerAddres;
    _data['postalCodeId2'] = postalCodeId2;
    _data['postalCode2'] = postalCode2;
    _data['kelurahan2'] = kelurahan2;
    _data['kecamatan2'] = kecamatan2;
    _data['kota2'] = kota2;
    _data['provinsi2'] = provinsi2;
    _data['area'] = area;
    _data['ringKet2'] = ringKet2;
    _data['vgroup1Id'] = vgroup1Id;
    _data['vgCode1'] = vgCode1;
    _data['vgroup1'] = vgroup1;
    _data['vehicleYear1'] = vehicleYear1;
    _data['vehicleFuel1Id'] = vehicleFuel1Id;
    _data['vehicleFuel1'] = vehicleFuel1;
    _data['transmisiV1Id'] = transmisiV1Id;
    _data['transmisiV1'] = transmisiV1;
    _data['vgroup2Id'] = vgroup2Id;
    _data['vgCode2'] = vgCode2;
    _data['vgroup2'] = vgroup2;
    _data['vehicleYear2'] = vehicleYear2;
    _data['vehicleFuel2Id'] = vehicleFuel2Id;
    _data['vehicleFuel2'] = vehicleFuel2;
    _data['transmisiV2Id'] = transmisiV2Id;
    _data['transmisiV2'] = transmisiV2;
    _data['payment'] = payment;
    _data['downPayment'] = downPayment;
    _data['tenor'] = tenor;
    _data['kisaranHargaId'] = kisaranHargaId;
    _data['kisaranHarga'] = kisaranHarga;
    _data['custTypeId'] = custTypeId;
    _data['customerType'] = customerType;
    _data['customerVal'] = customerVal;
    _data['custStatusId'] = custStatusId;
    _data['customerStatus'] = customerStatus;
    _data['q1'] = q1;
    _data['q2'] = q2;
    _data['q3'] = q3;
    _data['q4'] = q4;
    _data['q5'] = q5;
    _data['q6'] = q6;
    return _data;
  }
}
