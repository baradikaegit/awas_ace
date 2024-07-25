import 'dart:convert';

Vgroup vgroupFromJson(String str) => Vgroup.fromJson(json.decode(str));

String vgroupToJson(Vgroup data) => json.encode(data.toJson());

class Vgroup {
  String vgroup;

  Vgroup({
    required this.vgroup,
  });

  factory Vgroup.fromJson(Map<String, dynamic> json) => Vgroup(
        vgroup: json["vgroup"],
      );

  Map<String, dynamic> toJson() => {
        "vgroup": vgroup,
      };
  @override
  String toString() => vgroup;
}
