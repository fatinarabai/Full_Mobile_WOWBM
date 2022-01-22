class ReadingQuestion {
  String status;
  Exercise exercise;
  List<Questions> questions;

  ReadingQuestion({this.status, this.exercise, this.questions});

  ReadingQuestion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    exercise = json['exercise'] != null
        ? new Exercise.fromJson(json['exercise'])
        : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.exercise != null) {
      data['exercise'] = this.exercise.toJson();
    }
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exercise {
  int id;
  String exerciseName;
  int exerciseTypeId;
  int show;
  int finalized;
  String createdAt;
  String updatedAt;
  int total;
  String audioLink;

  Exercise(
      {this.id,
        this.exerciseName,
        this.exerciseTypeId,
        this.show,
        this.finalized,
        this.createdAt,
        this.updatedAt,
        this.total,
        this.audioLink});

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseName = json['exercise_name'];
    exerciseTypeId = json['exercise_type_id'];
    show = json['show'];
    finalized = json['finalized'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    total = json['total'];
    audioLink = json['audio_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exercise_name'] = this.exerciseName;
    data['exercise_type_id'] = this.exerciseTypeId;
    data['show'] = this.show;
    data['finalized'] = this.finalized;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total'] = this.total;
    data['audio_link'] = this.audioLink;
    return data;
  }
}

class Questions {
  String questionText;
  int id;
  int seq;
  List<Options> options;

  Questions({this.questionText, this.id, this.seq, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    id = json['id'];
    seq = json['seq'];
    if (json['options'] != null) {
      options = <Options>[];
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