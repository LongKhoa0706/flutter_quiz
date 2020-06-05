import 'package:flutter/material.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/provider/score_provider.dart';
import 'package:flutterquiz/screen/dashboard.dart';

import 'package:flutterquiz/screen/homes_screen.dart';
import 'package:flutterquiz/screen/show_question_screen.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:flutterquiz/widget/button.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuizFinishPage extends StatefulWidget {
  final String title;
  final Map<int,dynamic> answer;
  final List<Question> listQuestion;

  const QuizFinishPage({Key key, @required this.title, this.answer, this.listQuestion}) : super(key: key);

  @override
  _QuizFinishPageState createState() => _QuizFinishPageState();
}

class _QuizFinishPageState extends State<QuizFinishPage> {
  int correct = 0 ;
  int incorrect = 0;
  int score = 0 ;
  final nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    widget.answer.forEach((key, value) {
      if (widget.listQuestion[key].correctAnswer == value) {
        correct ++;
        score +=10;
      }else{
        incorrect ++;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ballon2.png'),
                    fit: BoxFit.cover
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ballon4.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ballon2.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ballon4.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: Image.asset('assets/congratulate.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your Score : ",
                        style: kHeadingTextStyleAppBar.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "$score",
                        style: kHeadingTextStyleAppBar.copyWith(
                          fontSize: 24,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You have successfully completed",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(widget.title,style: kHeadingTextStyleAppBar.copyWith(
                    fontSize: 25
                  ),),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Chip(

                        elevation: 5.0,
                        shadowColor: Colors.black54,
                      backgroundColor: Colors.grey[200],
                      label: Row(
                        children: <Widget>[
                          Icon(Icons.check,color: Colors.green,),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("$correct  correct"),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Chip(
                        elevation: 5.0,
                        shadowColor: Colors.black54,
                        backgroundColor: Colors.grey[200],
                        label: Row(
                          children: <Widget>[
                            Icon(Icons.close,color: Colors.red,),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$incorrect incorrect"),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                  ],
                ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 280,
                    child: Button(
                        title: 'Show Question',
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowQuestionScreen(
                            answer: widget.answer,
                            listQuestion: widget.listQuestion,)));
                        },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 280,
                    child: Button(
                        title: 'Save Score',
                        onTap: (){
                          _buildDialogSaveScore();
                        })
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 280,
                      child: Button(
                          title: 'Home',
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>DashboardPage()), (e) => false);
                          })
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
   _buildDialogSaveScore(){
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration:
          const Duration(milliseconds: 100),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            width: double.infinity,
            height: 230,
            child: Column(
              children: <Widget>[
                Text('Save Score',
                style: kHeadingTextStyleAppBar.copyWith(
                  fontSize: 20
                ),),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Your Name",
                    prefixIcon: Icon(Icons.save),
                  ),
                ),
              ),
                SizedBox(
                  height: 20,
                ),
                Align(alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Text("Your Score: ",style: TextStyle(
                        fontSize: 18
                      ),),
                      SizedBox(
                        width: 8,
                      ),
                      Text(score.toString(),style: kHeadingTextStyleAppBar.copyWith(
                        fontSize: 18,
                        color: Colors.red
                      ),),
                    ],
                  ),),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: kItemSelectBottomNav,
                      onPressed: () {
                      },
                      child: Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    FlatButton(
                        onPressed: ()  => _saveScore(),
                        child: Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
   }
   _saveScore() async {
      var now =  DateTime.now();
     String datetime =  DateFormat.yMd().format(now);
     await Provider.of<ScoreProvider>(context,listen: false).addScore(nameController.text,
       widget.title, score,datetime ,correct,widget.listQuestion.length);
     Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>DashboardPage()), (e) => false);
   }
}
