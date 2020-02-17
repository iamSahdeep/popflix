import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/Helpers/Prefs.dart';
import 'package:popflix/UI/Screens/HomeScreen.dart';

class GetPrefsDetailsScreen extends StatefulWidget {
  static const Route = "getPrefsDetailsScreen";

  @override
  _GetPrefsDetailsScreenState createState() => _GetPrefsDetailsScreenState();
}

class _GetPrefsDetailsScreenState extends State<GetPrefsDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  TextEditingController textEditingController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add your name to get better experience Or we can call you Robot..',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: kToolbarHeight),
                      child: SizedBox(
                        height: kToolbarHeight * 2.5,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                child: Container(
                                  height: kToolbarHeight,
                                  width: size.width / 1.2,
                                  margin: EdgeInsets.only(
                                      right: 0, top: 3, bottom: 3, left: 10),
                                  child: TextField(
                                    controller: textEditingController,
                                    cursorWidth: 2,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      fontFamily: 'Righteous',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w200,
                                      wordSpacing: 2,
                                      fontSize: kToolbarHeight / 2.3,
                                      letterSpacing: 2,
                                      color: Colors.red,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(color: Colors.red),
                                        hintText: "Name",
                                        border: InputBorder.none),
                                    cursorColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: kToolbarHeight * 1.3,
                                width: kToolbarHeight * 2,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (textEditingController.text.isEmpty ||
                                        textEditingController.text == "")
                                      return;
                                    Prefs.saveName(textEditingController.text);
                                    Prefs.changeFirstRunToFalse();
                                    Navigator.of(context)
                                        .pushReplacementNamed(HomeScreen.Route);

                                    //tabController.animateTo(1);
                                  },
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  child: Text('Search',
                                      style: TextStyle(fontSize: 24)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: InkResponse(
                        onTap: () {
                          Prefs.saveName("Robot");
                          Prefs.changeFirstRunToFalse();
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.Route);
                          //add more option in other tabs
                          // tabController.animateTo(1);
                        },
                        child: Column(
                          children: <Widget>[
                            Text('Skip, I am a Robot!!'),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(),
          Container()
        ],
      ),
    );
  }
}
