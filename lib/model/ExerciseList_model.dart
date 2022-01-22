class ExerciseList {
  String status;
  List<Result> result;

  ExerciseList({this.status, this.result});

  ExerciseList.fromJson(Map<String, dynamic> json) {
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
  String exerciseName;
  int exerciseTypeId;
  int show;
  int finalized;
  String createdAt;
  String updatedAt;
  int total;
  String audioLink;

  Result(
      {this.id,
        this.exerciseName,
        this.exerciseTypeId,
        this.show,
        this.finalized,
        this.createdAt,
        this.updatedAt,
        this.total,
        this.audioLink});

  Result.fromJson(Map<String, dynamic> json) {
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