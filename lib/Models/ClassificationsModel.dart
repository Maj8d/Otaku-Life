class ClassificationsModel {
  ClassificationsModel({
      this.classificationId, 
      this.classificationName,});

  ClassificationsModel.fromJson(dynamic json) {
    classificationId = json['classification_id'];
    classificationName = json['classification_name'];
  }
  int? classificationId;
  String? classificationName;
ClassificationsModel copyWith({  int? classificationId,
  String? classificationName,
}) => ClassificationsModel(  classificationId: classificationId ?? this.classificationId,
  classificationName: classificationName ?? this.classificationName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classification_id'] = classificationId;
    map['classification_name'] = classificationName;
    return map;
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassificationsModel &&
        other.classificationName == classificationName; // or other.classificationName == classificationName
  }

  @override
  int get hashCode => classificationId.hashCode; // or classificationName.hashCode
}

