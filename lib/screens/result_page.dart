import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/screens/solutions_page.dart';
import 'package:quiz_app/utils/quiz.dart';

class ResultPage extends StatefulWidget {
  final List<bool> correctVsChosenAnswer;
  final List<Results> results;
  final List<String> chosenAnswerList;
  ResultPage({this.correctVsChosenAnswer, this.results, this.chosenAnswerList});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int totalCorrectAnswers = 0;
  String resultFraction;

//initState() is Called when this object is inserted into the tree.
//The framework will call this method exactly once for each [State] object it creates
  @override
  void initState() {
    super.initState();
    _getCorrectAnswer();
    resultFraction = '$totalCorrectAnswers / 10';
    addStarsToList();
  }

  //this method loops through correctVsChosenAnswer to collect elements that are true
  void _getCorrectAnswer() {
    for (int i = 0; i < widget.correctVsChosenAnswer.length; i++) {
      if (widget.correctVsChosenAnswer[i]) totalCorrectAnswers++;
    }
  }

  //starsList collects the total number of star images to display in column
  List<Widget> starsList = [];
//addStarsToList() uses resultPercentage to determine the number of star images to add into starsList
  void addStarsToList() {
    int totalStars;
    if (totalCorrectAnswers == 10) {
      totalStars = 5;
    } else if (totalCorrectAnswers >= 8) {
      totalStars = 4;
    } else if (totalCorrectAnswers >= 6) {
      totalStars = 3;
    } else if (totalCorrectAnswers >= 4) {
      totalStars = 2;
    } else if (totalCorrectAnswers >= 2) {
      totalStars = 1;
    } else {
      totalStars = 0;
    }
    if (totalStars > 0) {
      for (int i = 0; i < totalStars; i++) {
        starsList
            .add(Image.asset('images/star.png', height: 45.0, width: 45.0));
      }
    } else {
      starsList.add(Text('You earned no star', style: noStarTextStyle));
    }
  }

  Text getResultStatusText() {
    String text;
    if (totalCorrectAnswers >= 5) {
      text = 'Well done, you rocked it!';
    } else {
      text = 'Better luck next time!';
    }
    return Text(text, style: resultStatusTextStyle);
  }

  Padding navigateButton(String title, Function navigateTo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(11.0),
            decoration: newQuizButtonContainerStyle,
            child: Text(title, style: newQuizButtonTitle),
          ),
          onTap: navigateTo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepPurpleColor,
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: starsList),
                Text(resultFraction, style: resultFractionStyle),
                getResultStatusText(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  navigateButton('Check Solutions', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SolutionsPage(
                                results: widget.results,
                                chosenAnswersList: widget.chosenAnswerList)));
                  }),
                  navigateButton('Take new quiz', () => Navigator.pop(context)),
                ]),
              ]),
        ),
      ),
    );
  }
}
