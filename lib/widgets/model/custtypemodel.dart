import 'dart:convert';

CustType custTypeFromJson(String str) => CustType.fromJson(json.decode(str));

String custTypeToJson(CustType data) => json.encode(data.toJson());

class CustType {
  String iD;
  String name;
  int val;

  CustType({
    required this.iD,
    required this.name,
    required this.val,
  });

  factory CustType.fromJson(Map<String, dynamic> json) => CustType(
        iD: json["iD"],
        name: json["name"],
        val: json["val"],
      );

  Map<String, dynamic> toJson() => {
        "iD": iD,
        "name": name,
        "val": val,
      };
  @override
  String toString() => name;
}
