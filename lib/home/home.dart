import 'dart:convert';

import 'package:OffQuiz/home/Quiz/quizCard.dart';
import 'package:OffQuiz/model/demapping.dart';
import 'package:OffQuiz/model/question.dart';
import 'package:OffQuiz/model/quiz.dart';
import 'package:OffQuiz/shared/appBar.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Quiz> quizzes = [
  //   Quiz(quizName: "EndSem Quiz for CS202", facultyName: "New Kumar"),
  //   Quiz(
  //       quizName: "EndSem Quiz for CS206",
  //       facultyName: "Nomrata Debi cum JaiMaheshmati Mayank"),
  //   Quiz(quizName: "EndSem Quiz for CS204", facultyName: "Space"),
  //   Quiz(quizName: "EndSem Quiz for MA201", facultyName: "Babu Thana Thaya"),
  //   Quiz(quizName: "EndSem Quiz for CS201", facultyName: "Asus Phophalia"),
  //   Quiz(quizName: "EndSem Quiz for EC201", facultyName: "Vimal Kishore Jha2"),
  //   Quiz(quizName: "EndSem Quiz for CS208", facultyName: "Vimal Kishore Jha2"),
  // ];
  // List<Question> questions = [
  //   Question(
  //     ques: "Who invented JavaScript?",
  //     options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
  //   ),
  //   Question(
  //     ques: "Which one of these is a JavaScript package manager?",
  //     options: ["Node.js", "TypeScript", "npm"],
  //   ),
  //   Question(
  //     ques: "Which tool can you use to ensure code quality?",
  //     options: ["Angular", "jQuery", "RequireJS", "ESLint"],
  //   ),
  //   Question(
  //     ques: "Who invented JavaScript?",
  //     options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
  //   ),
  //   Question(
  //     ques: "Which one of these is a JavaScript package manager?",
  //     options: ["Node.js", "TypeScript", "npm"],
  //   ),
  //   Question(
  //     ques: "Which tool can you use to ensure code quality?",
  //     options: ["Angular", "jQuery", "RequireJS", "ESLint"],
  //   ),
  //   Question(
  //     ques: "Who invented JavaScript?",
  //     options: ["Douglas Crockford", "Sheryl Sandberg", "Brendan Eich"],
  //   ),
  //   Question(
  //     ques: "Which one of these is a JavaScript package manager?",
  //     options: ["Node.js", "TypeScript", "npm"],
  //   ),
  //   Question(
  //     ques: "Which tool can you use to ensure code quality?",
  //     options: ["Angular", "jQuery", "RequireJS", "ESLint"],
  //   ),
  // ];
  final telephony = Telephony.instance;
  List<SmsMessage> _messages = [];
  List<String> _quizMessage = [];
  bool? _permissionsGranted;
  int _duration = 7200;
  List<int> _mapping = [
    64,
    59,
    75,
    43,
    41,
    34,
    49,
    94,
    39,
    38,
    61,
    35,
    105,
    47,
    88,
    80,
    32,
    72,
    48,
    52,
    81,
    58,
    102,
    124,
    57,
    111,
    36,
    116,
    46,
    73,
    85,
    104,
    108,
    117,
    109,
    121,
    77,
    70,
    76,
    33,
    51,
    89,
    67,
    126,
    79,
    63,
    66,
    78,
    125,
    90,
    123,
    92,
    40,
    98,
    86,
    114,
    53,
    119,
    60,
    54,
    101,
    45,
    113,
    68,
    84,
    74,
    122,
    120,
    65,
    50,
    44,
    82,
    96,
    62,
    42,
    37,
    87,
    69,
    55,
    112,
    71,
    56,
    91,
    100,
    83,
    107,
    95,
    103,
    110,
    97,
    93,
    118,
    115,
    106,
    99
  ];

  List<Demapping> _demapping = [];
  getDemapping() {
    _demapping = [];
    for (int i = 0; i < _mapping.length; i++) {
      _demapping.add(Demapping(element: _mapping[i], place: i));
    }
  }

  charToAscii(a) {
    return a.codeUnitAt(0);
  }

  asciiToChar(a) {
    return String.fromCharCode(a);
  }

  decryptMessage() {
    for (int i = 0; i < _quizMessage.length; i++) {
      String message = _quizMessage[i];
      String encryptedMsg = "";
      for (int j = 0; j < message.length; j++) {
        var val = charToAscii(message[j]);
        List<Demapping> index;
        index = _demapping.where((data) => data.element == val).toList();
        var value = index[0].place;
        encryptedMsg += asciiToChar(value + 32);
      }
      _quizMessage[i] = encryptedMsg;
    }
  }

  getPermissions(permissionsGranted) async {
    permissionsGranted = await telephony.requestSmsPermissions;
  }

  Future<void> getMessages() async {
    getPermissions(_permissionsGranted);
    _messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("59039000"));
  }

  getQuiz() {
    _quizMessage = [];
    String temp = "Sent from your Twilio trial account";
    int tempLen = temp.length;
    for (int i = 0; i < _messages.length; i++) {
      String temp2 = _messages[i].body.toString().substring(0, tempLen);
      if (temp == temp2) {
        _quizMessage
            .add(_messages[i].body.toString().substring(temp.length + 3));
      }
    }
  }

  de(b) {
    var a, e = {};
    var d = b.split(""), c = d[0], f = d[0], g = [c], h = 256, o = 256;
    for (b = 1; b < d.length; b++) {
      a = d[b].codeUnitAt(0);
      if (h > a) {
        a = d[b];
      } else {
        if (e[a] != null) {
          a = e[a];
        } else {
          a = f + c;
        }
      }
      g.add(a);
      c = a[0];
      e[o] = f + c;
      o++;
      f = a;
    }
    return g.join("");
  }

  @override
  Widget build(BuildContext context) {
    getMessages();
    getQuiz();
    for (int i = 0; i < _quizMessage.length; i++) {
      _quizMessage[i] = de(_quizMessage[i]);
    }
    getDemapping();
    decryptMessage();
    for (int i = 0; i < _quizMessage.length; i++) {
      print(_quizMessage[i]);
    }
    return Scaffold(
      appBar: appBar("OffQuiz"),
      body: ListView(
          // children: quizzes
          //     .map((quiz) => QuizCard(
          //           quizName: quiz.quizName,
          //           facultyName: quiz.facultyName,
          //           questions: questions,
          //           duration: duration,
          //         ))
          //     .toList(),
          children: [Center(child: Text("Incoming Message : "))]),
    );
  }
}
