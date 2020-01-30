class Utils{
  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
    return url.replaceAll("http://youtube.com/watch?v=", "");
  }
}