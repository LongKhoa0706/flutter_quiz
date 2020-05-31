import 'package:flutter/material.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/provider/question_provider.dart';
import 'package:flutterquiz/screen/quiz_screen.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:provider/provider.dart';

class QuizBottomSheet extends StatefulWidget {
  final String title;
  final IconData iconData;
  final int id;

  const QuizBottomSheet({Key key, @required this.title, @required this.iconData, this.id}) : super(key: key);

  @override
  _QuizBottomSheetState createState() => _QuizBottomSheetState();
}

class _QuizBottomSheetState extends State<QuizBottomSheet> {
  int selectNumber;
  String selectDifficult;
  String selectType;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(widget.iconData),
            Text(widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Select Total Number of Questions"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNumberQuestion(10),
                _buildNumberQuestion(20),
                _buildNumberQuestion(30),
                _buildNumberQuestion(40),
                _buildNumberQuestion(50),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Select Difficulty"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDifficultQuestion("Any"),
                _buildDifficultQuestion("Easy"),
                _buildDifficultQuestion("Medium"),
                _buildDifficultQuestion("Hard"),
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            Center(
              child:  Consumer<QuestionProvider>(
                builder: (BuildContext context, QuestionProvider value, Widget child) {
                  return value.isLoading  ? CircularProgressIndicator() :  RaisedButton(
                    color: kItemSelectBottomNav,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    onPressed: ()  =>  _startQuiz(value),
                    child: Text("Start Quiz",
                      style: kHeadingTextStyleAppBar.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  _buildNumberQuestion(int number){
    return InkWell(
      onTap: () {
        setState(() {
          selectNumber = number;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 5,
              color: Colors.white,
            ),
            BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 5,
              color: Color(0xffb8bfce).withOpacity(.1),
            ),
          ],
          color: selectNumber == number ? kItemSelectBottomNav : Colors.grey[200],
        ),
        child: Text(number.toString(),
            style: selectNumber == number
                ? TextStyle(color: Colors.white,fontWeight: FontWeight.bold)
                : TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  _buildDifficultQuestion(String difficult) {
    return InkWell(
      onTap: (){
        setState(() {
          selectDifficult = difficult;
        });
      },
      child: Container(
        width: 70,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 5,
              color: Colors.white,
            ),
            BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 5,
              color: Color(0xffb8bfce).withOpacity(.1),
            ),
          ],
          color: selectDifficult == difficult ? kItemSelectBottomNav : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(difficult, style: selectDifficult == difficult
            ? TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
            : TextStyle(color: Colors.black),),),
      ),
    );
  }

  _startQuiz(QuestionProvider value) async {
    value.isLoading = true;
    if (  selectDifficult != null && selectNumber != null  ) {//
      print('dang khoi tai progrs');
      List<Question> listQuestion =  await value.getDataQuestion(selectDifficult.toLowerCase(), selectNumber, widget.id);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QuizPage(difficult: selectDifficult ,id: widget.id,listQuestion: listQuestion,)));
      print('ket thuc proess');
    }else{
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 800),
        elevation: 5.0,
        content: Text('Please choose option!',
      ),);
      globalKey.currentState.showSnackBar(snackBar);
    }
  }
}
