import 'dart:convert';

ProspectOpsi prospectOpsiFromJson(String str) =>
    ProspectOpsi.fromJson(json.decode(str));

String prospectOpsiToJson(ProspectOpsi data) => json.encode(data.toJson());

class ProspectOpsi {
  String iD;
  String name;

  ProspectOpsi({
    required this.iD,
    required this.name,
  });

  factory ProspectOpsi.fromJson(Map<String, dynamic> json) => ProspectOpsi(
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
