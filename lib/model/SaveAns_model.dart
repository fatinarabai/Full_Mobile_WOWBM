import 'dart:convert';

Save saveFromJson(String str) => Save.fromJson(json.decode(str));

String saveToJson(Save data) => json.encode(data.toJson());

class Save {
  Save({
    this.data,
  });

  List<Datum> data;

  factory Save.fromJson(Map<String, dynamic> json) => Save(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.questionId,
    this.optionId,
  });

  int questionId;
  int optionId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        questionId: json["question_id"],
        optionId: json["option_id"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "option_id": optionId,
      };
}
