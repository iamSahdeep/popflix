import 'package:popflix/CORE/Helpers/Prefs.dart';

class PrefsHelper {
  static bool isMovieRatedByRobot(String id) {
    var movies = Prefs.getRatedMovies();
    if (movies.contains(id))
      return true;
    else
      return false;
  }

  static void removeMoveFromRatedList(String id) {
    var movies = Prefs.getRatedMovies();
    if (movies.contains(id)) movies.remove(id);
    Prefs.addToRatedMovies(movies);
  }

  static void addMovieToRatedList(String id) {
    var movies = Prefs.getRatedMovies();
    movies.add(id);
    Prefs.addToRatedMovies(movies);
  }

  static bool isMovieInMyList(String id) {
    var movies = Prefs.getMyListMovies();
    if (movies.contains(id))
      return true;
    else
      return false;
  }

  static void removeMoveFromMyWatchList(String id) {
    var movies = Prefs.getMyListMovies();
    if (movies.contains(id)) movies.remove(id);
    Prefs.addToMyListMovies(movies);
  }

  static void addMovieToMyWatchList(String id) {
    var movies = Prefs.getMyListMovies();
    movies.add(id);
    Prefs.addToMyListMovies(movies);
  }
}
