// To parse this JSON data, do
//
//     final anime = animeFromJson(jsonString);

import 'dart:convert';

List<Anime> animeFromJson(String str) => List<Anime>.from(json.decode(str).map((x) => Anime.fromJson(x)));

String animeToJson(List<Anime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Anime {
  String id;
  String malId;
  String title;
  String year;
  String slug;
  Type type;
  List<String> genres;
  Images images;
  Rating rating;
  int numSeasons;

  Anime({
    this.id,
    this.malId,
    this.title,
    this.year,
    this.slug,
    this.type,
    this.genres,
    this.images,
    this.rating,
    this.numSeasons,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
    id: json["_id"],
    malId: json["mal_id"],
    title: json["title"],
    year: json["year"],
    slug: json["slug"],
    type: typeValues.map[json["type"]],
    genres: List<String>.from(json["genres"].map((x) => x)),
    images: Images.fromJson(json["images"]),
    rating: Rating.fromJson(json["rating"]),
    numSeasons: json["num_seasons"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mal_id": malId,
    "title": title,
    "year": year,
    "slug": slug,
    "type": typeValues.reverse[type],
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "images": images.toJson(),
    "rating": rating.toJson(),
    "num_seasons": numSeasons,
  };
}

class Images {
  String poster;
  String fanart;
  String banner;

  Images({
    this.poster,
    this.fanart,
    this.banner,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    poster: json["poster"],
    fanart: json["fanart"],
    banner: json["banner"],
  );

  Map<String, dynamic> toJson() => {
    "poster": poster,
    "fanart": fanart,
    "banner": banner,
  };
}

class Rating {
  int percentage;
  int watching;
  int votes;
  int loved;
  int hated;

  Rating({
    this.percentage,
    this.watching,
    this.votes,
    this.loved,
    this.hated,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    percentage: json["percentage"],
    watching: json["watching"],
    votes: json["votes"],
    loved: json["loved"],
    hated: json["hated"],
  );

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
    "watching": watching,
    "votes": votes,
    "loved": loved,
    "hated": hated,
  };
}

enum Type { SHOW }

final typeValues = EnumValues({
  "show": Type.SHOW
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
