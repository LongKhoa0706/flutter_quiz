import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/service/api_service.dart';


class QuestionProvider with ChangeNotifier {
  var api = API_Service();
  List<Question> listQuestion = [];
  bool isLoading = false;
  String error = '';
  int currentIndex = 0;

  Map<int,dynamic> answer = {};


  Future<List<Question>> getDataQuestion(String difficulty,int totalQuestion,int categoriesId) async {
    String url = "${api.baseURL}?amount=$totalQuestion&category=$categoriesId&difficulty=$difficulty";
    var dio = Dio();
    print("dang load");
    isLoading = true;
    var res = await dio.get(url);
    if (res.statusCode == 200) {
      var jsonData = res.data;
      for(var i in jsonData['results']){
        listQuestion.add(Question.fromJson(i));
      }
    }
    isLoading =false;
    print('load xong');

    notifyListeners();
    dio.close();
    return listQuestion;
  }

  void selectRadio(dynamic e){
      answer[currentIndex] = e;
      notifyListeners();
      return;
  }

  Future<void> submitQuiz(List<Question> listQuestion) {
    if (currentIndex < (listQuestion.length - 1) ) {
      currentIndex ++;
      notifyListeners();
    }
    notifyListeners();
  }
}