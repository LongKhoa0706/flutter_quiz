import 'package:flutter/material.dart';
import 'package:flutterquiz/util/constant.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: false,

        backgroundColor: Colors.white,
        title: Text("Score History",
          style: kHeadingTextStyleAppBar,),
      ),
    );
  }
}
