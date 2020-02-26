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
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomeScreen> {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final networkModel = Provider.of<NetworkHandlerPM>(context);
    return networkModel.isConnected
        ? Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: TabBar(
        controller: tabController,
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
                Icons.settings,
                size: 20,
              ),
              text: "Settings",
              iconMargin: EdgeInsets.all(4)),
        ],
      ),
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: Container(
          color: Colors.black,
          width: size.width,
          height: size.height,
          child: TabBarView(
              controller: tabController,
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

  Future<bool> onBackPressed() async {
    if (tabController.index != 0) {
      tabController.animateTo(0);
      return false;
    } else
      return true;
  }
}
