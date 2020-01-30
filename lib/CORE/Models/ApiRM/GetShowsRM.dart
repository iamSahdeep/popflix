// To parse this JSON data, do
//
//     final show = showFromJson(jsonString);

import 'dart:convert';

List<Show> showFromJson(String str) => List<Show>.from(json.decode(str).map((x) => Show.fromJson(x)));

String showToJson(List<Show> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Show {
  String id;
  String imdbId;
  String tvdbId;
  String title;
  String year;
  String slug;
  int numSeasons;
  Images images;
  Rating rating;

  Show({
    this.id,
    this.imdbId,
    this.tvdbId,
    this.title,
    this.year,
    this.slug,
    this.numSeasons,
    this.images,
    this.rating,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    id: json["_id"],
    imdbId: json["imdb_id"],
    tvdbId: json["tvdb_id"],
    title: json["title"],
    year: json["year"],
    slug: json["slug"],
    numSeasons: json["num_seasons"],
    images: Images.fromJson(json["images"]),
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "imdb_id": imdbId,
    "tvdb_id": tvdbId,
    "title": title,
    "year": year,
    "slug": slug,
    "num_seasons": numSeasons,
    "images": images.toJson(),
    "rating": rating.toJson(),
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
