class AnimeModel {
  AnimeModel({
    this.animeId,
    this.animeName,
    this.animeDetails,
    this.animeImage,
    this.animeEpisodes,
    this.animeType,
    this.animeStatus,
    this.animeAge,
    this.animeStudio,
    this.releaseDate,
    this.finishDate,
    this.animeRating,
    this.animeGenre,
    this.animeSeason,
  });

  AnimeModel.fromJson(dynamic json) {
    animeId = json['anime_id'];
    animeName = json['anime_name'];
    animeDetails = json['anime_details'];
    animeImage = json['anime_image'];
    animeEpisodes = json['anime_episodes'];
    animeType = json['anime_type'];
    animeStatus = json['anime_status'];
    animeAge = json['anime_age'];
    animeStudio = json['anime_studio'];
    releaseDate = json['release_date'];
    finishDate = json['finish_date'];
    animeRating = json['anime_rating'];
    animeGenre = json['anime_genre'];
    animeSeason = json['anime_season'];
  }

  int? animeId;
  String? animeName;
  String? animeDetails;
  String? animeImage;
  int? animeEpisodes;
  String? animeType;
  String? animeStatus;
  String? animeAge;
  String? animeStudio;
  String? releaseDate;
  String? finishDate;
  double? animeRating;
  String? animeGenre;
  String? animeSeason;

  AnimeModel copyWith({
    int? animeId,
    String? animeName,
    String? animeDetails,
    String? animeImage,
    int? animeEpisodes,
    String? animeType,
    String? animeStatus,
    String? animeAge,
    String? animeStudio,
    String? releaseDate,
    String? finishDate,
    double? animeRating,
    String? animeGenre,
    String? animeSeason,
  }) =>
      AnimeModel(
        animeId: animeId ?? this.animeId,
        animeName: animeName ?? this.animeName,
        animeDetails: animeDetails ?? this.animeDetails,
        animeImage: animeImage ?? this.animeImage,
        animeEpisodes: animeEpisodes ?? this.animeEpisodes,
        animeType: animeType ?? this.animeType,
        animeStatus: animeStatus ?? this.animeStatus,
        animeAge: animeAge ?? this.animeAge,
        animeStudio: animeStudio ?? this.animeStudio,
        releaseDate: releaseDate ?? this.releaseDate,
        finishDate: finishDate ?? this.finishDate,
        animeRating: animeRating ?? this.animeRating,
        animeGenre: animeGenre ?? this.animeGenre,
        animeSeason: animeSeason ?? this.animeSeason,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['anime_id'] = animeId;
    map['anime_name'] = animeName;
    map['anime_details'] = animeDetails;
    map['anime_image'] = animeImage;
    map['anime_episodes'] = animeEpisodes;
    map['anime_type'] = animeType;
    map['anime_status'] = animeStatus;
    map['anime_age'] = animeAge;
    map['anime_studio'] = animeStudio;
    map['release_date'] = releaseDate;
    map['finish_date'] = finishDate;
    map['anime_rating'] = animeRating;
    map['anime_genre'] = animeGenre;
    map['anime_season'] = animeSeason;
    return map;
  }
}