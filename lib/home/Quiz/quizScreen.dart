import 'package:OffQuiz/home/Question/questionCard.dart';
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
    return ListView(children: allQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: quizAppBar("OffQuiz", context, 7200),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.quiz.quizName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: fetchAllQuestions(widget.quiz.questions),
            ),
          ),
        ],
      ),
    );
  }
}
