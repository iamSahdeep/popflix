import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_torrent_streamer/flutter_torrent_streamer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popflix/CORE/ProviderModels/AnimeDetailsPM.dart';
import 'package:popflix/CORE/ProviderModels/CurrentPlayingVideoPM.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/CORE/ProviderModels/NetworkHandlerPM.dart';
import 'package:popflix/CORE/ProviderModels/ShowDetailsPM.dart';
import 'package:popflix/CORE/ProviderModels/UIUpdatesPM.dart';
import 'package:popflix/UI/Screens/HomeScreen.dart';
import 'package:popflix/UI/Screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
//  final Directory saveDir = await getExternalStorageDirectory();
  runApp(MyApp());
  Directory directory = await getTemporaryDirectory();
  await TorrentStreamer.init(TorrentStreamerOptions(
      removeFilesAfterStop: false, saveLocation: directory.path, port: 45464));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NetworkHandlerPM>(
              create: (_) => NetworkHandlerPM()),
          ChangeNotifierProvider<DataFetcherPM>(create: (_) => DataFetcherPM()),
          ChangeNotifierProxyProvider<DataFetcherPM, UIUpdatePM>(
              create: (_) => UIUpdatePM(),
              update: (_, foo, bar) {
                bar.allMovies = foo.allMovies;
                bar.allShows = foo.allShows;
                return bar;
              }),
          ChangeNotifierProvider<ShowDetailsPM>(create: (_) => ShowDetailsPM()),
          ChangeNotifierProvider<CurrentPlayingVideoPM>(
              create: (_) => CurrentPlayingVideoPM()),
          ChangeNotifierProvider<AnimeDetailsPM>(
              create: (_) => AnimeDetailsPM()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          routes: {
            SplashScreen.Route: (context) => SplashScreen(),
            HomeScreen.Route: (context) => HomeScreen(),
          },
          home: SplashScreen(),
        ));
  }
}
