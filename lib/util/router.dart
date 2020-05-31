
import 'package:flutter/material.dart';
import 'package:flutterquiz/screen/dashboard.dart';
import 'package:flutterquiz/screen/quiz_finish_screen.dart';
import 'package:flutterquiz/screen/quiz_screen.dart';
import 'package:flutterquiz/util/router_path.dart';


class Router {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case DashBoardScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardPage());
      case QuizScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => QuizPage(
            difficult: argument,
            listQuestion: argument,
            id: argument,
          ),
        );
      case QuizFinishScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(builder: (_) => QuizFinishPage(title: argument));
    }
  }
}