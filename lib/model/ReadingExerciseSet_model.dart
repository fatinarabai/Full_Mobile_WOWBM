class ReadingExercise {
  String status;
  Result result;

  ReadingExercise({this.status, this.result});

  ReadingExercise.fromJson(Map<String, dynamic> json) {
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
  String exerciseName;
  int exerciseTypeId;
  int show;
  int finalized;
  String createdAt;
  String updatedAt;
  int total;

  Result(
      {this.id,
      this.exerciseName,
      this.exerciseTypeId,
      this.show,
      this.finalized,
      this.createdAt,
      this.updatedAt,
      this.total});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseName = json['exercise_name'];
    exerciseTypeId = json['exercise_type_id'];
    show = json['show'];
    finalized = json['finalized'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    total = json['total'];
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
    return data;
  }
}
