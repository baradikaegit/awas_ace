import 'dart:convert';

Referensi referensiFromJson(String str) => Referensi.fromJson(json.decode(str));

String referensiToJson(Referensi data) => json.encode(data.toJson());

class Referensi {
  String iD;
  String name;

  Referensi({
    required this.iD,
    required this.name,
  });

  factory Referensi.fromJson(Map<String, dynamic> json) => Referensi(
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
