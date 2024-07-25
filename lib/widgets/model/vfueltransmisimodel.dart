import 'dart:convert';

VfuelTransmisi vfueltransmisiFromJson(String str) =>
    VfuelTransmisi.fromJson(json.decode(str));

String vfueltransmisiToJson(VfuelTransmisi data) => json.encode(data.toJson());

class VfuelTransmisi {
  String iD;
  String name;

  VfuelTransmisi({
    required this.iD,
    required this.name,
  });

  factory VfuelTransmisi.fromJson(Map<String, dynamic> json) => VfuelTransmisi(
        iD: json["iD"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iD": iD,
        "name": name,
      };
  @override
  String toString() => name;
}
