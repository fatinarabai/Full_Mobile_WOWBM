class Topic {
  String status;
  Result result;

  Topic({this.status, this.result});

  Topic.fromJson(Map<String, dynamic> json) {
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
  String topicName;
  String description;
  String file;
  String createdAt;
  String updatedAt;
  String fileUrl;

  Result(
      {this.id,
      this.topicName,
      this.description,
      this.file,
      this.createdAt,
      this.updatedAt,
      this.fileUrl});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicName = json['topic_name'];
    description = json['description'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic_name'] = this.topicName;
    data['description'] = this.description;
    data['file'] = this.file;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
