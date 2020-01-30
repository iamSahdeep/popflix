import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrailersTabScreen extends StatefulWidget {
  @override
  _TrailersTabScreenState createState() => _TrailersTabScreenState();
}

class _TrailersTabScreenState extends State<TrailersTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Trailer",style: TextStyle(color: Colors.white),),
    );
  }
}
