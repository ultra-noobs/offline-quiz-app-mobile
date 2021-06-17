import 'package:OffQuiz/home/Question/questionCard.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:OffQuiz/model/quiz.dart';
import 'package:OffQuiz/shared/quizAppBar.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  Quiz quiz;
  QuizScreen({required this.quiz});

  List<QuestionCard> questionCards = [];

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  fetchAllQuestions(questions) {
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
    return allQuestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: quizAppBar(widget.quiz.quizName, context, 2),
        body: ListView(
          children: fetchAllQuestions(widget.quiz.questions),
        ));
  }
}
