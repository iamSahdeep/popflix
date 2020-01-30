import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTabScreen extends StatefulWidget {
  @override
  _SearchTabScreenState createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Search",style: TextStyle(color: Colors.white),),
    );
  }
}
