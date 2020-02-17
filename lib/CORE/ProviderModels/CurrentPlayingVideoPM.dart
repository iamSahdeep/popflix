import 'package:flutter/cupertino.dart';
import 'package:flutter_torrent_streamer/flutter_torrent_streamer.dart';

class CurrentPlayingVideoPM extends ChangeNotifier {
  bool isReady = false;

  bool isDownloading = false;
  bool isStreamReady = false;
  bool isFetchingMeta = false;
  bool hasError = false;

  bool get isCompleted => progress == 100;

  double get progress => status != null ? status['progress'] : 0;

  double get speed => status != null ? status['downloadSpeed'] : 0;

  Map<dynamic, dynamic> status;

  init(String link) async {
    _addTorrentListeners();
    await _startDownload(link);
  }

  Future<void> _cleanDownloads() async {
    await TorrentStreamer.clean();
  }

  Future<void> _startDownload(String link) async {
    print(link);
    await TorrentStreamer.start(link);
  }

  void _addTorrentListeners() {
    TorrentStreamer.addEventListener('started', (_) {
      print("Started");
      resetState();
      isDownloading = true;
      isFetchingMeta = true;
      notifyListeners();
    });

    TorrentStreamer.addEventListener('prepared', (_) {
      print("Prepared");
      isDownloading = true;
      isFetchingMeta = false;
      notifyListeners();
    });

    TorrentStreamer.addEventListener('progress', (data) {
      print("update");
      status = data;
      notifyListeners();
    });

    TorrentStreamer.addEventListener('ready', (_) {
      print("Ready");

      isStreamReady = true;
      notifyListeners();
    });

    TorrentStreamer.addEventListener('stopped', (_) {
      print("Stopped");

      resetState();
    });

    TorrentStreamer.addEventListener('error', (_) {
      print("Error");

      hasError = true;
      notifyListeners();
    });
  }

  void resetState() {
    isDownloading = false;
    isStreamReady = false;
    isFetchingMeta = false;
    hasError = false;
    status = null;
    notifyListeners();
  }
}
