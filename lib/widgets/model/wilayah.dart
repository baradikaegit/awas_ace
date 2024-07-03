import 'dart:convert';

Wilayah wilayahFromJson(String str) => Wilayah.fromJson(json.decode(str));

String wilayahToJson(Wilayah data) => json.encode(data.toJson());

class Wilayah {
  String id;
  String text;

  Wilayah({
    required this.id,
    required this.text,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
  @override
  String toString() => text;
}
