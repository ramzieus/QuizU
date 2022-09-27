import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quizu/controllers/app_controller.dart';
import 'package:quizu/models/quiz.dart';
import 'package:quizu/pages/components/button.dart';
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
                            duration: 120,
                            initialDuration: 0,
                            controller: CountDownController(),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 3,
                            ringColor: Colors.grey[300]!,
                            ringGradient: null,
                            fillColor: Theme.of(context).primaryColor,
                            fillGradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.red,
                                Colors.purple,
                              ],
                            ),
                            backgroundGradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).secondaryHeaderColor,
                                Theme.of(context).primaryColor,
                              ],
                            ),
                            strokeWidth: 20.0,
                            strokeCap: StrokeCap.round,
                            textStyle: const TextStyle(
                                fontSize: 33.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.MM_SS,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onComplete: () {
                              controller.setScore(sum);
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
                          child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: -8,
                              offset: const Offset(0, 8),
                              color: Colors.black12.withOpacity(0.15),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              quizzes[index].question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      )

                          // Card(
                          //   child: Center(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         quizzes[index].question,
                          //         textAlign: TextAlign.center,
                          //         style: const TextStyle(fontSize: 18),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4.0, top: 18.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FadeInLeft(
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: QButton(
                                  onPressed: () {
                                    _checkAnswer("a");
                                  },
                                  text: quizzes[index].a,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FadeInRight(
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 4.0),
                                child: QButton(
                                  onPressed: () {
                                    _checkAnswer("b");
                                  },
                                  text: quizzes[index].b,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4.0, top: 12.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FadeInLeftBig(
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: QButton(
                                  onPressed: () {
                                    _checkAnswer("c");
                                  },
                                  text: quizzes[index].c,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FadeInRightBig(
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 4.0),
                                child: QButton(
                                  onPressed: () {
                                    _checkAnswer("d");
                                  },
                                  text: quizzes[index].d,
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
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 8),
                      margin: const EdgeInsets.only(top: 18),
                      child: FadeInUpBig(
                        child: QButton(
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
                          text: "Skip 🔥",
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
