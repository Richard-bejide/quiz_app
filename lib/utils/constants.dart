import 'package:flutter/material.dart';

const Color deepPurpleColor = Color(0xFF1D223A);
const Color whiteColor = Colors.white;
const Color pinkColor = Color(0xFFF51E5F);
const Color dimWhiteColor = Color(0xFFC5C7CE);

const Color questionsContainerColor = deepPurpleColor;

const TextStyle difficultyButtonStyle =
    TextStyle(color: deepPurpleColor, fontSize: 15.0);

BoxDecoration categoryContainerDecoration = BoxDecoration(
  color: Color(0xFF22294B),
  border: Border.all(width: 1.0, color: dimWhiteColor),
  borderRadius: BorderRadius.circular(15),
);

const TextStyle categoryTextDecoration = TextStyle(
    color: dimWhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    fontFamily: 'SourceSansPro');

const TextStyle alertTitleStyle = TextStyle(
    color: dimWhiteColor, fontSize: 26.0, fontFamily: 'SourceSansPro');

const TextStyle appBarStyle = TextStyle(
    fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'SourceSanPro');

const TextStyle noStarTextStyle = TextStyle(
    color: Colors.white70, fontSize: 17.0, fontFamily: 'SourceSansPro');

const TextStyle resultStatusTextStyle =
    TextStyle(color: whiteColor, fontSize: 24.0, fontFamily: 'SourceSansPro');
const resultFractionStyle = TextStyle(color: whiteColor, fontSize: 32.0);

BoxDecoration newQuizButtonContainerStyle = BoxDecoration(
  color: pinkColor,
  borderRadius: BorderRadius.circular(20),
);

const TextStyle newQuizButtonTitle =
    TextStyle(color: whiteColor, fontSize: 22.0, fontFamily: 'SourceSansPro');

BoxDecoration answerButtonContainerDecoration = BoxDecoration(
    color: Color(0xFF272E4D),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(width: 1.0, color: dimWhiteColor));

const TextStyle answerButtonTitleStyle = TextStyle(
    color: dimWhiteColor,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSansPro');

const TextStyle timerTextStyle =
    TextStyle(fontSize: 15.0, color: whiteColor, fontWeight: FontWeight.bold);

const TextStyle questionsTextStyle = TextStyle(
    fontSize: 17.0,
    color: whiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSansPro');
BoxDecoration endQuizButtonContainerDecoration = BoxDecoration(
  color: pinkColor,
  borderRadius: BorderRadius.circular(20),
);

const TextStyle endQuizButtonTitleStyle =
    TextStyle(color: whiteColor, fontSize: 17.0, fontFamily: 'SourceSansPro');

const TextStyle errorTextStyle = TextStyle(
  color: dimWhiteColor,
  fontSize: 21.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'SourceSansPro',
);

const TextStyle tryAgainButtonStyle = TextStyle(
    color: dimWhiteColor,
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSansPro');

const TextStyle currentQuestionNumberStyle= TextStyle(color: dimWhiteColor, fontSize: 12.0);
