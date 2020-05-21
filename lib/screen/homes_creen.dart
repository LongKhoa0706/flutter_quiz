import 'package:flutter/material.dart';
import 'package:flutterquiz/model/categories.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:flutterquiz/widget/card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: false,

        backgroundColor: Colors.white,
        title: Text("Home",
        style: kHeadingTextStyleAppBar,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GridView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (_,int index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15,right:10 ,left: 10),
                    child: CardItem(
                      index: index,
                    ),
                  );
              })
            ],
          ),
        ),
      ),
    );
  }
}
