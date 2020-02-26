import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences prefs;
  static const NAMEKEY = "user_name";
  static const RATEDMOVIES = "ratedMoviesByROBOT";
  static const FIRSTRUN = "firstrunbruh";
  static const CONTINUEWATCHINGMoviesLISTKEY = "ContinueWatchingMoviesList";
  static const MYWATCHLISTMovies = "mywatchlistMovies";
  static const MYLIKEDMOVIES = "myLikedmovies";
  static const CONTINUEWATCHINGShowsLISTKEY = "ContinueWatchingShowsList";
  static const MYWATCHLISTShows = "mywatchlistShows";
  static const MYLIKEDShows = "myLikedshows";
  static const COMPLETEWATCHEDMOVIES = "completlyWatchedMovies";
  static const COMPLETEWATCHEDSHOWS = "completlyWatchedShows";

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveName(String string) {
    prefs.setString(NAMEKEY, string);
  }

  static String getName(String string) {
    return prefs.setString(NAMEKEY, string) ?? "Robot";
  }

  static bool isFirstRun() {
    return prefs.getBool(FIRSTRUN) ?? true;
  }

  static void changeFirstRunToFalse() {
    prefs.setBool(FIRSTRUN, false);
  }

  static void saveMovieLastPoint(String movieId, int perc) {
    prefs.setInt(movieId, perc);
  }

  static int getMovieLastPoint(String movieId) {
    return prefs.getInt(movieId) ?? 0;
  }

  static void addMovieShowToContinueWatching(String movieId, bool isShow) {
    List<String> data = prefs.getStringList(isShow
            ? CONTINUEWATCHINGShowsLISTKEY
            : CONTINUEWATCHINGMoviesLISTKEY) ??
        [];
    data.add(movieId);
    prefs.setStringList(
        isShow ? CONTINUEWATCHINGShowsLISTKEY : CONTINUEWATCHINGMoviesLISTKEY,
        data);
  }

  static List<String> getMoviesContinueWatching() {
    return prefs.getStringList(CONTINUEWATCHINGMoviesLISTKEY) ?? [];
  }

  static List<String> getShowsContinueWatching() {
    return prefs.getStringList(CONTINUEWATCHINGShowsLISTKEY) ?? [];
  }

  static List<String> getCompletedShows() {
    return prefs.getStringList(COMPLETEWATCHEDSHOWS) ?? [];
  }

  static List<String> getCompletedMovies() {
    return prefs.getStringList(COMPLETEWATCHEDMOVIES) ?? [];
  }

  static void setCompletedShows(String Id) {
    var data = prefs.getStringList(COMPLETEWATCHEDSHOWS) ?? [];
    data.add(Id);
    prefs.setStringList(COMPLETEWATCHEDSHOWS, data);
  }

  static void setCompletedMovies(String Id) {
    var data = prefs.getStringList(COMPLETEWATCHEDMOVIES) ?? [];

    data.add(Id);
    prefs.setStringList(COMPLETEWATCHEDMOVIES, data);
  }

  static List<String> getRatedMovies() {
    return prefs.getStringList(RATEDMOVIES) ?? [];
  }

  static List<String> addToRatedMovies(List<String> data) {
    prefs.setStringList(RATEDMOVIES, data);
  }

}
