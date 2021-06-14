import 'package:OffQuiz/home/Quiz/quizScreen.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final double pad = 70;
  final double elevation = 4;
  final String quizName;
  final String facultyName;
  final int duration;
  List<Question> questions;
  QuizCard(
      {required this.quizName,
      required this.facultyName,
      required this.questions,
      required this.duration});

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Read this Carefully !!!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "You can attempt the quiz only once. DO NOT close the app while attempting quiz. Are you sure you want to start the quiz?"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizScreen(
                          questions: questions,
                          quizName: quizName,
                          duration: duration,
                        )));
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => QuizScreen(
            //               questions: questions,
            //             )));
          },
          child: const Text('Yes'),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                quizName,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
