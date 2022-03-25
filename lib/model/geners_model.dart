// To parse this JSON data, do
//     نوع الفيلم
//     final movieGeners = movieGenersFromJson(jsonString);

import 'dart:convert';

MovieGeners movieGenersFromJson(String str) =>
    MovieGeners.fromJson(json.decode(str));

String movieGenersToJson(MovieGeners data) => json.encode(data.toJson());

class MovieGeners {
  MovieGeners({
    required this.genres,
  });

  List<Genre> genres;

  factory MovieGeners.fromJson(Map<String, dynamic> json) => MovieGeners(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
