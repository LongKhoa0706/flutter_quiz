import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const Button({Key key, @required this.title, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(5.0,5.0),
                color: Colors.grey[200],
              ),
              BoxShadow(
                blurRadius: 10,
                offset: Offset(3.0,3.0),
                color: Colors.grey[300],
              ),
            ]
        ),
        child: Center(
          child: Text(title,
          ),
        ),
      ),
    );
  }
}
