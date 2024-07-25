import 'dart:convert';

SumberData sumberDataFromJson(String str) =>
    SumberData.fromJson(json.decode(str));

String sumberDataToJson(SumberData data) => json.encode(data.toJson());

class SumberData {
  String iD;
  String name;

  SumberData({
    required this.iD,
    required this.name,
  });

  factory SumberData.fromJson(Map<String, dynamic> json) => SumberData(
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
