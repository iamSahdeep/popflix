import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: widget.item.images.fanart,
          height: size.height / 2 + 60,
          width: size.width,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              ShimmerBox(
                width: size.width,
                height: size.height / 2 + 60,
              ),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
        Container(
          color: Colors.black.withOpacity(.7),
          height: size.height / 2 + 60,
          width: size.width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: size.height / 2,
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
              height: 60,
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
                          widget.item.genres[index],
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
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
      ],
    );
  }
}
