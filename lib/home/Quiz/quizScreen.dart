import 'package:OffQuiz/home/Question/questionCard.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:OffQuiz/shared/appBar.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  List<Question> questions;
  String quizName;
  QuizScreen({required this.questions, required this.quizName});
  List<QuestionCard> questionCards = [];

  fetchAllQuestions(questions, questionCards) {
    List<QuestionCard> allQuestions = [];
    for (int i = 0; i < questions.length; i++) {
      allQuestions.add(QuestionCard(
        question: questions[i],
        index: (i + 1),
      ));
    }
    if (allQuestions.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Please contact your teacher, he hasn't added any question in the Quiz XD",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }
    return ListView(
      children: allQuestions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(quizName),
      body: fetchAllQuestions(questions, questionCards),
    );
  }
}
