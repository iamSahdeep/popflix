import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/Helpers/Prefs.dart';
import 'package:popflix/CORE/Helpers/Strings.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetMoviesRM.dart';
import 'package:popflix/CORE/Models/ApiRM/GetShowsRM.dart';
import 'package:popflix/UI/Screens/AnimeDetailsScreen.dart';
import 'package:popflix/UI/Screens/MovieDetailsScreen.dart';
import 'package:popflix/UI/Screens/ShowDetailsScreen.dart';
import 'package:popflix/UI/Shared/ShimmerEffectBox.dart';

class MovieItemCard extends StatefulWidget {
  final item;
  final bool showLeftTime;

  const MovieItemCard({Key key, this.item, this.showLeftTime = false})
      : super(key: key);

  @override
  _MovieItemCardState createState() => _MovieItemCardState();
}

class _MovieItemCardState extends State<MovieItemCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: (){
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 1),
          content: Text(widget.item.title??"Error Occurred"),
        ));
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget.item is Movie
              ? MovieDetailsScreen(movie: widget.item)
              : widget.item is Show
              ? ShowDetailsScreen(
            show: widget.item,
          )
              : AnimeDetailsScreen(
            show: widget.item,
          );
        }));
      },
      child: SizedBox(
        height: size.height / 5,
        width: size.width / 3.5,
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.item.images.banner ?? Strings.tempUrl,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) =>
                  ShimmerBox(
                    width: size.height / 5,
                    height: size.width / 3.5,
                  ),
              errorWidget: (context, url, error) =>
                  Container(
                    height: size.height / 5,
                    width: size.width / 3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                        Text("Couldn't Load Poster",style:  TextStyle(color: Colors.white,fontSize: 13),textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
            ),
            widget.item is Anime
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.black,
                      height: 20,
                      width: size.width / 3.5,
                      child: Text(
                        widget.item.title,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
                : widget.item is Movie &&
                Prefs.getMoviesContinueWatching()
                    .contains(widget.item.imdbId) && widget.showLeftTime
                ? Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.red,
                height: 3,
                width: (Prefs.getMovieLastPoint(widget.item.imdbId) / 100) *
                    size.width / 3.5,
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
