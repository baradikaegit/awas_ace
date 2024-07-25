import 'dart:convert';

Vgroup vgroupFromJson(String str) => Vgroup.fromJson(json.decode(str));

String vgroupToJson(Vgroup data) => json.encode(data.toJson());

class Vgroup {
  String iD;
  String vgroup;

  Vgroup({
    required this.iD,
    required this.vgroup,
  });

  factory Vgroup.fromJson(Map<String, dynamic> json) => Vgroup(
        iD: json["iD"],
        vgroup: json["vgroup"],
      );

  Map<String, dynamic> toJson() => {
        "iD": iD,
        "vgroup": vgroup,
      };
  @override
  String toString() => vgroup;
}
