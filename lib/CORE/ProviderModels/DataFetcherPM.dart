import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetMoviesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetShowsRM.dart';
import 'package:popflix/CORE/Repository/Repository.dart';

class DataFetcherPM extends ChangeNotifier {
  List<Movie> allMovies = [];
  int moviesPagingPage = 1;
  List<Show> allShows = [];
  int showsPagingPage = 1;
  List<Anime> allAnimes = [];
  int animesPagingPage = 1;

  Movie randomItemForFirstPoster;

  List<Movie> newMovies = [];
  List<Show> newShows = [];
  List<Anime> newAnimes = [];

  List<Movie> popularActionMovies = [];
  List<Movie> popularCrimeMovies = [];
  List<Movie> popularFamilyMovies = [];

  DataFetcherPM() {
    getAllMovies();
    getAllShows();
    getAllAnimes();
    getPopularGenreMovies("action");
    getPopularGenreMovies("crime");
    getPopularGenreMovies("family");
    getNewMovies();
    getNewAnimes();
    getNewShows();
  }

  bool isDataFetched() {
    if (allMovies.isEmpty ||
        allAnimes.isEmpty ||
        allShows.isEmpty ||
        newMovies.isEmpty ||
        newAnimes.isEmpty ||
        newShows.isEmpty ||
        popularFamilyMovies.isEmpty ||
        popularCrimeMovies.isEmpty ||
        popularActionMovies.isEmpty) {
      return false;
    } else
      return true;
  }

  getAllMovies() async {
    Repository.fetchAllMovies(moviesPagingPage).then((response) {
      allMovies.addAll(movieFromJson(response.body.toString()));
      notifyListeners();
    });
  }

  getAllShows() async {
    Repository.fetchAllShows(showsPagingPage).then((response) {
      allShows.addAll(showFromJson(response.body.toString()));
      notifyListeners();
    });
  }

  getAllAnimes() async {
    Repository.fetchAllAnimes(showsPagingPage).then((response) {
      allAnimes.addAll(animeFromJson(response.body.toString()));
      allAnimes.forEach((anime) {
        anime.images.banner =
            "https://media.kitsu.io/anime/poster_images/${anime.id.toString()}/original.jpg";
      });
      notifyListeners();
    });
  }

  List<Movie> getBingeWorthMovies() {
    return allMovies.getRange(0, 15).toList();
  }

  List<Show> getBingeWorthTVShows() {
    return allShows.getRange(0, 15).toList();
  }

  List<Anime> getBingeWorthAnimes() {
    return allAnimes.getRange(0, 15).toList();
  }

  String getRandomYoutubeLink() {
    return allMovies[Random().nextInt(10)].trailer;
  }

  dynamic getRandomItem() {
    return allMovies[Random().nextInt(allMovies.length - 1)];
  }

  List<Movie> getMoviesWithSameGenres(Movie movie) {
    List<Movie> temp = allMovies +
        popularActionMovies +
        popularFamilyMovies +
        popularCrimeMovies +
        newMovies;
    return temp.where((m) {
      if (m.genres.any((item) => movie.genres.contains(item))) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Show> getShowsWithSameGenres(Show show) {
    List<Show> temp = allShows;
    int pos = temp.indexOf(show);
    if (pos < 35)
      return temp.getRange(pos + 1, pos + 13).toList();
    else
      return temp;
  }

  List<Anime> getAnimesWithSameGenres(Anime show) {
    List<Anime> temp = allAnimes;
    int pos = temp.indexOf(show);
    if (pos < 35)
      return temp.getRange(pos + 1, pos + 13).toList();
    else
      return temp;
  }

  getPopularGenreMovies(String name) {
    Repository.fetchPopularMoviesWithGenre(name).then((response) {
      if (name == "action")
        popularActionMovies.addAll(movieFromJson(response.body.toString()));
      else if (name == "crime") {
        popularCrimeMovies.addAll(movieFromJson(response.body.toString()));
      } else {
        popularFamilyMovies.addAll(movieFromJson(response.body.toString()));
      }
      notifyListeners();
    });
  }

  void getNewMovies() {
    Repository.fetchNewMovies().then((response) {
      newMovies.addAll(movieFromJson(response.body.toString()));
      randomItemForFirstPoster =
          newMovies[Random().nextInt(newMovies.length - 1)];
      notifyListeners();
    });
  }

  void getNewAnimes() {
    Repository.fetchNewAnimes().then((response) {
      newAnimes.addAll(animeFromJson(response.body.toString()));
      newAnimes.forEach((anime) {
        anime.images.banner =
            "https://media.kitsu.io/anime/poster_images/${anime.id.toString()}/original.jpg";
      });
      notifyListeners();
    });
  }

  void getNewShows() {
    Repository.fetchNewShows().then((response) {
      newShows.addAll(showFromJson(response.body.toString()));
      notifyListeners();
    });
  }

  List<dynamic> getMyList() {}

  List<dynamic> getNewContentAll() {
    var data = [];
    data.addAll(newMovies.getRange(0, 9));
    data.addAll(newShows.getRange(0, 9));
    data.shuffle();
    return data;
  }
}
