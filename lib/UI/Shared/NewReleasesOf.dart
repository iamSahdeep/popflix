import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:provider/provider.dart';

import 'MovieItemCard.dart';

class NewReleaseListOf extends StatefulWidget {
  final String name;

  const NewReleaseListOf({Key key, this.name}) : super(key: key);

  @override
  _NewReleaseListOfState createState() => _NewReleaseListOfState();
}

class _NewReleaseListOfState extends State<NewReleaseListOf> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> data;
    if (widget.name == "movies")
      data = Provider.of<DataFetcherPM>(context).newMovies;
    else if (widget.name == "shows") {
      data = Provider.of<DataFetcherPM>(context).newShows;
    } else {
      data = Provider.of<DataFetcherPM>(context).newAnimes;
    }

    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "New ${widget.name}",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  return MovieItemCard(
                    item: data[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
