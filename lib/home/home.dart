import 'package:OffQuiz/home/quizCard.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("OffQuiz"),
      body: ListView(
        children: quizzes
            .map((quiz) => QuizCard(
                quizName: quiz.quizName, facultyName: quiz.facultyName))
            .toList(),
      ),
    );
  }
}
