import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quizu/pages/components/plasma.dart';
import 'package:quizu/pages/quiz.dart';
import 'package:quizu/pages/utils/constants.dart';

import 'components/button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                """Ready to test your\nknoweldge and challenge\nothers?""",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        const Plasma(),
        Positioned(
          bottom: 0,
          right: 0,
          top: MediaQuery.of(context).size.height / 3,
          left: 0,
          child: Container(
            decoration: decoration,
            padding: const EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "Ready?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(8.0),
                      child: Pulse(
                        infinite: true,
                        child: QButton(
                          onPressed: () {
                            pushReplacement(context, const Quiz());
                          },
                          text: "Quiz Me!",
                          enabled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Answer as much questions\ncorrectly within",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Center(
                      child: Text(
                        "2 minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
