import 'package:flutter/material.dart';
import 'package:quiz_app/utils/quiz.dart';
import 'package:quiz_app/screens/quiz_page.dart';
import 'package:quiz_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RaisedButton _difficultyButton(int questionType, String difficulty,
      String difficultyTitle, String appBarTitle) {
    return RaisedButton(
        color: whiteColor,
        elevation: 6.0,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizPage(
                        questionType: questionType,
                        difficulty: difficulty,
                        appBarTitle: appBarTitle,
                      )));
        },
        child: Text(difficultyTitle, style: difficultyButtonStyle));
  }

  ListView getCategoryUI() {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: questionTypeList.length,
        itemBuilder: (context, i) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 33.0, horizontal: 35.0),
              child: GestureDetector(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: categoryContainerDecoration,
                    alignment: Alignment.center,
                    child: Text(
                      questionTypeList[i].questionType,
                      style: categoryTextDecoration,
                    )),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 98.0),
                            child: AlertDialog(
                                backgroundColor: deepPurpleColor,
                                title: Text(questionTypeList[i].questionType,
                                    style: alertTitleStyle),
                                content: Column(children: <Widget>[
                                  Text('Select difficulty:',
                                      style: TextStyle(
                                          color: Color(0xFFC5C7CE),
                                          fontSize: 21.0)),
                                  _difficultyButton(
                                      questionTypeList[i].questionID,
                                      'easy',
                                      'Easy',
                                      questionTypeList[i].questionType),
                                  _difficultyButton(
                                      questionTypeList[i].questionID,
                                      'medium',
                                      'Medium',
                                      questionTypeList[i].questionType),
                                  _difficultyButton(
                                      questionTypeList[i].questionID,
                                      'hard',
                                      'Hard',
                                      questionTypeList[i].questionType),
                                ])),
                          ));
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Category', style: appBarStyle),
        ),
        backgroundColor: deepPurpleColor,
        body: getCategoryUI());
  }
}
