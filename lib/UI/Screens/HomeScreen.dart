import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/NetworkHandlerPM.dart';
import 'package:popflix/UI/Screens/MainTabScreen.dart';
import 'package:popflix/UI/Screens/MoreTabScreen.dart';
import 'package:popflix/UI/Screens/SearchTabScreen.dart';
import 'package:popflix/UI/Screens/TrailersTabScreen.dart';
import 'package:provider/provider.dart';

import 'NoInternetScreen.dart';

class HomeScreen extends StatefulWidget {
  static const Route = "/homescreen";
  static const DebugTag = "TAG - HOME_SCREEN";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final networkModel = Provider.of<NetworkHandlerPM>(context);
    return networkModel.isConnected
        ? DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.transparent,
          labelStyle: TextStyle(fontSize: 12),
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: false,
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              text: "Home",
              iconMargin: EdgeInsets.all(4),
            ),
            Tab(
                icon: Icon(
                  Icons.search,
                  size: 20,
                ),
                text: "Search",
                iconMargin: EdgeInsets.all(4)),
            Tab(
                icon: Icon(
                  Icons.airplay,
                  size: 20,
                ),
                text: "Trailers",
                iconMargin: EdgeInsets.all(4)),
            Tab(
                icon: Icon(
                  Icons.dehaze,
                  size: 20,
                ),
                text: "More",
                iconMargin: EdgeInsets.all(4)),
          ],
        ),
        body: Container(
          color: Colors.black,
          width: size.width,
          height: size.height,
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                MainScreenTab(),
                SearchTabScreen(),
                TrailersTabScreen(),
                MoreTabScreen(),
              ]),
        ),
      ),
    )
        : NoInternetScreen();
  }

  @override
  bool get wantKeepAlive => true;
}
