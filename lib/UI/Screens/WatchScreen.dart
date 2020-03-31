import 'package:flutter/material.dart';
import 'package:flutter_torrent_streamer/flutter_torrent_streamer.dart';
import 'package:popflix/CORE/Helpers/Utils.dart';
import 'package:popflix/CORE/ProviderModels/CurrentPlayingVideoPM.dart';
import 'package:provider/provider.dart';

class MySpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 8, width: 8);
  }
}

class TorrentStreamerView extends StatefulWidget {
  final String item;

  const TorrentStreamerView({Key key, this.item}) : super(key: key);

  @override
  _TorrentStreamerViewState createState() => _TorrentStreamerViewState();
}

class _TorrentStreamerViewState extends State<TorrentStreamerView> {
  @override
  void initState() {
    Provider.of<CurrentPlayingVideoPM>(context, listen: false)
        .init(widget.item);
    super.initState();
  }

  @override
  void dispose() {
    print("Disposed");
    TorrentStreamer.stop();
    TorrentStreamer.removeEventListeners();
    super.dispose();
  }

  Future<void> _openVideo(BuildContext context, bool isCompleted) async {
    if (isCompleted) {
      await TorrentStreamer.launchVideo();
    } else {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Are You Sure?'),
              content: new Text(
                  'Playing video while it is still downloading is experimental ' +
                      'and only works and Tested upon MXPlayer.'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Yes, Proceed"),
                  onPressed: () async {
                    await TorrentStreamer.launchVideo();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CurrentPlayingVideoPM>(context);
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                child: model.hasError
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'An Error Occured while connecting!',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            LinearProgressIndicator(
                                value: !model.isFetchingMeta
                                    ? model.progress / 100
                                    : null),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                model.isFetchingMeta
                                    ? 'An Error Occured while connecting!'
                                    : 'Progress: ${model.progress.floor().toString()}% - ' +
                                        'Speed: ${Utils.toKBPS(model.speed)} KB/s',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: IconButton(
                    onPressed: () {
                      TorrentStreamer.stop();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: RaisedButton(
                    disabledColor: Colors.grey,
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: !model.isStreamReady
                            ? Text(
                          model.isFetchingMeta
                              ? 'Fetching MetaData'
                              : 'Please Wait',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text('Play Video',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    color: Colors.red,
                    onPressed: model.isStreamReady
                        ? () => _openVideo(context, model.isCompleted)
                        : null),
              ),
            )
          ],
        ));
  }
}
