import 'package:http/http.dart' as http;
import 'package:popflix/CORE/Helpers/Urls.dart';

class ApiProvider {
  Future<http.Response> getAllMovies(int page) async {
    return await http.get(Urls.BaseUrl + Urls.Movies + "/${page.toString()}");
  }

  Future<http.Response> getAllShows(int page) async {
    return await http.get(Urls.BaseUrl + Urls.Shows + "/${page.toString()}");
  }

  Future<http.Response> getAllAnimes(int page) async {
    return await http.get(Urls.BaseUrl + Urls.Animes + "/${page.toString()}");
  }

  Future<http.Response> getShowDetails(String imdbId) async {
    return await http.get(Urls.BaseUrl + Urls.ShowDetail + "/$imdbId");
  }

  Future<http.Response> getAnimeDetails(String id) async {
    return await http.get(Urls.BaseUrl + Urls.AnimeDetail + "/$id");
  }

  Future<http.Response> getPopularMoviesWithGenre(String name) async {
    return await http.get(Urls.BaseUrl +
        Urls.Movies +
        "/1" +
        "?sort=trending&genre=" +
        name);
  }

  Future<http.Response> getNewMovies() async {
    return await http.get(Urls.BaseUrl +
        Urls.Movies +
        "/1" +
        "?sort=year&order=-1");
  }

  Future<http.Response> getNewShows() async {
    return await http.get(Urls.BaseUrl +
        Urls.Shows +
        "/1" +
        "?sort=year&order=-1");
  }

  Future<http.Response> getNewAnimes() async {
    return await http.get(Urls.BaseUrl +
        Urls.Animes +
        "/1" +
        "?sort=year&order=-1");
  }

  Future<http.Response> getSearchedMovies(String string) async {
    return await http.get(Urls.BaseUrl +
        Urls.Movies +
        "/1?sort=title&order=1&keywords=$string");
  }

  Future<http.Response> getSearchedShows(String string) async {
    return await http.get(Urls.BaseUrl +
        Urls.Shows +
        "/1?sort=title&order=1&keywords=$string");
  }

  Future<http.Response> getSearchedAnimes(String string) async {
    return await http.get(Urls.BaseUrl +
        Urls.Animes +
        "/1?sort=title&order=1&keywords=$string");
  }

}
