class QuestionType {
  String questionType;
  int questionID;
  QuestionType({this.questionType, this.questionID});
}

List<QuestionType> questionTypeList = [
  QuestionType(questionType: 'General Knowledge', questionID: 9),
  QuestionType(questionType: 'Entertainment: Books', questionID: 10),
  QuestionType(questionType: 'Entertainment: Film', questionID: 11),
  QuestionType(questionType: 'Entertainment: Music', questionID: 12),
  QuestionType(questionType: 'Entertainment: Television', questionID: 14),
  QuestionType(questionType: 'Science & Nature', questionID: 17),
  QuestionType(questionType: 'Science: Computers', questionID: 18),
  /*QuestionType(questionType: 'Science: Mathematics', questionID: 19),*/
  QuestionType(questionType: 'Mythology', questionID: 20),
  QuestionType(questionType: 'Sports', questionID: 21),
  QuestionType(questionType: 'Geography', questionID: 22),
  QuestionType(questionType: 'History', questionID: 23),
  /* QuestionType(questionType: 'Politics', questionID: 24),*/
  /* QuestionType(questionType: 'Arts', questionID: 25),*/
  /* QuestionType(questionType: 'Celebrities', questionID: 26),*/
  QuestionType(questionType: 'Animals', questionID: 27),
  QuestionType(questionType: 'Vehicles', questionID: 28),
  QuestionType(questionType: 'Entertainment: Comics', questionID: 29),
  /* QuestionType(questionType: 'Science: Gadget', questionID: 30),*/
  QuestionType(questionType: 'Entertainment: Japanese Anime', questionID: 31),
];

class Results {
  String question;
  String correctAnswer;
  List<String> allAnswers;

  Results.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correct_answer'];
    allAnswers = json['incorrect_answers'].cast<String>();
    allAnswers.add(correctAnswer); //adds correctAnswer to allAnswers
    allAnswers
        .shuffle(); //Shuffles the elements of this list randomly so that correctAnswer does not always take the last index .
  }
}

//helps to create a list of results 
class Quiz {
  int responseCode;
  List<Results> results; //

  Quiz({this.responseCode, this.results});

  Quiz.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v)); //adds each result to results list
      });
    }
  }
}
