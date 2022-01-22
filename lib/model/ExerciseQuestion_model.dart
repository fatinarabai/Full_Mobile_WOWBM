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
  String questionText;
  int id;
  int seq;
  List<Options> options;

  Result({this.questionText, this.id, this.seq, this.options});

  Result.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    id = json['id'];
    seq = json['seq'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_text'] = this.questionText;
    data['id'] = this.id;
    data['seq'] = this.seq;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int id;
  String option;
  String image;
  String imageUrl;

  Options({this.id, this.option, this.image, this.imageUrl});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option'] = this.option;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
