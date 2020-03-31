class Utils {
  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
    return url.replaceAll("http://youtube.com/watch?v=", "");
  }

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '')}h ${parts[1].padLeft(2, '0')}m';
  }

  static int toKBPS(double bps) {
    return (bps / (1024)).floor();
  }
}
