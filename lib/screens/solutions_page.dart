import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/quiz.dart';
import 'package:html_character_entities/html_character_entities.dart';

class SolutionsPage extends StatefulWidget {
  final List<Results> results;
  final List<String> chosenAnswersList;
  SolutionsPage({this.results, this.chosenAnswersList});
  @override
  _SolutionsPageState createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solutions', style: appBarStyle)),
      body: ListView.builder(
          itemCount: widget.results.length,
          itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              HtmlCharacterEntities.decode(
                                  '${i + 1} .  ${widget.results[i].question}'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'SourceSansPro')),
                        ),
                        FilterChip(
                            backgroundColor: Colors.white,
                            onSelected: (b) {},
                            label: Text(
                                HtmlCharacterEntities.decode(
                                    'Your answer: ${widget.chosenAnswersList[i]}'),
                                style: TextStyle(color: Colors.black))),
                        FilterChip(
                          backgroundColor: Colors.green,
                          onSelected: (b) {},
                          label: Text(
                              HtmlCharacterEntities.decode(
                                  'Correct answer : ${widget.results[i].correctAnswer}'),
                              style: TextStyle(color: Colors.black)),
                        ),
                      ]),
                ),
              )),
      backgroundColor: deepPurpleColor,
    );
  }
}
