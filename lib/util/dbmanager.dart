import 'dart:async';
import 'package:flutterquiz/model/score.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManger{
  static Database database;

  Future openDatabasee() async {
    if (database == null) {
      String path = join(await getDatabasesPath(),'score.db');
      database = await openDatabase(path,version: 1,onCreate: initDatabase);
    }  
  }

  Future initDatabase(Database database,int version) async {
    await database.execute('CREATE TABLE score(id INTEGER PRIMARY KEY AUTOINCREMENT, nameUser TEXT , categories TEXT, score INTEGER, date TEXT, totalAnswer INTEGER, totalQuestion INTEGER )');
  }

  Future<int> addUserScore(Score score) async{
    await openDatabasee();
    return await database.insert('score', score.toJson());
  }

  Future<int> deleteScore(int id )async {
    await openDatabasee();
    return await database.delete('score',where: "id = ? ",whereArgs: [id]);
  }

  Future<List<Score >> getUserScore() async {
    List<Score> arrUserScore = [];
    await openDatabasee();
    var res = await database.query('score');
    res.forEach((element) {
      arrUserScore.add(Score.fromJson(element));
    });
    return arrUserScore;
  }
}