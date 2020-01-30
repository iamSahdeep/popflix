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
}
