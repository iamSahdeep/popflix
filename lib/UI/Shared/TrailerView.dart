import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:popflix/CORE/Helpers/PrefsHelper.dart';
import 'package:popflix/CORE/Helpers/Strings.dart';
import 'package:popflix/CORE/Helpers/Utils.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/UI/Screens/MovieDetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  final itemt;
  final bool showDetails;

  const TrailerView({Key key, this.itemt, this.showDetails = false})
      : super(key: key);

  @override
  _TrailerViewState createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  bool ismute = true;
  var temp;
  bool isInMyList;

  @override
  void initState() {
    temp = Provider.of<DataFetcherPM>(context, listen: false).getRandomItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id;
    var item;
    if (widget.itemt == null || widget.itemt.trailer
        .toString()
        .isEmpty) {
      item = temp;
      id = Utils.convertUrlToId(item.trailer);
    } else {
      item = widget.itemt;
      id = Utils.convertUrlToId(item.trailer);
    }

    isInMyList = PrefsHelper.isMovieInMyList(temp.imdbId);

    final size = MediaQuery
        .of(context)
        .size;
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
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.red, // Text colour here
                          width: 2.0, // Underline width
                        ))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Text colour here
                    ),
                  ),
                ),
              )),
          VisibilityDetector(
            key: Key(id),
            onVisibilityChanged: (VisibilityInfo info) {
              if (info.visibleFraction >= 1) {
                _controller.play();
              } else
                _controller.pause();
            },
            child: Stack(
              children: <Widget>[
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bufferIndicator: null,
                  bottomActions: <Widget>[],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        item.certification == null
                            ? "ND"
                            : item.certification
                            .toString()
                            .split(".")
                            .last,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MovieDetailsScreen(movie: item);
                      }));
                },
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
                onPressed: () {
                  setState(() {
                    if (isInMyList) {
                      PrefsHelper.removeMoveFromMyWatchList(item.imdbId);
                      isInMyList = false;
                    } else {
                      PrefsHelper.addMovieToMyWatchList(item.imdbId);
                      isInMyList = true;
                    }
                  });
                },
                disabledColor: Colors.grey,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      isInMyList ? Icons.check : Icons.add,
                      color: isInMyList ? Colors.red : Colors.black,
                      size: 20,
                    ),
                    Text(
                      "My List",
                      style: TextStyle(
                          color: isInMyList ? Colors.red : Colors.black,
                          fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          )
              : SizedBox(),
          widget.showDetails
              ? Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0),
                            child: CachedNetworkImage(
                              imageUrl:
                              item.images.poster ?? Strings.tempUrl,
                              fit: BoxFit.scaleDown,
                              height: size.height / 7,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          item.year.toString(),
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Text(
                        item.certification == null
                            ? "ND"
                            : item.certification
                            .toString()
                            .split(".")
                            .last,
                        style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          Utils.durationToString(int.parse(item.runtime)),
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    item.synopsis,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        wordSpacing: 2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: size.width / 10),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return MovieDetailsScreen(movie: item);
                                }));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                "Info",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Share.share(
                                "Check out this amazing App, I am watching " +
                                    item.title +
                                    " on it.\n\n" +
                                    item.synopsis.toString() +
                                    " \n\n\nDownload it from https://github.com/iamSahdeeo/popflix",
                                subject: "Share Details Via");
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
              : SizedBox()
        ],
      ),
    );
  }
}
