import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/service/api_service.dart';
import 'package:provider/provider.dart';

class QuestionProvider with ChangeNotifier {
  var api = API_Service();

  Future getDataQuestion() async {
    var dio = Dio();
    var res = dio.get(api.baseURL);
  }

}