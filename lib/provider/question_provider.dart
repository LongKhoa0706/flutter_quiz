import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/model/categories.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/service/api_service.dart';
import 'package:provider/provider.dart';

class QuestionProvider with ChangeNotifier {
  var api = API_Service();
  List<Question> listQuestion = [];
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int currentIndex = 0;

  Map<int,dynamic> answer = {};


  Future<List<Question>> getDataQuestion(String difficulty,int totalQuestion,int categoriesId) async {
    String url = "${api.baseURL}?amount=$totalQuestion&category=$categoriesId&difficulty=$difficulty";
    var dio = Dio();
    var res = await dio.get(url);
    if (res.statusCode == 200) {
      var jsonData = res.data;
      for(var i in jsonData['results']){
        listQuestion.add(Question.fromJson(i));
      }
    }
    _isLoading =false;
    notifyListeners();
    return listQuestion;
  }

  void selectRadio(dynamic e){
      answer[currentIndex] = e;
      print(currentIndex);
      notifyListeners();
  }

  void submitQuiz(List<Question> listQuestion){
    notifyListeners();
    if (currentIndex < (listQuestion.length - 1) ) {
      currentIndex ++;
      notifyListeners();
    }
    notifyListeners();
  }


}