
import 'package:flutter/material.dart';
import 'package:flutterquiz/model/score.dart';
import 'package:flutterquiz/util/dbmanager.dart';
import 'package:provider/provider.dart';

class ScoreProvider with ChangeNotifier{

  DbManger dbManger = DbManger();

  List<Score> arrScore = [];


  Future<Score> addScore(String nameUser,String categories,int scoree) async{
    Score score = Score(nameUser: nameUser,categories: categories,score: scoree);
    await dbManger.addUserScore(score);
    notifyListeners();
    return score;
  }

  Future<List<Score>> getAllScore() async {
   await dbManger.getUserScore().then((value) => {
      arrScore = value
    });
    notifyListeners();
    return arrScore;
  }
}