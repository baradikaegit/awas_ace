import 'dart:convert';

TipePelanggan tipePelangganFromJson(String str) =>
    TipePelanggan.fromJson(json.decode(str));

String tipePelangganToJson(TipePelanggan data) => json.encode(data.toJson());

class TipePelanggan {
  String iD;
  String name;

  TipePelanggan({
    required this.iD,
    required this.name,
  });

  factory TipePelanggan.fromJson(Map<String, dynamic> json) => TipePelanggan(
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
