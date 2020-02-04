import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpisodeItemCard extends StatefulWidget {
  final item;
  final String image;

  const EpisodeItemCard({Key key, this.item, this.image}) : super(key: key);

  @override
  _EpisodeItemCardState createState() => _EpisodeItemCardState();
}

class _EpisodeItemCardState extends State<EpisodeItemCard> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.scaleDown,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "E" +
                            item.episode.toString() +
                            "  S" +
                            item.season.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white70,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.overview
                  .toString()
                  .split(".")
                  .last,
              maxLines: 3,
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
