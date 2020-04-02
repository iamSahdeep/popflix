import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popflix/CORE/ProviderModels/DataFetcherPM.dart';
import 'package:popflix/UI/Shared/TrailerView.dart';
import 'package:provider/provider.dart';

class TrailersTabScreen extends StatefulWidget {
  @override
  _TrailersTabScreenState createState() => _TrailersTabScreenState();
}

class _TrailersTabScreenState extends State<TrailersTabScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final model = Provider.of<DataFetcherPM>(context);
    final data = model.newMovies;
    return SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: ListView.builder(itemBuilder: (context, index) {
            if (data[index].trailer != null && data[index].trailer.isNotEmpty)
              return TrailerView(itemt: data[index], showDetails: true);
            else
              return SizedBox();
          }),
        ));
  }
}
