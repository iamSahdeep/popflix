import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/Helpers/PrefsHelper.dart';
import 'package:popflix/CORE/Models/ApiRM/GetAnimesRM.dart';
import 'package:popflix/CORE/ProviderModels/AnimeDetailsPM.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/UI/Screens/SeasonsListSelectorScreen.dart';
import 'package:popflix/UI/Shared/EpisodeItemCard.dart';
import 'package:popflix/UI/Shared/MovieItemCard.dart';
import 'package:popflix/UI/Shared/ShimmerEffectBox.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class AnimeDetailsScreen extends StatefulWidget {
  static const Route = "/Animedetailsscreen";
  static const DebugTag = "TAG - Anime_DETAILS_SCREEN";
  final Anime show;

  const AnimeDetailsScreen({Key key, this.show}) : super(key: key);

  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen>
    with AutomaticKeepAliveClientMixin<AnimeDetailsScreen> {
  bool isRated = false;
  bool isInMyList = false;

  @override
  void initState() {
    Provider.of<AnimeDetailsPM>(context, listen: false)
        .getShowDetails(widget.show.id);

    isRated = PrefsHelper.isMovieRatedByRobot(widget.show.id);
    isInMyList = PrefsHelper.isMovieInMyList(widget.show.id);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final modelS = Provider.of<AnimeDetailsPM>(context);
    final model = Provider.of<DataFetcherPM>(context);
    final show = modelS.singleAnimeDetail;
    return Scaffold(
      backgroundColor: Colors.black,
      body: show != null && show.id == widget.show.id
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: size.height / 3,
                  width: size.width,
                  foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black45, Colors.black87],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      )),
                  child: CachedNetworkImage(
                    imageUrl: widget.show.images.banner,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        ShimmerBox(
                          height: size.height / 3,
                          width: size.width,
                        ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 40,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Text(
                    show.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      show.year.toString(),
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Text(
                    show.rating.percentage.toString() + "% liked",
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      show.numSeasons.toString() + " Seasons",
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      show.status.toString(),
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
                show.synopsis,
                textAlign: TextAlign.left,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: Colors.white, fontSize: 13, wordSpacing: 2),
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
                        setState(() {
                          if (isInMyList) {
                            PrefsHelper.removeMoveFromMyWatchList(
                                widget.show.id);
                            isInMyList = false;
                          } else {
                            PrefsHelper.addMovieToMyWatchList(
                                widget.show.id);
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
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          if (isRated) {
                            PrefsHelper.removeMoveFromRatedList(
                                widget.show.id);
                            isRated = false;
                          } else {
                            PrefsHelper.addMovieToRatedList(
                                widget.show.id);
                            isRated = true;
                          }
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            color: isRated ? Colors.red : Colors.white,
                            size: 30,
                          ),
                          Text(
                            "Rate",
                            style: TextStyle(
                                color:
                                isRated ? Colors.red : Colors.white70,
                                fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Share.share(
                            "Check out this amazing App, I am watching" +
                                widget.show.title +
                                "on it.\n\n" +
                                modelS.singleAnimeDetail.synopsis
                                    .toString() +
                                " \n\n\nDownload it from https://github.com/iamSahdeeo/popflix",
                            subject: "Share Details Via");
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide:
                        BorderSide(width: 4, color: Colors.red),
                        insets: EdgeInsets.only(
                            left: 8, right: 8, bottom: 50)),
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(
                        left: 0, right: 0, bottom: 10, top: 10),
                    tabs: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Episodes",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "More Like This",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  body: TabBarView(children: <Widget>[
                    SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return SeasonsSelectScreen(
                                        isAnime: true,
                                      );
                                    }));
                              },
                              child: Text(
                                "Season ${modelS.currentSeasonToDisplay
                                    .toString()} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height - 150,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                modelS.episodesToDisplay.length,
                                itemBuilder: (context, index) {
                                  return EpisodeItemCard(
                                    item: modelS.episodesToDisplay[index],
                                    image: widget.show.images.banner,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 12,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisCount: 3,
                            childAspectRatio: 0.7),
                        itemBuilder: (context, index) {
                          return MovieItemCard(
                            item: model.getAnimesWithSameGenres(
                                widget.show)[index],
                          );
                        }),
                  ]),
                ),
              ),
            )
          ],
        ),
      )
          : ShimmerBox(
        width: size.width,
        height: size.height,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
