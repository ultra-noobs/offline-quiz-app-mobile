import 'package:OffQuiz/home/Quiz/quizScreen.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final double pad = 70;
  final double elevation = 4;
  final String quizName;
  final String facultyName;
  List<Question> questions;
  QuizCard(
      {required this.quizName,
      required this.facultyName,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizScreen(
                      questions: questions,
                      quizName: quizName,
                    )));
        print("Card Clicked!");
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => QuizScreen(
        //               questions: questions,
        //             )));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                quizName,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: pad),
              Text(
                facultyName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
