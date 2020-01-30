import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimesRM.dart';

class MovieItemCard extends StatefulWidget {
  final item;

  const MovieItemCard({Key key, this.item}) : super(key: key);

  @override
  _MovieItemCardState createState() => _MovieItemCardState();
}

class _MovieItemCardState extends State<MovieItemCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 5,
      width: size.width / 3.5,
      child: Stack(
        children: <Widget>[
          Image.network(
            widget.item.images.banner,
            fit: BoxFit.fitHeight,
          ),
          widget.item is Anime
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.black87,
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
              : SizedBox()
        ],
      ),
    );
  }
}
