
import 'package:flutter/material.dart';

class SnackBars {
  static buildMessage(BuildContext context, String message ){
    final showSnackBar = SnackBar(content: Text(message),duration: Duration(milliseconds: 1000),);
    Scaffold.of(context).showSnackBar(showSnackBar);
  }
}