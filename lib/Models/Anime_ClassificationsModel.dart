class AnimeClassificationsModel {
  AnimeClassificationsModel({
      this.animeClassificationsId, 
      this.animeId, 
      this.classificationId,});

  AnimeClassificationsModel.fromJson(dynamic json) {
    animeClassificationsId = json['anime_classifications_id'];
    animeId = json['anime_id'];
    classificationId = json['classification_id'];
  }
  int? animeClassificationsId;
  int? animeId;
  int? classificationId;
AnimeClassificationsModel copyWith({  int? animeClassificationsId,
  int? animeId,
  int? classificationId,
}) => AnimeClassificationsModel(  animeClassificationsId: animeClassificationsId ?? this.animeClassificationsId,
  animeId: animeId ?? this.animeId,
  classificationId: classificationId ?? this.classificationId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['anime_classifications_id'] = animeClassificationsId;
    map['anime_id'] = animeId;
    map['classification_id'] = classificationId;
    return map;
  }

}