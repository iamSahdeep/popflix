import 'package:flutter/cupertino.dart';
import 'package:popflix/CORE/Models/ApiRM/GetMoviesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetShowsRM.dart';

class UIUpdatePM extends ChangeNotifier {
  List<Movie> allMovies;
  List<Show> allShows;
  List<dynamic> searchedItems = [];
  List<dynamic> popularSearches = [];
  TextEditingController searchMoviesController = TextEditingController();


  String getSearchText() {
    return searchMoviesController.text.toString();
  }

  List<dynamic> getMoviesShowsFromSearchText() {
    String text = getSearchText().toLowerCase();
    List<dynamic> data = [];
    data.addAll(allMovies.where((m) {
      if (m.title.toLowerCase().contains(text)) {
        return true;
      } else {
        return false;
      }
    }).toList());
    data.addAll(allShows.where((m) {
      if (m.title.toLowerCase().contains(text)) {
        return true;
      } else {
        return false;
      }
    }).toList());
    data.shuffle();
    return data;
  }

  void searchMovies(String value) {
    searchedItems = getMoviesShowsFromSearchText();
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
