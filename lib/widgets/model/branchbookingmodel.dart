import 'dart:convert';

BranchBooking branchBookingFromJson(String str) =>
    BranchBooking.fromJson(json.decode(str));

String branchBookingToJson(BranchBooking data) => json.encode(data.toJson());

class BranchBooking {
  String iD;
  String text;

  BranchBooking({
    required this.iD,
    required this.text,
  });

  factory BranchBooking.fromJson(Map<String, dynamic> json) => BranchBooking(
        iD: json["iD"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "iD": iD,
        "text": text,
      };
  @override
  String toString() => text;
}
