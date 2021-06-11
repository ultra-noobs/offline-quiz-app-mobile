import 'package:OffQuiz/model/question.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  Question question;
  int index;
  QuestionCard({required this.question, required this.index});

  fetchOptions() {
    List<Text> listOptions = [];
    for (int i = 0; i < question.options.length; i++) {
      listOptions.add(Text(
        "${String.fromCharCode(i + 97)}. ${question.options[i]}",
        style: TextStyle(fontSize: 16),
      ));
    }
    return listOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q$index) ${question.ques}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fetchOptions())
          ],
        ),
      ),
    );
  }
}
