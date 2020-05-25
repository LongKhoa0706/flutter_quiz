import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/model/categories.dart';
import 'package:flutterquiz/util/constant.dart';

class CardItem extends StatelessWidget {
  final int index;
  
  const CardItem({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: Colors.grey.withOpacity(.3),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: Color(0xffb8bfce).withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(categories[index].icon),
            Text(categories[index].name,style: kHeadingTextStyleAppBar.copyWith(fontSize: 18),),
          ],
        ),
      );
  }
}
