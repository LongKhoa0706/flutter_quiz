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

  }

  @override
  Widget build(BuildContext context) {
    List<int> abc = List<int>.generate(widget.listQuestion.length, (i) =>i  ); // convert array to int
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kItemSelectBottomNav,
          elevation: 0.0,
          leading: IconButton(
            onPressed: (){
              buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
                  , DialogType.WARNING, ()=>Navigator.pop(context));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
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
                                ...abc.map((e) => SizedBox(
                                  height: 15,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: InkWell(
                                      onTap: (){
                                       value.selectQuestion(e);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15,right: 10),
                                        child: Container(
                                          width: 20,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: value.currentIndex == e ? Colors.grey[200] : Color(0xff7146ff),
                                          ),
                                          child: Center(
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
                                  )
                                )),
                              ],
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                          const SizedBox(
                            height: 10,
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
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    color: Colors.grey.withOpacity(.2),
                                  ),
                                  BoxShadow(
                                    offset: Offset(-3, 0),
                                    blurRadius: 15,
                                    color: Color(0xffb8bfce).withOpacity(.1),
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
                                                ),
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
        , DialogType.WARNING, ()=>Navigator.pop(context,true));
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
