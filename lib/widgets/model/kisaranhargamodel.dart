import 'dart:convert';

KisaranHarga kisaranHargaFromJson(String str) =>
    KisaranHarga.fromJson(json.decode(str));

String kisaranHargaToJson(KisaranHarga data) => json.encode(data.toJson());

class KisaranHarga {
  String iD;
  String name;

  KisaranHarga({
    required this.iD,
    required this.name,
  });

  factory KisaranHarga.fromJson(Map<String, dynamic> json) => KisaranHarga(
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
