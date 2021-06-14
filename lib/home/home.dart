import 'package:OffQuiz/home/Quiz/quizCard.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:OffQuiz/model/quiz.dart';
import 'package:OffQuiz/shared/appBar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int duration = 7200;
  List<Quiz> quizzes = [
    Quiz(quizName: "EndSem Quiz for CS202", facultyName: "New Kumar"),
    Quiz(
        quizName: "EndSem Quiz for CS206",
        facultyName: "Nomrata Debi cum JaiMaheshmati Mayank"),
    Quiz(quizName: "EndSem Quiz for CS204", facultyName: "Space"),
    Quiz(quizName: "EndSem Quiz for MA201", facultyName: "Babu Thana Thaya"),
    Quiz(quizName: "EndSem Quiz for CS201", facultyName: "Asus Phophalia"),
    Quiz(quizName: "EndSem Quiz for EC201", facultyName: "Vimal Kishore Jha2"),
    Quiz(quizName: "EndSem Quiz for CS208", facultyName: "Vimal Kishore Jha2"),
  ];
  List<Question> questions = [
    Question(
      ques: "Who invented JavaScript?",
      options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
    ),
    Question(
      ques: "Which one of these is a JavaScript package manager?",
      options: ["Node.js", "TypeScript", "npm"],
    ),
    Question(
      ques: "Which tool can you use to ensure code quality?",
      options: ["Angular", "jQuery", "RequireJS", "ESLint"],
    ),
    Question(
      ques: "Who invented JavaScript?",
      options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
    ),
    Question(
      ques: "Which one of these is a JavaScript package manager?",
      options: ["Node.js", "TypeScript", "npm"],
    ),
    Question(
      ques: "Which tool can you use to ensure code quality?",
      options: ["Angular", "jQuery", "RequireJS", "ESLint"],
    ),
    Question(
      ques: "Who invented JavaScript?",
      options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
    ),
    Question(
      ques: "Which one of these is a JavaScript package manager?",
      options: ["Node.js", "TypeScript", "npm"],
    ),
    Question(
      ques: "Which tool can you use to ensure code quality?",
      options: ["Angular", "jQuery", "RequireJS", "ESLint"],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("OffQuiz"),
      body: ListView(
        children: quizzes
            .map((quiz) => QuizCard(
                  quizName: quiz.quizName,
                  facultyName: quiz.facultyName,
                  questions: questions,
                  duration: duration,
                ))
            .toList(),
      ),
    );
  }
}
