// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  String id;
  String imdbId;
  String title;
  String year;
  String synopsis;
  String runtime;
  int released;
  String trailer;
  Certification certification;
  Torrents torrents;
  List<String> genres;
  Images images;
  Rating rating;

  Movie({
    this.id,
    this.imdbId,
    this.title,
    this.year,
    this.synopsis,
    this.runtime,
    this.released,
    this.trailer,
    this.certification,
    this.torrents,
    this.genres,
    this.images,
    this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["_id"],
    imdbId: json["imdb_id"],
    title: json["title"],
    year: json["year"],
    synopsis: json["synopsis"],
    runtime: json["runtime"],
    released: json["released"],
    trailer: json["trailer"],
    certification: certificationValues.map[json["certification"]],
    torrents: Torrents.fromJson(json["torrents"]),
    genres: List<String>.from(json["genres"].map((x) => x)),
    images: Images.fromJson(json["images"]),
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "imdb_id": imdbId,
    "title": title,
    "year": year,
    "synopsis": synopsis,
    "runtime": runtime,
    "released": released,
    "trailer": trailer,
    "certification": certificationValues.reverse[certification],
    "torrents": torrents.toJson(),
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "images": images.toJson(),
    "rating": rating.toJson(),
  };
}

enum Certification { R, PG_13, PG, G }

final certificationValues = EnumValues({
  "G": Certification.G,
  "PG": Certification.PG,
  "PG-13": Certification.PG_13,
  "R": Certification.R
});

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

class Torrents {
  Map<String, En> en;

  Torrents({
    this.en,
  });

  factory Torrents.fromJson(Map<String, dynamic> json) => Torrents(
    en: Map.from(json["en"]).map((k, v) => MapEntry<String, En>(k, En.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "en": Map.from(en).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class En {
  String url;
  int seed;
  int peer;
  int size;
  String filesize;
  Provider provider;

  En({
    this.url,
    this.seed,
    this.peer,
    this.size,
    this.filesize,
    this.provider,
  });

  factory En.fromJson(Map<String, dynamic> json) => En(
    url: json["url"],
    seed: json["seed"],
    peer: json["peer"],
    size: json["size"],
    filesize: json["filesize"],
    provider: providerValues.map[json["provider"]],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "seed": seed,
    "peer": peer,
    "size": size,
    "filesize": filesize,
    "provider": providerValues.reverse[provider],
  };
}

enum Provider { YTS, YIFY }

final providerValues = EnumValues({
  "YIFY": Provider.YIFY,
  "YTS": Provider.YTS
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
