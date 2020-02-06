import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatefulWidget {
  final double height, width;

  const ShimmerBox({Key key, this.height, this.width}) : super(key: key);

  @override
  _ShimmerBoxState createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      loop: 10,
      period: Duration(seconds: 1),
      baseColor: Colors.black45,
      highlightColor: Colors.grey,
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.black54,
      ),
    );
  }
}
