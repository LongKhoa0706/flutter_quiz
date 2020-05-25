import 'package:flutter/material.dart';
import 'package:flutterquiz/model/question.dart';
import 'package:flutterquiz/provider/question_provider.dart';
import 'package:flutterquiz/util/constant.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> listQuestion;
  final int id;
  final String difficult;

  const QuizScreen({Key key, this.listQuestion, @required this.id, this.difficult}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}


class _QuizScreenState extends State<QuizScreen> {
  final Map<int,dynamic> _answers = {};
//  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    var data = Provider.of<QuestionProvider>(context,listen: false);

    Question question = widget.listQuestion[data.currentIndex];
    final List<dynamic> listOptions = question.incorrectAnswers;
    if(!listOptions.contains(question.correctAnswer)) {
      listOptions.add(question.correctAnswer);
      print('cadsad');
      listOptions.shuffle();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: kItemSelectBottomNav,
        elevation: 0.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(

                  "Question ${data.currentIndex+1}/${widget.listQuestion.length}",
                  style: kHeadingTextStyleAppBar.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Difficult: ${widget.difficult}",
                  style: kHeadingTextStyleAppBar.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                  ),
                )
              ],
            )
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(HtmlUnescape().convert(widget.listQuestion[data.currentIndex].question),style:
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
                          color: Colors.grey.withOpacity(.3),
                        ),
                        BoxShadow(
                          offset: Offset(-3, 0),
                          blurRadius: 15,
                          color: Color(0xffb8bfce).withOpacity(.1),
                        ),
                      ],
                    ),
                    child: Consumer<QuestionProvider>(
                      builder: (BuildContext context, QuestionProvider value, Widget child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...listOptions.map((e) =>
                                RadioListTile(
                                  groupValue: value.answer[data.currentIndex],
                                  activeColor: Colors.red,
                                  title: Text(HtmlUnescape().convert(e)),
                                  onChanged: (abc) {
                                    value.selectRadio(e);
                                  },
                                  value: e,
                                )
                            ),
                          ],
                        ) ;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kItemSelectBottomNav,
                    onPressed: () {
                      data.submitQuiz(widget.listQuestion);
                    },
                    child: Text(data.currentIndex == widget.listQuestion.length-1 ? "Submit" : "Next",
                  style: kHeadingTextStyleAppBar.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),) ,
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
