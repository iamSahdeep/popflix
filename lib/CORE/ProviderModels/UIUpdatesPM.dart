import 'package:flutter/cupertino.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetMoviesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetShowsRM.dart';
import 'package:popflix/CORE/Repository/Repository.dart';

class UIUpdatePM extends ChangeNotifier {
  List<Movie> allMovies;
  List<Show> allShows;
  List<dynamic> searchedItems = [];
  List<dynamic> popularSearches = [];
  TextEditingController searchMoviesController = TextEditingController();

  String getSearchText() {
    return searchMoviesController.text.toString();
  }

  Future<List<dynamic>> getMoviesShowsFromSearchText() async {
    String text = getSearchText().toLowerCase();
    List<dynamic> data = [];

    await Repository.fetchSearchedMovies(text).then((response) {
      data.addAll(movieFromJson(response.body.toString()));
      notifyListeners();
    });
    await Repository.fetchSearchedShows(text).then((response) {
      data.addAll(showFromJson(response.body.toString()));
      notifyListeners();
    });
    await Repository.fetchSearchedAnimes(text).then((response) {
      data.addAll(animeFromJson(response.body.toString()));
      notifyListeners();
    });

    data.shuffle();
    return data;
  }

  void searchMovies(String value) async {
    searchedItems = await getMoviesShowsFromSearchText();
    notifyListeners();
  }

  randomPopularSearches() {
    popularSearches = [];
    popularSearches.addAll(allMovies.where((m) {
      if (m.rating.percentage > 80) {
        return true;
      } else {
        return false;
      }
    }).toList());
    popularSearches.addAll(allShows.where((m) {
      if (m.rating.percentage > 80) {
        return true;
      } else {
        return false;
      }
    }).toList());
    popularSearches.shuffle();
    popularSearches = popularSearches.getRange(0, 20).toList();
  }
}
