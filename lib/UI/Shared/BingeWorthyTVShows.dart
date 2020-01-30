import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/UI/Shared/MovieItemCard.dart';
import 'package:provider/provider.dart';

class BingeWorthTVShows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hsModel = Provider.of<DataFetcherPM>(context);
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical : 10.0),
            child: Text(
              "Bingeworthy TV Shows",
              style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height : MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
                itemCount: hsModel.getBingeWorthMovies().length,
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  return MovieItemCard(
                    item: hsModel.getBingeWorthTVShows()[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
