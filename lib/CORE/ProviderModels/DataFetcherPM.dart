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
      allAnimes.forEach((anime){
        anime.images.banner = "https://media.kitsu.io/anime/poster_images/${anime.id.toString()}/original.jpg";
      });
      notifyListeners();
    });
  }

  List<Movie> getBingeWorthMovies(){
    return allMovies.getRange(0, 15).toList();
  }

  List<Show> getBingeWorthTVShows(){
    return allShows.getRange(0, 15).toList();
  }
  List<Anime> getBingeWorthAnimes(){
    return allAnimes.getRange(0, 15).toList();
  }

  String getRandomYoutubeLink() {
    return allMovies[Random().nextInt(10)].trailer;
  }
}
