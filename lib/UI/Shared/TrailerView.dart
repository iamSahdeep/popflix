import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:popflix/CORE/Helpers/Utils.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  final itemt;

  const TrailerView({Key key, this.itemt}) : super(key: key);

  @override
  _TrailerViewState createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  bool ismute = true;
  var temp;

  @override
  void initState() {
    temp = Provider.of<DataFetcherPM>(context, listen: false).getRandomItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id;
    var item;
    if (widget.itemt == null) {
      item = temp;
      id = Utils.convertUrlToId(item.trailer);
    } else {
      item = widget.itemt;
      id = Utils.convertUrlToId(item.trailer);
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: ismute,
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Text(
              item.title,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          VisibilityDetector(
            key: Key(id),
            onVisibilityChanged: (VisibilityInfo info) {
              if (info.visibleFraction > 0) {
                _controller.play();
              } else
                _controller.pause();
            },
            child: Stack(
              children: <Widget>[
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: false,
                  bottomActions: <Widget>[],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        item.certification.toString().split(".").last,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                /* Positioned(
                  bottom: 1,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (ismute) {
                          _controller.unMute();
                          ismute = false;
                        } else {
                          _controller.mute();
                          ismute = true;
                        }
                      });
                    },
                    icon: Icon(
                      ismute ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                    ),
                  ),
                )*/
              ],
            ),
          ),
          widget.itemt == null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: null,
                      disabledColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                          Text(
                            "Play",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: null,
                      disabledColor: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "My List",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
