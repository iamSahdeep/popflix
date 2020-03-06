import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/Helpers/PrefsHelper.dart';
import 'package:popflix/CORE/Models/ApiRM/GetMoviesRM.dart';
import 'package:popflix/UI/Screens/MovieDetailsScreen.dart';
import 'package:popflix/UI/Screens/WatchScreen.dart';
import 'package:popflix/UI/Shared/ShimmerEffectBox.dart';

class SingleFirstPosterFeaturedItem extends StatefulWidget {
  final Movie item;

  const SingleFirstPosterFeaturedItem({Key key, this.item}) : super(key: key);

  @override
  _SingleFirstPosterFeaturedItemState createState() =>
      _SingleFirstPosterFeaturedItemState();
}

class _SingleFirstPosterFeaturedItemState
    extends State<SingleFirstPosterFeaturedItem> {

  bool isInMyList = false;

  @override
  void initState() {
    isInMyList = PrefsHelper.isMovieInMyList(widget.item.imdbId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: widget.item.images.fanart,
          height: size.height * 2 /3,
          width: size.width,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              ShimmerBox(
                width: size.width,
                height: size.height * 2 /3,
              ),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
        Container(
          color: Colors.black.withOpacity(.5),
          height: size.height * 2 /3,
          width: size.width,
        ),
        Container(
          height: size.height *2/3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: size.height / 2 ,
                child: CachedNetworkImage(
                  imageUrl: widget.item.images.poster,
                  height: size.height / 2,
                  width: size.width,
                  fit: BoxFit.scaleDown,
                  placeholder: (context, url) =>
                      ShimmerBox(
                        width: size.width,
                        height: size.height / 2,
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.item.genres.length,
                    separatorBuilder: (context, lel) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.white,
                          ),
                        ),
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.item.genres[index].toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      );
                    }),
              ),

              Container(
                width: size.width,
                color: Colors.black.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            if (isInMyList) {
                              PrefsHelper.removeMoveFromMyWatchList(
                                  widget.item.imdbId);
                              isInMyList = false;
                            } else {
                              PrefsHelper.addMovieToMyWatchList(
                                  widget.item.imdbId);
                              isInMyList = true;
                            }
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              isInMyList ? Icons.check : Icons.add,
                              color: isInMyList ? Colors.red : Colors.white,
                              size: 30,
                            ),
                            Text(
                              "My List",
                              style: TextStyle(
                                  color: isInMyList ? Colors.red : Colors.white70,
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return TorrentStreamerView(
                                    item: widget.item.torrents.en["720p"].url);
                              }));
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                            Text(
                              "Play",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return MovieDetailsScreen(movie: widget.item);
                              }));
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text(
                              "Info",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}
