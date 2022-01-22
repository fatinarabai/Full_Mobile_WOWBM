class ResponseResult {
  String status;
  Result result;

  ResponseResult({this.status, this.result});

  ResponseResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  int userId;
  int exerciseId;
  int totalQuestions;
  int result;
  String createdAt;
  String updatedAt;
  User user;
  List<Answer> answer;

  Result(
      {this.id,
      this.userId,
      this.exerciseId,
      this.totalQuestions,
      this.result,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.answer});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    exerciseId = json['exercise_id'];
    totalQuestions = json['total_questions'];
    result = json['result'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['exercise_id'] = this.exerciseId;
    data['total_questions'] = this.totalQuestions;
    data['result'] = this.result;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  int role;
  String school;
  Null emailVerifiedAt;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  String photoUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.school,
      this.emailVerifiedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    school = json['school'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['school'] = this.school;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class Answer {
  int id;
  int attemptId;
  int questionId;
  int optionId;
  int correct;
  int topicId;
  String createdAt;
  String updatedAt;
  Question question;

  Answer(
      {this.id,
      this.attemptId,
      this.questionId,
      this.optionId,
      this.correct,
      this.topicId,
      this.createdAt,
      this.updatedAt,
      this.question});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attemptId = json['attempt_id'];
    questionId = json['question_id'];
    optionId = json['option_id'];
    correct = json['correct'];
    topicId = json['topic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attempt_id'] = this.attemptId;
    data['question_id'] = this.questionId;
    data['option_id'] = this.optionId;
    data['correct'] = this.correct;
    data['topic_id'] = this.topicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.question != null) {
      data['question'] = this.question.toJson();
    }
    return data;
  }
}

class Question {
  String questionText;
  String answerExplanation;
  List<Options> options;

  Question({this.questionText, this.answerExplanation, this.options});

  Question.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    answerExplanation = json['answer_explanation'];
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
    data['answer_explanation'] = this.answerExplanation;
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
  int correct;
  String imageUrl;

  Options({this.id, this.option, this.image, this.correct, this.imageUrl});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option'];
    image = json['image'];
    correct = json['correct'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option'] = this.option;
    data['image'] = this.image;
    data['correct'] = this.correct;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
