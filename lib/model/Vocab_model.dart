class Response {
  String status;
  List<Result> result;

  Response({this.status, this.result});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String word;
  String meaning;

  Result({this.id, this.word, this.meaning});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['meaning'] = this.meaning;
    return data;
  }
}
