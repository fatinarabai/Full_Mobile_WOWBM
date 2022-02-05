class AnalysisList {
  String status;
  List<Result> result;

  AnalysisList({this.status, this.result});

  AnalysisList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
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
  int result;
  int totalQuestions;
  String updatedAt;
  String exerciseName;
  int exerciseTypeId;

  Result(
      {this.id,
        this.result,
        this.totalQuestions,
        this.updatedAt,
        this.exerciseName,
        this.exerciseTypeId});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result'];
    totalQuestions = json['total_questions'];
    updatedAt = json['updated_at'];
    exerciseName = json['exercise_name'];
    exerciseTypeId = json['exercise_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['result'] = this.result;
    data['total_questions'] = this.totalQuestions;
    data['updated_at'] = this.updatedAt;
    data['exercise_name'] = this.exerciseName;
    data['exercise_type_id'] = this.exerciseTypeId;
    return data;
  }
}