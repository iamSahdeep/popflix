import 'package:http/http.dart';
import 'package:popflix/CORE/Networking/ApiProvider.dart';

class Repository {
  static ApiProvider apiProvider = ApiProvider();

  static Future<Response> fetchAllMovies(int page) async {
    return await apiProvider.getAllMovies(page);
  }

  static Future<Response> fetchAllShows(int page) async {
    return await apiProvider.getAllShows(page);
  }

  static Future<Response> fetchAllAnimes(int page) async {
    return await apiProvider.getAllAnimes(page);
  }

  static Future<Response> fetchShowDetails(String imdbId) async {
    return await apiProvider.getShowDetails(imdbId);
  }

  static Future<Response> fetchAnimeDetails(String id) async {
    return await apiProvider.getAnimeDetails(id);
  }

  static Future<Response> fetchPopularMoviesWithGenre(String name) async {
    return await apiProvider.getPopularMoviesWithGenre(name);
  }

  static Future<Response> fetchNewMovies() async {
    return await apiProvider.getNewMovies();
  }

  static Future<Response> fetchNewShows() async {
    return await apiProvider.getNewShows();
  }

  static Future<Response> fetchNewAnimes() async {
    return await apiProvider.getNewAnimes();
  }

  static Future<Response> fetchSearchedMovies(String data) async {
    return await apiProvider.getSearchedMovies(data);
  }

  static Future<Response> fetchSearchedShows(String data) async {
    return await apiProvider.getSearchedShows(data);
  }

  static Future<Response> fetchSearchedAnimes(String data) async {
    return await apiProvider.getSearchedAnimes(data);
  }


}
