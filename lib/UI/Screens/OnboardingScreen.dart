import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:popflix/UI/Screens/GetPrefsDetailsScreen.dart';

class FirstRunScreens extends StatefulWidget {
  static const Route = "firstrunscreenroute";

  @override
  _FirstRunScreensState createState() => _FirstRunScreensState();
}

class _FirstRunScreensState extends State<FirstRunScreens> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "BROWSE",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Browse from thousands of movies and TV shows and even your favourite Animes. Get all trending and new release on your main screen with previews Or you can search from the OCEAN.",
                              maxLines: 5,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 2,
                    child: Image.asset(
                      "assets/itachi.png",
                      fit: BoxFit.fitWidth,
                    ),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    "Swipe Left",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
      Container(
        height: size.height,
        width: size.width,
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "WATCH",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Watch any movie or TV Show as many times as you want. All you need is a proper internet connection. We are backed with PopcornTime Api's. Popcorn Time is constantly searching all over the web for the best torrents.",
                        maxLines: 5,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height / 2,
              child: Image.asset(
                "assets/watching-potato.gif",
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      ),
      Container(
        height: size.height,
        color: Colors.white,
        width: size.width,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "CHILL",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 70,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No Restrictions to the watch limit, watch as many time you want. Remember to use VPN for your Anonimity and Stream with MXPlayer. Only for Educational Purpose.\nALL SET, LETS GOOOO",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 2,
                  child: Image.asset(
                    "assets/saxophone-png.png",
                    fit: BoxFit.scaleDown,
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(GetPrefsDetailsScreen.Route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      " Let's Go  -->",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false,
        waveType: WaveType.liquidReveal,
        enableSlideIcon: false,
      ),
    );
  }
}
