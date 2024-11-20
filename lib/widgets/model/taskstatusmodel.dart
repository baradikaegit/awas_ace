import 'dart:convert';

TaskStatus taskStatusFromJson(String str) =>
    TaskStatus.fromJson(json.decode(str));

String taskStatusToJson(TaskStatus data) => json.encode(data.toJson());

class TaskStatus {
  String iD;
  String text;

  TaskStatus({
    required this.iD,
    required this.text,
  });

  factory TaskStatus.fromJson(Map<String, dynamic> json) => TaskStatus(
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
