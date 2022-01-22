class QuestionId {
  String status;
  Question question;
  List<QuestionOption> questionOption;

  QuestionId({this.status, this.question, this.questionOption});

  QuestionId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    if (json['question_option'] != null) {
      questionOption = new List<QuestionOption>();
      json['question_option'].forEach((v) {
        questionOption.add(new QuestionOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.question != null) {
      data['question'] = this.question.toJson();
    }
    if (this.questionOption != null) {
      data['question_option'] =
          this.questionOption.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int id;
  int seq;
  int exerciseId;
  int topicId;
  String questionText;
  String answerExplanation;
  int questionType;
  String createdAt;
  String updatedAt;

  Question(
      {this.id,
      this.seq,
      this.exerciseId,
      this.topicId,
      this.questionText,
      this.answerExplanation,
      this.questionType,
      this.createdAt,
      this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];
    exerciseId = json['exercise_id'];
    topicId = json['topic_id'];
    questionText = json['question_text'];
    answerExplanation = json['answer_explanation'];
    questionType = json['question_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['exercise_id'] = this.exerciseId;
    data['topic_id'] = this.topicId;
    data['question_text'] = this.questionText;
    data['answer_explanation'] = this.answerExplanation;
    data['question_type'] = this.questionType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class QuestionOption {
  int id;
  int questionId;
  String option;
  String image;
  int correct;
  String createdAt;
  String updatedAt;
  String imageUrl;

  QuestionOption(
      {this.id,
      this.questionId,
      this.option,
      this.image,
      this.correct,
      this.createdAt,
      this.updatedAt,
      this.imageUrl});

  QuestionOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    option = json['option'];
    image = json['image'];
    correct = json['correct'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['option'] = this.option;
    data['image'] = this.image;
    data['correct'] = this.correct;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
