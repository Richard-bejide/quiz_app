import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/quiz.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/screens/result_page.dart';
import 'package:fileaudioplayer/fileaudioplayer.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizPage extends StatefulWidget {
  final int questionType;
  final String difficulty;
  final String appBarTitle;

  QuizPage({this.difficulty, this.questionType, this.appBarTitle});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Quiz quiz;
  List<Results> results;
  int questionNumber = 0; //stores the current question number
  List<bool> _correctVsChosenAnswer = []; //collects user's answer input as bool
  List<String> _chosenAnswersList = [];
  FileAudioPlayer audioPlayer = FileAudioPlayer();
  CountDownController _timerController =
      CountDownController(); //countdown timer's controller
  Future<List<Results>> _cacheResults; //caches fetched results
  //method to fetch result from api
  Future<List<Results>> fetchQuestions() async {
    var response = await http.get(
        "https://opentdb.com/api.php?amount=10&category=${widget.questionType}&difficulty=${widget.difficulty}&type=multiple");
    var decodeResponse = jsonDecode(response.body);
    //print(decodeResponse);
    quiz = Quiz.fromJson(decodeResponse);
    results = quiz.results;
    startAudio(); //starts countdown audio
    return results;
  }

//initState() is Called when this object is inserted into the tree.
//The framework will call this method exactly once for each [State] object it creates.
  @override
  void initState() {
    super.initState();
    _cacheResults = fetchQuestions(); //initializes _cacheResults
  }

//dispose() is called when this object is removed from the tree permanently.
  @override
  void dispose() {
    super.dispose();
    stopAudio(); //stops countdown audio when this object is removed from the stack
  }

  //method to play sound
  Future<void> startAudio() async {
    final ByteData data = await rootBundle.load('assets/tick.mp3');
    Directory tempDir = await getApplicationDocumentsDirectory();
    File tempFile = File('${tempDir.path}/demo.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    String mp3Uri = tempFile.uri.toString();

    await audioPlayer.start(mp3Uri);
  }

  //method to stop playing sound
  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  // Navigates to ResultPage()
  void getResultPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                correctVsChosenAnswer: _correctVsChosenAnswer,
                results: results,
                chosenAnswerList: _chosenAnswersList)));
  }

  Padding answerButton(int index) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(11.0),
              decoration: answerButtonContainerDecoration,
              alignment: Alignment.center,
              child: Text(
                  /* HtmlCharacterEntities.decode() Parses a [string] and replaces 
                  all valid HTML character entities with their respective characters.*/
                  (HtmlCharacterEntities.decode(
                      results[questionNumber].allAnswers[index])),
                  style: answerButtonTitleStyle),
            ),
            onTap: () {
              setState(() {
                _chosenAnswersList
                    .add(results[questionNumber].allAnswers[index]);
                stopAudio();
                startAudio();
                _timerController.restart();
                //checks if chosen answer equals correct answer
                if (results[questionNumber].allAnswers[index] ==
                    results[questionNumber].correctAnswer) {
                  _correctVsChosenAnswer.add(true);
                } else {
                  _correctVsChosenAnswer.add(false);
                }
              //  print(_correctVsChosenAnswer);
                //increments questionNumber by 1 only if it is less than 9
                if (questionNumber < 9) {
                  questionNumber++;
                } else {
                  //ends quiz if questionNumber equals than 9
                  getResultPage();
                }
              });
            }));
  }

  CircularCountDownTimer getTimer() {
    return CircularCountDownTimer(
      duration: 12,
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.height / 6,
      color: whiteColor,
      fillColor: pinkColor,
      strokeWidth: 2.0,
      controller: _timerController,
      strokeCap: StrokeCap.butt,
      textStyle: timerTextStyle,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      onComplete: () {
        setState(() {
          _chosenAnswersList.add('         ');
          _correctVsChosenAnswer.add(
              false); //adds false into _correctVsChosenAnswer since user didn't enter any answer
         // print(_correctVsChosenAnswer);
          stopAudio();
          startAudio();
          _timerController.restart();
          //ends quiz if question number equals 9
          if (questionNumber == 9) {
            getResultPage();
          }
          questionNumber++;
        });
      },
    );
  }

  Container questionUI() {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Container(
              height: 210.0,
              decoration: BoxDecoration(color: questionsContainerColor),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                      'Question ${(questionNumber + 1).toString()} of 10',
                      style: currentQuestionNumberStyle),
                ),
                getTimer(),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        /* HtmlCharacterEntities.decode() Parses a [string] and replaces 
                  all valid HTML character entities with their respective characters.*/
                        HtmlCharacterEntities.decode(
                            results[questionNumber].question),
                        style: questionsTextStyle)),
              ])),
          Padding(
            padding: const EdgeInsets.only(top: 23.0, right: 8.0, left: 8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              answerButton(
                  0), //shows the answer at results[questionNumber].allAnswers[0])
              answerButton(
                  1), //shows the answer at results[questionNumber].allAnswers[1])
              answerButton(
                  2), //shows the answer at results[questionNumber].allAnswers[2])
              answerButton(
                  3), //shows the answer at results[questionNumber].allAnswers[3])
            ]),
          ),
        ]));
  }

  //error shown if snapshot.hasError returns true
  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Something went wrong!', style: errorTextStyle),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: pinkColor,
            child: Text("Try Again", style: tryAgainButtonStyle),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle, style: appBarStyle)),
        backgroundColor: Color(0xFF272E4D),
        body: FutureBuilder(
            //Creates a widget that builds itself based on the latest snapshot of interaction with a [Future].
            future:
                _cacheResults, //async task called everytime the build method is called
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  //
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) return errorData(snapshot);
                  return questionUI();
              }
              return null;
            }));
  }
}
