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
}
