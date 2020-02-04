import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:popflix/CORE/ProviderModels/ShowDetailsPM.dart';
import 'package:provider/provider.dart';

class SeasonsSelectScreen extends StatefulWidget {
  @override
  _SeasonsSelectScreenState createState() => _SeasonsSelectScreenState();
}

class _SeasonsSelectScreenState extends State<SeasonsSelectScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ShowDetailsPM>(context);
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: size.height / 2,
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.singleShowDetail.numSeasons,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          model.changeCurrentSeasonDisplay(index + 1);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Season ${index + 1}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
