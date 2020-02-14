import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences prefs;
  static const NAMEKEY = "user_name";
  static const CONTINUEWATCHINGMoviesLISTKEY = "ContinueWatchingMoviesList";
  static const MYWATCHLISTMovies = "mywatchlistMovies";
  static const MYLIKEDMOVIES = "myLikedmovies";
  static const CONTINUEWATCHINGShowsLISTKEY = "ContinueWatchingShowsList";
  static const MYWATCHLISTShows = "mywatchlistShows";
  static const MYLIKEDShows = "myLikedshows";

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveName(String string) {
    prefs.setString(NAMEKEY, string);
  }

  static String getName(String string) {
    return prefs.setString(NAMEKEY, string) ?? "Robot";
  }

  static void saveMovieLastPoint(String movieId, int time) {
    prefs.setInt(movieId, time);
  }

  static int getMovieLastPoint(String movieId, int time) {
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
}
