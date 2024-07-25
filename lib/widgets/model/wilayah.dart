import 'dart:convert';

Wilayah wilayahFromJson(String str) => Wilayah.fromJson(json.decode(str));

String wilayahToJson(Wilayah data) => json.encode(data.toJson());

class Wilayah {
  int no;
  String text;

  Wilayah({
    required this.no,
    required this.text,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        no: json["no"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "text": text,
      };
  @override
  String toString() => text;
}
