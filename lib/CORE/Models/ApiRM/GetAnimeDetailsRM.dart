// To parse this JSON data, do
//
//     final animeDetailsRm = animeDetailsRmFromJson(jsonString);

import 'dart:convert';

AnimeDetailsRm animeDetailsRmFromJson(String str) =>
    AnimeDetailsRm.fromJson(json.decode(str));

String animeDetailsRmToJson(AnimeDetailsRm data) => json.encode(data.toJson());

class AnimeDetailsRm {
  String id;
  String malId;
  String title;
  String year;
  String slug;
  String synopsis;
  String runtime;
  String status;
  String type;
  int lastUpdated;
  int v;
  int numSeasons;
  List<Episode> episodes;
  List<String> genres;
  Images images;
  Rating rating;

  AnimeDetailsRm({
    this.id,
    this.malId,
    this.title,
    this.year,
    this.slug,
    this.synopsis,
    this.runtime,
    this.status,
    this.type,
    this.lastUpdated,
    this.v,
    this.numSeasons,
    this.episodes,
    this.genres,
    this.images,
    this.rating,
  });

  factory AnimeDetailsRm.fromJson(Map<String, dynamic> json) => AnimeDetailsRm(
        id: json["_id"],
        malId: json["mal_id"],
        title: json["title"],
        year: json["year"],
        slug: json["slug"],
        synopsis: json["synopsis"],
        runtime: json["runtime"],
        status: json["status"],
        type: json["type"],
        lastUpdated: json["last_updated"],
        v: json["__v"],
        numSeasons: json["num_seasons"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        genres: List<String>.from(json["genres"].map((x) => x)),
        images: Images.fromJson(json["images"]),
        rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mal_id": malId,
        "title": title,
        "year": year,
        "slug": slug,
        "synopsis": synopsis,
        "runtime": runtime,
        "status": status,
        "type": type,
        "last_updated": lastUpdated,
        "__v": v,
        "num_seasons": numSeasons,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "images": images.toJson(),
        "rating": rating.toJson(),
      };
}

class Episode {
  String tvdbId;
  Overview overview;
  String episode;
  String season;
  Map<String, Torrent> torrents;
  String title;

  Episode({
    this.tvdbId,
    this.overview,
    this.episode,
    this.season,
    this.torrents,
    this.title,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        tvdbId: json["tvdb_id"],
        overview: overviewValues.map[json["overview"]],
        episode: json["episode"],
        season: json["season"],
        torrents: Map.from(json["torrents"])
            .map((k, v) => MapEntry<String, Torrent>(k, Torrent.fromJson(v))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "tvdb_id": tvdbId,
        "overview": overviewValues.reverse[overview],
        "episode": episode,
        "season": season,
        "torrents": Map.from(torrents)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "title": title,
      };
}

enum Overview { WE_STILL_DON_T_HAVE_SINGLE_EPISODE_OVERVIEWS_FOR_ANIME_SORRY }

final overviewValues = EnumValues({
  "We still don't have single episode overviews for anime… Sorry":
      Overview.WE_STILL_DON_T_HAVE_SINGLE_EPISODE_OVERVIEWS_FOR_ANIME_SORRY
});

class Torrent {
  Provider provider;
  int peers;
  int seeds;
  String url;

  Torrent({
    this.provider,
    this.peers,
    this.seeds,
    this.url,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
        provider: providerValues.map[json["provider"]],
        peers: json["peers"],
        seeds: json["seeds"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "provider": providerValues.reverse[provider],
        "peers": peers,
        "seeds": seeds,
        "url": url,
      };
}

enum Provider { HORRIBLE_SUBS, COMMIE }

final providerValues = EnumValues(
    {"Commie": Provider.COMMIE, "HorribleSubs": Provider.HORRIBLE_SUBS});

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
