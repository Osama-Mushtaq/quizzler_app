import 'package:flutter/material.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Widget> scores = [];
  Brain quiz_brain = Brain();
  void checkans(bool b) {
    if (b == quiz_brain.answ()) {
      setState(() {
        scores.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      });
    } else {
      setState(() {
        scores.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      });
    }
    quiz_brain.next();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quiz_brain.ques(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                bool answer = quiz_brain.answ();
                checkans(answer);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                bool answer = quiz_brain.answ();
                checkans(answer);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scores,
        ),
      ],
    );
  }
}

class Quizquestions {
  late String myquestions;
  late bool myanswers;
  Quizquestions(String s, bool b) {
    myquestions = s;
    myanswers = b;
  }
}

class Brain {
  int _question_num = 0;
  List<Quizquestions> _questions_list = [
    Quizquestions('You can lead a cow upstairs but not down stairs', false),
    Quizquestions(
        'Approximately one quarter of human bones are in the feet', true),
    Quizquestions('A slug\'s blud is green', true),
  ];

  String ques() {
    return _questions_list[_question_num].myquestions;
  }

  bool answ() {
    return _questions_list[_question_num].myanswers;
  }

  void next() {
    if (_question_num +1 < _questions_list.length) {
      _question_num++;
    }
    else
    {
      print('You have reached the end');
    }
  }
}
