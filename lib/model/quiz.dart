import 'package:OffQuiz/model/question.dart';

class Quiz {
  String quizName;
  String date;
  String time;
  List<Question> questions;
  Quiz(
      {required this.quizName,
      required this.date,
      required this.time,
      required this.questions});
}
