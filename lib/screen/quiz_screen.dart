import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/provider/question_provider.dart';
import 'package:flutterquiz/provider/score_provider.dart';
import 'package:flutterquiz/screen/quiz_finish_screen.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:flutterquiz/util/router_path.dart';
import 'package:flutterquiz/widget/awesomedialog.dart';
import 'package:flutterquiz/widget/snackbar.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';


class QuizPage extends StatefulWidget {
  final List<Question> listQuestion;
  final int id;
  final String difficult;

  const QuizPage({Key key, @required this.listQuestion, @required this.id, @required this.difficult}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ScoreProvider>(context,listen: false).getAllScore();
    print(widget.listQuestion.length);
  }

  @override
  Widget build(BuildContext context) {
    List<int> listQuestionNumber = List<int>.generate(widget.listQuestion.length, (i) =>i  ); // convert array to int

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kItemSelectBottomNav,
          elevation: 0.0,
          leading: IconButton(
            onPressed: (){
              buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
                  , DialogType.WARNING, ()=>Navigator.pop(context),()=> null);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[

              Text(widget.listQuestion[widget.id].category,
                style: kHeadingTextStyleAppBar.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Difficult: ${widget.difficult}",
                style: kHeadingTextStyleAppBar.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white
                ),
              ),

            ],
          )
        ),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 50),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: kItemSelectBottomNav
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Consumer<QuestionProvider>(
                    builder: (BuildContext context, QuestionProvider value, Widget child) {
                      Question question = widget.listQuestion[value.currentIndex];
                      final List<dynamic> listOptions = question.incorrectAnswers;
                      if(!listOptions.contains(question.correctAnswer)) {
                        listOptions.add(question.correctAnswer);
                        listOptions.shuffle();
                      }
                      return Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Row(
                              children: <Widget>[
                                ...listQuestionNumber.map((e) => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: InkWell(
                                    onTap: (){
                                     value.selectQuestion(e);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15,right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: value.currentIndex == e ? Colors.grey[200] : Color(0xff7146ff),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Text(
                                              e.toString(),
                                              style: TextStyle(
                                                  color: value.currentIndex == e ? Colors.black : Colors.white,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Text(HtmlUnescape().convert(widget.listQuestion[value.currentIndex].question),style:
                            kHeadingTextStyleAppBar.copyWith(
                                color: Colors.white,
                                fontSize: 22
                            ),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20,),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                      ),
                                      BoxShadow(
                                        offset: Offset(10, 10),

                                        color: Colors.grey[200],
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ...listOptions.map((e) =>
                                          RadioListTile(
                                            groupValue: value.answer[value.currentIndex],
                                            activeColor: Colors.red,
                                            title: Text(HtmlUnescape().convert(e)),
                                            onChanged: (abc) {
                                              value.selectRadio(e);
                                            },
                                            value: e,
                                          ),
                                      ),
                                    ],
                                  ) ,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            child: Align(
                              child: SizedBox(
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: kItemSelectBottomNav,
                                  onPressed: () {
                                    if (value.answer[value.currentIndex] == null) {
                                      SnackBars.buildMessage(context, "Please checked answer!");
                                    } else if (value.currentIndex == widget.listQuestion.length -1 ) {
                                        buildDialog(
                                            context,
                                            "Finish?", "Are you sure finish quiz?",
                                            DialogType.SUCCES,
                                                ()=>Navigator.pushReplacement(context,
                                                    MaterialPageRoute(builder: (_)=>
                                                        QuizFinishPage(title: widget.listQuestion[widget.id].category,
                                                          answer: value.answer,
                                                          listQuestion: widget.listQuestion,
                                                        ),
                                                    ),
                                                ),()=>null,
                                        );
                                    }
                                    else{
                                      value.submitQuiz(widget.listQuestion);
                                    }
                                  },
                                  child: Text(value.currentIndex == widget.listQuestion.length-1 ? "Submit" : "Next",
                                    style: kHeadingTextStyleAppBar.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),) ,
                                ),
                              ),
                              alignment: Alignment.topRight,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress(){
    return   buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
        , DialogType.WARNING, ()=>Navigator.pop(context,true),()=>null);
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0.0, size.height -40);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width- (size.width /4 ), size.height, size.width,size.height-40);
    path.lineTo(size.width, 0.0);
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}
