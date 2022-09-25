import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/models/quiz.dart';
import 'package:quizu/pages/home_page.dart';
import 'package:quizu/pages/result.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool loading = false;
  Controller controller = Controller();
  List<QuizModel> quizzes = [];
  int index = 0;
  int sum = 0;
  bool fault = false;

  _getQuestions() async {
    setState(() {
      loading = true;
    });
    quizzes = await controller.getQuestions();
    setState(() {
      loading = false;
    });
  }

  _checkAnswer(String answer) {
    if (quizzes[index].correct == answer) {
      sum++;
      setState(() {
        if (index < quizzes.length - 1) {
          index++;
        } else {
          controller.setScore(sum);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Result(score: sum),
            ),
          );
        }
      });
    } else {
      setState(() {
        fault = true;
      });
      controller.setScore(sum);
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Result(score: sum),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    _getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : fault
              ? Center(
                  child: FadeInDown(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 18.0, bottom: 18.0),
                          child: BounceInUp(
                            child: const Text(
                              "😢",
                              style: TextStyle(fontSize: 60),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Wrong Answer",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    FadeInDown(
                      child: Pulse(
                        infinite: true,
                        delay: const Duration(seconds: 110),
                        child: CircularCountDownTimer(
                            duration: 2 * 60,
                            initialDuration: 0,
                            controller: CountDownController(),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 3,
                            ringColor: Colors.grey[300]!,
                            ringGradient: null,
                            fillColor: Theme.of(context).primaryColor,
                            fillGradient: null,
                            backgroundColor:
                                Theme.of(context).secondaryHeaderColor,
                            backgroundGradient: null,
                            strokeWidth: 20.0,
                            strokeCap: StrokeCap.round,
                            textStyle: TextStyle(
                                fontSize: 33.0,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.MM_SS,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onComplete: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Result(score: sum),
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      margin: const EdgeInsets.all(8.0),
                      child: FadeInDown(
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                quizzes[index].question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FadeInLeft(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _checkAnswer("a");
                                  },
                                  child: Text(quizzes[index].a),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FadeInRight(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _checkAnswer("b");
                                  },
                                  child: Text(quizzes[index].b),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FadeInLeftBig(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _checkAnswer("c");
                                  },
                                  child: Text(quizzes[index].c),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FadeInRightBig(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _checkAnswer("d");
                                  },
                                  child: Text(quizzes[index].d),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 60,
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 18),
                      child: FadeInUpBig(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (index < quizzes.length - 1) {
                                index++;
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Result(score: sum),
                                  ),
                                );
                                controller.setScore(sum);
                              }
                            });
                          },
                          child: const Text("Skip 🔥"),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
