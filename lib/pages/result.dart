import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/pages/components/button.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/components/result.dart';
import 'package:quizu/pages/utils/constants.dart';
import 'package:share_plus/share_plus.dart';

import 'home_page.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.score});

  final int score;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final GlobalKey genKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          const Plasma(),
          Positioned(
            left: 0,
            right: 0,
            top: 40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80),
                        ),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                      child: IconButton(
                        onPressed: () {
                          pushReplacement(context, const MyHomePage());
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomPaint(
                  painter: ResultShape(),
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(
                        '🏁',
                        style: TextStyle(fontSize: 42),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 18.0, top: 4.0, bottom: 4.0),
                    child: Text(
                      "⭐ ${widget.score.toString()}",
                      style:
                          const TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 3,
            child: Container(
              decoration: decoration,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child:
                        Lottie.asset('assets/animations/congratulations.json'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 8.0),
                        child: Text(
                          "Congratulations",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          """You have completed ${widget.score.toString()} correct\nanswers!""",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(top: 18),
                        child: QButton(
                          onPressed: () {
                            Share.share(
                                'I answered ${widget.score} correct answers in QuizU!');
                          },
                          text: "Share 🚀",
                          enabled: true,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
