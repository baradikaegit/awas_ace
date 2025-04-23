// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListProfileResponse {
  ListProfileResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listGetProfile,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListGetProfile>? listGetProfile;

  ListProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listGetProfile = (json['listGetProfile'] != null)
        ? List.from(json['listGetProfile'])
            .map((e) => ListGetProfile.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listGetProfile'] = listGetProfile!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListGetProfile {
  ListGetProfile({
    required this.userCode,
    required this.email,
    required this.phoneNumber,
    required this.userName,
    required this.profilePicture,
    required this.totalPoin,
    required this.totalLevel,
  });
  late final String userCode;
  late final String email;
  late final String phoneNumber;
  late final String userName;
  late final String profilePicture;
  late final int totalPoin;
  late final int totalLevel;

  ListGetProfile.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    totalPoin = json['totalPoin'];
    totalLevel = json['totalLevel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userCode'] = userCode;
    _data['email'] = email;
    _data['phoneNumber'] = phoneNumber;
    _data['userName'] = userName;
    _data['profilePicture'] = profilePicture;
    _data['totalPoin'] = totalPoin;
    _data['totalLevel'] = totalLevel;
    return _data;
  }
}

//update
class ListUpdateProfile {
  ListUpdateProfile({
    this.email,
    this.phoneNumber,
  });

  late String? email;
  late String? phoneNumber;

  ListUpdateProfile.fromJson(Map<String, dynamic> djson) {
    email = djson['email'];
    phoneNumber = djson['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['phoneNumber'] = phoneNumber;

    return _data;
  }
}

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  late int? statusCode;
  late String? statusMessage;
  late ListUpdateProfile? data;

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = (json['statusCode'] != null) ? json['statusCode'] : null;
    statusMessage =
        (json['statusMessage'] != null) ? json['statusMessage'] : null;
    data = (json['data'] != null)
        ? ListUpdateProfile.fromJson(json['data'][0])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listProfileUpdate'] = data!.toJson();
    return _data;
  }
}
