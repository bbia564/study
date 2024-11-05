class StudyEntity {
  int id;
  DateTime createdTime;
  int type;
  String title;
  DateTime endTime;
  int colorIndex;
  int isDone;

  StudyEntity(
    this.id,
    this.createdTime,
    this.type,
    this.title,
    this.endTime,
    this.colorIndex,
    this.isDone,
  );

  factory StudyEntity.fromJson(Map<String, dynamic> json) {
    return StudyEntity(
      json['id'],
      DateTime.parse(json['created_time']),
      json['type'],
      json['title'],
      DateTime.parse(json['end_time']),
      json['color_index'],
      json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_time': createdTime.toIso8601String(),
      'type': type,
      'title': title,
      'end_time': endTime.toIso8601String(),
      'color_index': colorIndex,
      'is_done': isDone,
    };
  }

}