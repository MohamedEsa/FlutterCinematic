// To parse this JSON data, do
//
//     final movieRelative = movieRelativeFromJson(jsonString);

import 'dart:convert';

MovieRelative movieRelativeFromJson(String str) =>
    MovieRelative.fromJson(json.decode(str));

String movieRelativeToJson(MovieRelative data) => json.encode(data.toJson());

class MovieRelative {
  MovieRelative({
    this.cast,
    this.crew,
    this.id,
  });

  List<Cast2>? cast;
  List<Cast2>? crew;
  int? id;

  factory MovieRelative.fromJson(Map<String, dynamic> json) => MovieRelative(
        cast: List<Cast2>.from(json["cast"].map((x) => Cast2.fromJson(x))),
        crew: List<Cast2>.from(json["crew"].map((x) => Cast2.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
        "id": id,
      };
}

class Cast2 {
  Cast2({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.voteCount,
    this.video,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.title,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? posterPath;
  int? voteCount;
  bool? video;
  String? overview;
  String? releaseDate;
  double? voteAverage;
  String? title;
  double? popularity;
  String? character;
  String? creditId;
  int? order;
  String? department;
  String? job;

  factory Cast2.fromJson(Map<String, dynamic> json) => Cast2(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        voteCount: json["vote_count"],
        video: json["video"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse![originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "vote_count": voteCount,
        "video": video,
        "overview": overview,
        "release_date": releaseDate,
        "vote_average": voteAverage,
        "title": title,
        "popularity": popularity,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
      };
}

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
