import 'package:flutter/material.dart';
import 'package:flutterquiz/provider/question_provider.dart';
import 'package:flutterquiz/provider/score_provider.dart';
import 'package:flutterquiz/screen/dashboard.dart';
import 'package:flutterquiz/util/router.dart';
import 'package:flutterquiz/util/router_path.dart';
import 'package:provider/provider.dart';

void main() {runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => QuestionProvider() ,
      ),
      ChangeNotifierProvider(
        create: (_)=>ScoreProvider(),
      )
    ],
      child: MyApp(),
    )
);

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routerr.generateRouter,
      initialRoute: SplashScreen,
    );
  }
}