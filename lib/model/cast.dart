// To parse this JSON data, do
//  فاصيل الممثلين

//     final detailOfMovie = detailOfMovieFromJson(jsonString);

import 'dart:convert';

DetailOfMovie detailOfMovieFromJson(String str) =>
    DetailOfMovie.fromJson(json.decode(str));

//String detailOfMovieToJson(DetailOfMovie data) => json.encode(data.toJson());

class DetailOfMovie {
  DetailOfMovie({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int? id;
  List<Cast>? cast;
  List<Cast>? crew;

  factory DetailOfMovie.fromJson(Map<String, dynamic> json) => DetailOfMovie(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

// // / / Map<String, dynamic> toJson() => {
//         "id": id,
//         "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
//         "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
//       };
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  bool? adult;
  int? gender;
  int? id;
  Department? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  Department? department;
  String? job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"] == null
            ? null
            : departmentValues.map[json["department"]],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse?[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department":
            department == null ? null : departmentValues.reverse?[department],
        "job": job,
      };
}

enum Department {
  ACTING,
  CREW,
  CAMERA,
  SOUND,
  PRODUCTION,
  ART,
  EDITING,
  COSTUME_MAKE_UP,
  DIRECTING,
  WRITING,
  VISUAL_EFFECTS
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
