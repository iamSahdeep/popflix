import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/UI/Shared/AnimeWorthWatch.dart';
import 'package:popflix/UI/Shared/BingeWorthyTVShows.dart';
import 'package:popflix/UI/Shared/PopularMovies.dart';
import 'package:popflix/UI/Shared/PopularOnList.dart';
import 'package:popflix/UI/Shared/ShimmerEffectBox.dart';
import 'package:popflix/UI/Shared/SingleFirstPosterFeaturedItem.dart';
import 'package:popflix/UI/Shared/TrailerView.dart';
import 'package:provider/provider.dart';

class MainScreenTab extends StatefulWidget {
  @override
  _MainScreenTabState createState() => _MainScreenTabState();
}

class _MainScreenTabState extends State<MainScreenTab> {
  @override
  Widget build(BuildContext context) {
    final hsModel = Provider.of<DataFetcherPM>(context);
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: hsModel.allMovies.isNotEmpty &&
                hsModel.allShows.isNotEmpty &&
                hsModel.allAnimes.isNotEmpty
            ? Column(
                children: <Widget>[
                  SingleFirstPosterFeaturedItem(item: hsModel.allMovies[0]),
                  BingeWorthTVShows(),
                  PopularMovies(),
                  AnimesWorthWatch(),
                  TrailerView(),
                  PopularOnList(name: "action"),
                  PopularOnList(
                    name: "crime",
                  ),
                  PopularOnList(
                    name: "family",
                  )
                ],
              )
            : ShimmerBox(
          width: size.width,
          height: size.height,
        ),
      ),
    );
  }
}
