// To parse this JSON data, do
//
//     final showDetailsRm = showDetailsRmFromJson(jsonString);

import 'dart:convert';

ShowDetailsRm showDetailsRmFromJson(String str) =>
    ShowDetailsRm.fromJson(json.decode(str));

String showDetailsRmToJson(ShowDetailsRm data) => json.encode(data.toJson());

class ShowDetailsRm {
  String id;
  String imdbId;
  String tvdbId;
  String title;
  String year;
  String slug;
  String synopsis;
  String runtime;
  String country;
  String network;
  String airDay;
  String airTime;
  String status;
  int numSeasons;
  int lastUpdated;
  int v;
  List<Episode> episodes;
  List<String> genres;
  Images images;
  Rating rating;

  ShowDetailsRm({
    this.id,
    this.imdbId,
    this.tvdbId,
    this.title,
    this.year,
    this.slug,
    this.synopsis,
    this.runtime,
    this.country,
    this.network,
    this.airDay,
    this.airTime,
    this.status,
    this.numSeasons,
    this.lastUpdated,
    this.v,
    this.episodes,
    this.genres,
    this.images,
    this.rating,
  });

  factory ShowDetailsRm.fromJson(Map<String, dynamic> json) => ShowDetailsRm(
        id: json["_id"],
        imdbId: json["imdb_id"],
        tvdbId: json["tvdb_id"],
        title: json["title"],
        year: json["year"],
        slug: json["slug"],
        synopsis: json["synopsis"],
        runtime: json["runtime"],
        country: json["country"],
        network: json["network"],
        airDay: json["air_day"],
        airTime: json["air_time"],
        status: json["status"],
        numSeasons: json["num_seasons"],
        lastUpdated: json["last_updated"],
        v: json["__v"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        genres: List<String>.from(json["genres"].map((x) => x)),
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
        "synopsis": synopsis,
        "runtime": runtime,
        "country": country,
        "network": network,
        "air_day": airDay,
        "air_time": airTime,
        "status": status,
        "num_seasons": numSeasons,
        "last_updated": lastUpdated,
        "__v": v,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "images": images.toJson(),
        "rating": rating.toJson(),
      };
}

class Episode {
  Map<String, Torrent> torrents;
  Watched watched;
  int firstAired;
  bool dateBased;
  String overview;
  String title;
  int episode;
  int season;
  int tvdbId;

  Episode({
    this.torrents,
    this.watched,
    this.firstAired,
    this.dateBased,
    this.overview,
    this.title,
    this.episode,
    this.season,
    this.tvdbId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        torrents: Map.from(json["torrents"])
            .map((k, v) => MapEntry<String, Torrent>(k, Torrent.fromJson(v))),
        watched: Watched.fromJson(json["watched"]),
        firstAired: json["first_aired"],
        dateBased: json["date_based"],
        overview: json["overview"],
        title: json["title"],
        episode: json["episode"],
        season: json["season"],
        tvdbId: json["tvdb_id"],
      );

  Map<String, dynamic> toJson() => {
        "torrents": Map.from(torrents)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "watched": watched.toJson(),
        "first_aired": firstAired,
        "date_based": dateBased,
        "overview": overview,
        "title": title,
        "episode": episode,
        "season": season,
        "tvdb_id": tvdbId,
      };
}

class Torrent {
  String url;
  int seeds;
  int peers;
  Provider provider;

  Torrent({
    this.url,
    this.seeds,
    this.peers,
    this.provider,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
        url: json["url"],
        seeds: json["seeds"],
        peers: json["peers"],
        provider: providerValues.map[json["provider"]],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "seeds": seeds,
        "peers": peers,
        "provider": providerValues.reverse[provider],
      };
}

enum Provider {
  EZTV,
  ETTV_2_HD,
  ETTV_ASAP,
  ETTV_EVOLVE,
  ETTV_KILLERS,
  ETTV_BATV,
  ETTV_FUM,
  THE_1080_P
}

final providerValues = EnumValues({
  "ETTV 2HD": Provider.ETTV_2_HD,
  "ETTV ASAP": Provider.ETTV_ASAP,
  "ETTV BATV": Provider.ETTV_BATV,
  "ETTV EVOLVE": Provider.ETTV_EVOLVE,
  "ETTV FUM": Provider.ETTV_FUM,
  "ETTV KILLERS": Provider.ETTV_KILLERS,
  "EZTV": Provider.EZTV,
  "1080p": Provider.THE_1080_P
});

class Watched {
  bool watched;

  Watched({
    this.watched,
  });

  factory Watched.fromJson(Map<String, dynamic> json) => Watched(
        watched: json["watched"],
      );

  Map<String, dynamic> toJson() => {
        "watched": watched,
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
