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
  final telephony = Telephony.instance;
  List<SmsMessage> _messages = [];
  List<String> _quizMessages = [];
  bool? _permissionsGranted;
  List<Question> _questions = [];
  List<Quiz> _quizzes = [];
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
    for (int i = 0; i < _quizMessages.length; i++) {
      String message = _quizMessages[i];
      String encryptedMsg = "";
      for (int j = 0; j < message.length; j++) {
        var val = charToAscii(message[j]);
        List<Demapping> index;
        index = _demapping.where((data) => data.element == val).toList();
        var value = index[0].place;
        encryptedMsg += asciiToChar(value + 32);
      }
      _quizMessages[i] = encryptedMsg;
    }
  }

  doShifting() {
    String temp = "";
    String message = "";
    for (int i = 0; i < _quizMessages.length; i++) {
      temp = "";
      message = _quizMessages[i];
      for (int j = message.length - 18; j < message.length; j++) {
        temp += message[j];
      }
      for (int j = 0; j < message.length - 18; j++) {
        temp += message[j];
      }
      _quizMessages[i] = temp;
    }
  }

  getPermissions(permissionsGranted) async {
    permissionsGranted = await telephony.requestSmsPermissions;
  }

  Future<void> getMessages() async {
    getPermissions(_permissionsGranted);
    _messages = await telephony
        .getInboxSms(columns: [SmsColumn.ADDRESS, SmsColumn.BODY]);
  }

  getQuiz() {
    _quizMessages = [];
    String temp = "Sent from your Twilio trial account";
    int tempLen = temp.length;
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].body.toString().length > 38) {
        String temp2 = _messages[i].body.toString().substring(0, tempLen);
        if (temp == temp2) {
          _quizMessages
              .add(_messages[i].body.toString().substring(temp.length + 3));
        }
      } else {
        continue;
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

  getQuizzes() {
    _quizzes = [];
    for (int i = 0; i < _quizMessages.length; i++) {
      _questions = [];
      String message = _quizMessages[i];
      String quizName = "",
          quizStartTime = "",
          quizDate = "",
          quizEndTime = "",
          phoneNo = "";
      int itr = 0;
      while (message[itr] != "#") {
        quizName += message[itr];
        itr++;
      }
      itr += 2;
      while (message[itr] != "#") {
        quizStartTime += message[itr];
        itr++;
      }
      itr += 2;
      while (message[itr] != "#") {
        quizDate += message[itr];
        itr++;
      }
      itr += 2;
      while (message[itr] != "#") {
        quizEndTime += message[itr];
        itr++;
      }
      itr += 2;
      while (message[itr] != "#") {
        phoneNo += message[itr];
        itr++;
      }
      itr += 4;
      List<String> options = [];
      String question = "";
      String option = "";
      bool flag = true;
      try {
        while (itr < message.length) {
          if (message[itr] == "#") {
            itr += 2;
            if (itr + 1 < message.length && message[itr + 1] == ")") {
              continue;
            } else if (itr <= message.length) {
              options.add(option);
              _questions.add(Question(ques: question, options: options));
              question = "";
              options = [];
              option = "";
              flag = true;
            } else {
              print("This should not be printed ##");
            }
          } else if (!flag) {
            if (itr + 1 < message.length && message[itr + 1] == ")") {
              itr += 2;
              if (option != "") {
                options.add(option);
                option = "";
              }
            }
            option += message[itr];
            itr++;
          } else if (flag) {
            question += message[itr];
            itr++;
            if (itr < message.length && message[itr] == "#") {
              flag = false;
            }
          } else {
            print("This should not be printed !!");
            itr++;
          }
        }
      } catch (e) {
        print(e);
      }
      _quizzes.add(Quiz(
          quizName: quizName,
          date: quizDate,
          startTime: quizStartTime,
          endTime: quizEndTime,
          phoneNo: phoneNo,
          questions: _questions));
    }
  }

  @override
  Widget build(BuildContext context) {
    getMessages();
    getQuiz();
    for (int i = 0; i < _quizMessages.length; i++) {
      _quizMessages[i] = de(_quizMessages[i]);
    }
    getDemapping();
    decryptMessage();
    doShifting();
    getQuizzes();

    return Scaffold(
      appBar: appBar("OffQuiz"),
      body: _quizzes.length != 0
          ? ListView(
              children: _quizzes
                  .map((quiz) => QuizCard(
                        quiz: quiz,
                      ))
                  .toList(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hurray! You do not have any quiz scheduled!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }
}
